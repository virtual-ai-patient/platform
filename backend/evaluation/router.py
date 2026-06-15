from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from dependencies import get_current_user, get_db
from evaluation import service
from evaluation.repository import EvaluationRepository
from evaluation.response import DebriefResponse, ScoresResponse
from exceptions.auth_exceptions import ConflictError, ForbiddenError, NotFoundError
from models.db import User
from sessions.repository import SessionRepository

router = APIRouter(tags=["evaluation"])


def get_session_repo(db: AsyncSession = Depends(get_db)) -> SessionRepository:
    return SessionRepository(db)


def get_eval_repo(db: AsyncSession = Depends(get_db)) -> EvaluationRepository:
    return EvaluationRepository(db)


@router.get("/{session_id}/scores", response_model=ScoresResponse)
async def get_scores(
    session_id: str,
    current_user: User = Depends(get_current_user),
    session_repo: SessionRepository = Depends(get_session_repo),
    eval_repo: EvaluationRepository = Depends(get_eval_repo),
) -> ScoresResponse:
    try:
        return await service.get_scores(
            session_id, current_user, session_repo, eval_repo
        )
    except NotFoundError as exc:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)
        ) from exc
    except ForbiddenError as exc:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail=str(exc)
        ) from exc
    except ConflictError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc


@router.get("/{session_id}/debrief", response_model=DebriefResponse)
async def get_debrief(
    session_id: str,
    current_user: User = Depends(get_current_user),
    session_repo: SessionRepository = Depends(get_session_repo),
    eval_repo: EvaluationRepository = Depends(get_eval_repo),
) -> DebriefResponse:
    try:
        return await service.get_debrief(
            session_id, current_user, session_repo, eval_repo
        )
    except NotFoundError as exc:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)
        ) from exc
    except ForbiddenError as exc:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail=str(exc)
        ) from exc
    except ConflictError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc
