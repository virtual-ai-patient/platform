import logging

import config
from core.ai_orchestrator import run_turn
from core.provider import AIProvider
from exceptions.auth_exceptions import ForbiddenError, NotFoundError
from models.db import User
from sessions.chat_repository import ActionLogRepository
from sessions.chat_response import ChatResponse
from sessions.repository import SessionRepository

logger = logging.getLogger(__name__)


async def chat(
    session_id: str,
    message: str,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
    ai_provider: AIProvider,
) -> ChatResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id:
        raise ForbiddenError("You do not have access to this session")

    history = await log_repo.get_history(session_id)
    turn = await run_turn(
        snapshot=session.frozen_case_snapshot,
        history_before_user_message=history,
        user_message=message,
        provider=ai_provider,
    )
    logger.info(
        "chat_complete session_id=%s provider=%s latency_ms=%.1f",
        session_id,
        config.resolved_ai_provider(),
        turn.latency_ms,
    )
    await log_repo.create(session_id, "user", message)
    assistant_log = await log_repo.create(session_id, "assistant", turn.text)

    return ChatResponse(response=turn.text, logged_at=assistant_log.created_at)
