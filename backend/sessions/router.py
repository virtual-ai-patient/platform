from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from core.provider import AIProvider
from cases.repository import CaseRepository
from cases.router import get_case_repo
from dependencies import get_ai_provider, get_current_user, get_db
from exceptions.auth_exceptions import ForbiddenError, NotFoundError
from models.db import User
from sessions import service
from sessions.chat_repository import ActionLogRepository
from sessions.chat_request import ChatRequest
from sessions.chat_response import ChatResponse
from sessions.chat_service import chat
from sessions.diagnostics_request import OrderTestRequest
from sessions.diagnostics_response import AvailableTestsResponse, TestResultResponse
from sessions.diagnostics_service import get_available_tests, order_test
from sessions.repository import SessionRepository
from sessions.request import StartSessionRequest
from sessions.response import SessionResponse

router = APIRouter(prefix="/sessions", tags=["sessions"])


def get_session_repo(db: AsyncSession = Depends(get_db)) -> SessionRepository:
    return SessionRepository(db)


def get_log_repo(db: AsyncSession = Depends(get_db)) -> ActionLogRepository:
    return ActionLogRepository(db)


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
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)
        ) from exc
    except ForbiddenError as exc:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail=str(exc)
        ) from exc


@router.get("/{session_id}/available-tests", response_model=AvailableTestsResponse)
async def available_tests(
    session_id: str,
    current_user: User = Depends(get_current_user),
    session_repo: SessionRepository = Depends(get_session_repo),
) -> AvailableTestsResponse:
    try:
        return await get_available_tests(session_id, current_user, session_repo)
    except NotFoundError as exc:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)
        ) from exc
    except ForbiddenError as exc:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail=str(exc)
        ) from exc


@router.post("/{session_id}/order-test", response_model=TestResultResponse)
async def order_test_endpoint(
    session_id: str,
    data: OrderTestRequest,
    current_user: User = Depends(get_current_user),
    session_repo: SessionRepository = Depends(get_session_repo),
    log_repo: ActionLogRepository = Depends(get_log_repo),
) -> TestResultResponse:
    try:
        return await order_test(
            session_id, data.test_id, current_user, session_repo, log_repo
        )
    except NotFoundError as exc:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)
        ) from exc
    except ForbiddenError as exc:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail=str(exc)
        ) from exc


@router.post("/{session_id}/chat", response_model=ChatResponse)
async def chat_with_patient(
    session_id: str,
    data: ChatRequest,
    current_user: User = Depends(get_current_user),
    session_repo: SessionRepository = Depends(get_session_repo),
    log_repo: ActionLogRepository = Depends(get_log_repo),
    ai_provider: AIProvider = Depends(get_ai_provider),
) -> ChatResponse:
    try:
        return await chat(
            session_id, data.message, current_user, session_repo, log_repo, ai_provider
        )
    except NotFoundError as exc:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)
        ) from exc
    except ForbiddenError as exc:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail=str(exc)
        ) from exc
