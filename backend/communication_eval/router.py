from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from communication_eval import service
from communication_eval.repository import CommunicationEvaluationRepository
from communication_eval.response import CommunicationEvaluationResponse
from core.provider import AIProvider
from dependencies import get_current_user, get_db, get_judge_provider
from exceptions.auth_exceptions import (
    ConflictError,
    ForbiddenError,
    JudgeError,
    NotFoundError,
)
from models.db import User
from sessions.chat_repository import ActionLogRepository
from sessions.repository import SessionRepository

router = APIRouter(tags=["communication-evaluation"])


def get_session_repo(db: AsyncSession = Depends(get_db)) -> SessionRepository:
    return SessionRepository(db)


def get_log_repo(db: AsyncSession = Depends(get_db)) -> ActionLogRepository:
    return ActionLogRepository(db)


def get_comm_eval_repo(
    db: AsyncSession = Depends(get_db),
) -> CommunicationEvaluationRepository:
    return CommunicationEvaluationRepository(db)


@router.post(
    "/{session_id}/communication-evaluation",
    response_model=CommunicationEvaluationResponse,
)
async def trigger_communication_evaluation(
    session_id: str,
    current_user: User = Depends(get_current_user),
    session_repo: SessionRepository = Depends(get_session_repo),
    log_repo: ActionLogRepository = Depends(get_log_repo),
    comm_eval_repo: CommunicationEvaluationRepository = Depends(get_comm_eval_repo),
    provider: AIProvider = Depends(get_judge_provider),
) -> CommunicationEvaluationResponse:
    try:
        return await service.run_communication_evaluation(
            session_id,
            current_user,
            session_repo,
            log_repo,
            comm_eval_repo,
            provider,
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
    except JudgeError as exc:
        raise HTTPException(
            status_code=status.HTTP_502_BAD_GATEWAY, detail=str(exc)
        ) from exc


@router.get(
    "/{session_id}/communication-evaluation",
    response_model=CommunicationEvaluationResponse,
)
async def get_communication_evaluation(
    session_id: str,
    current_user: User = Depends(get_current_user),
    session_repo: SessionRepository = Depends(get_session_repo),
    comm_eval_repo: CommunicationEvaluationRepository = Depends(get_comm_eval_repo),
) -> CommunicationEvaluationResponse:
    try:
        return await service.get_communication_evaluation(
            session_id, current_user, session_repo, comm_eval_repo
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
