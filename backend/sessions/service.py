import json
import logging

from config import EVALUATION_AUTO_SCORE
from cases.repository import CaseRepository
from cases.service import _to_response
from evaluation.repository import EvaluationRepository
from evaluation.service import score_session as run_score_session
from exceptions.auth_exceptions import (
    BadRequestError,
    ConflictError,
    ForbiddenError,
    NotFoundError,
)
from models.db import User
from sessions.chat_repository import ActionLogRepository
from sessions.repository import SessionRepository
from sessions.request import ConclusionsRequest
from sessions.response import (
    ActiveSessionItem,
    ChatMessage,
    ConclusionsResponse,
    ProgressSummary,
    SessionResponse,
    SessionStateResponse,
)

_HISTORY_PAGE_SIZE = 50
logger = logging.getLogger(__name__)


async def start_session(
    case_id: str,
    current_user: User,
    case_repo: CaseRepository,
    session_repo: SessionRepository,
    force: bool = False,
) -> SessionResponse:
    case = await case_repo.get_by_case_id(case_id)
    if case is None:
        raise NotFoundError(f"Case '{case_id}' not found")

    if case.status != "published" and current_user.role == "learner":
        raise ForbiddenError("Learners can only start published cases")

    existing = await session_repo.get_active_by_user_and_case(current_user.id, case.id)
    if existing is not None:
        if not force:
            raise ConflictError(existing.session_id)
        await session_repo.update_status(existing.session_id, "abandoned")

    snapshot = _to_response(case).model_dump(mode="json")
    session = await session_repo.create(
        user_id=current_user.id,
        clinical_case_id=case.id,
        snapshot=snapshot,
    )
    return SessionResponse(
        session_id=session.session_id,
        case_id=case_id,
        status=session.status,
        created_at=session.created_at,
        last_activity_at=session.last_activity_at,
    )


async def list_active_sessions(
    user_id: str,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
) -> list[ActiveSessionItem]:
    sessions = await session_repo.list_active_by_user(user_id)
    items: list[ActiveSessionItem] = []
    for s in sessions:
        turn_count = await log_repo.count_by_session(s.session_id)
        items.append(
            ActiveSessionItem(
                session_id=s.session_id,
                case_id=str(s.frozen_case_snapshot.get("case_id", "")),
                case_title=str(s.frozen_case_snapshot.get("title", "")),
                created_at=s.created_at,
                last_activity_at=s.last_activity_at,
                progress_summary=ProgressSummary(
                    turn_count=turn_count,
                    has_conclusions=bool(s.conclusions),
                ),
            )
        )
    return items


async def get_session_state(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
    cursor: int = 0,
) -> SessionStateResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id and current_user.role != "admin":
        raise ForbiddenError("You do not have access to this session")

    page = await log_repo.get_history_page(
        session_id, limit=_HISTORY_PAGE_SIZE, offset=cursor
    )
    next_cursor = (
        cursor + _HISTORY_PAGE_SIZE if len(page) == _HISTORY_PAGE_SIZE else None
    )

    ordered_tests = await log_repo.get_ordered_tests(session_id)

    return SessionStateResponse(
        session_id=session_id,
        status=session.status,
        created_at=session.created_at,
        last_activity_at=session.last_activity_at,
        case_snapshot=dict(session.frozen_case_snapshot),
        chat_history=[
            ChatMessage(role=log.role, content=log.content, logged_at=log.created_at)
            for log in page
        ],
        next_cursor=next_cursor,
        ordered_tests=ordered_tests,
        conclusions=session.conclusions,
    )


async def abandon_session(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
) -> ConclusionsResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id and current_user.role != "admin":
        raise ForbiddenError("You do not have access to this session")
    if session.status != "active":
        raise ConflictError("Session is not active")

    updated = await session_repo.update_status(session_id, "abandoned")
    assert updated is not None

    await log_repo.create(
        session_id=session_id,
        role="learner",
        content=json.dumps({"action": "abandon_session"}),
    )

    return ConclusionsResponse(
        session_id=session_id,
        status=updated.status,
        conclusions=updated.conclusions,
    )


async def save_conclusions(
    session_id: str,
    data: ConclusionsRequest,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
) -> ConclusionsResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id:
        raise ForbiddenError("You do not own this session")
    if session.status != "active":
        raise ConflictError("Session is no longer active")

    existing: dict[str, object] = (
        dict(session.conclusions) if session.conclusions else {}
    )
    patch = data.model_dump(exclude_none=True, mode="json")
    existing.update(patch)

    updated = await session_repo.update_conclusions(session_id, existing)
    assert updated is not None

    await session_repo.touch(session_id)

    await log_repo.create(
        session_id=session_id,
        role="learner",
        content=json.dumps({"action": "save_conclusions", "patch": patch}),
    )

    return ConclusionsResponse(
        session_id=session_id,
        status=updated.status,
        conclusions=updated.conclusions,
    )


async def finish_session(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
    eval_repo: EvaluationRepository | None = None,
) -> ConclusionsResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id:
        raise ForbiddenError("You do not own this session")
    if session.status != "active":
        raise ConflictError("Session is already completed or abandoned")

    conclusions = session.conclusions or {}
    if not conclusions.get("final_diagnosis"):
        raise BadRequestError("A final diagnosis is required before finishing the case")

    updated = await session_repo.update_status(session_id, "completed")
    assert updated is not None

    await log_repo.create(
        session_id=session_id,
        role="learner",
        content=json.dumps({"action": "finish_session"}),
    )

    if EVALUATION_AUTO_SCORE and eval_repo is not None:
        try:
            await run_score_session(session_id, session_repo, log_repo, eval_repo)
        except Exception:
            logger.exception("Auto-scoring failed for session %s", session_id)

    return ConclusionsResponse(
        session_id=session_id,
        status=updated.status,
        conclusions=updated.conclusions,
    )
