from cases.repository import CaseRepository
from cases.service import _to_response
from exceptions.auth_exceptions import ForbiddenError, NotFoundError
from models.db import User
from sessions.repository import SessionRepository
from sessions.response import SessionResponse


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
