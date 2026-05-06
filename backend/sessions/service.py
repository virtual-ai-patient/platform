import json

from cases.repository import CaseRepository
from cases.service import _to_response
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
from sessions.response import ConclusionsResponse, SessionResponse


async def start_session(
    case_id: str,
    current_user: User,
    case_repo: CaseRepository,
    session_repo: SessionRepository,
) -> SessionResponse:
    case = await case_repo.get_by_case_id(case_id)
    if case is None:
        raise NotFoundError(f"Case '{case_id}' not found")

    if case.status != "published" and current_user.role == "learner":
        raise ForbiddenError("Learners can only start published cases")

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

    return ConclusionsResponse(
        session_id=session_id,
        status=updated.status,
        conclusions=updated.conclusions,
    )
