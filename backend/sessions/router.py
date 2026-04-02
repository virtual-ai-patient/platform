from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from cases.repository import CaseRepository
from cases.router import get_case_repo
from dependencies import get_current_user, get_db
from exceptions.auth_exceptions import ForbiddenError, NotFoundError
from models.db import User
from sessions import service
from sessions.repository import SessionRepository
from sessions.request import StartSessionRequest
from sessions.response import SessionResponse

router = APIRouter(prefix="/sessions", tags=["sessions"])


def get_session_repo(db: AsyncSession = Depends(get_db)) -> SessionRepository:
    return SessionRepository(db)


@router.post(
    "/start",
    response_model=SessionResponse,
    status_code=status.HTTP_201_CREATED,
)
async def start_session(
    data: StartSessionRequest,
    current_user: User = Depends(get_current_user),
    case_repo: CaseRepository = Depends(get_case_repo),
    session_repo: SessionRepository = Depends(get_session_repo),
) -> SessionResponse:
    try:
        return await service.start_session(
            data.case_id, current_user, case_repo, session_repo
        )
    except NotFoundError as exc:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)) from exc
    except ForbiddenError as exc:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail=str(exc)) from exc
