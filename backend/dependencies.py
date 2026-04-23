from collections.abc import AsyncGenerator

from fastapi import Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

import config
from core.mock_provider import MockProvider
from core.openai_provider import OpenAIProvider
from core.provider import AIProvider
from services.utils.auth import oauth2_scheme
from models.database import SessionLocal
from exceptions.auth_exceptions import AuthenticationError
from models.db import User
from repositories.reset_token_repository import ResetTokenRepository
from repositories.user_repository import UserRepository
from services.auth_service import AuthService


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with SessionLocal() as session:
        yield session


def get_user_repo(db: AsyncSession = Depends(get_db)) -> UserRepository:
    return UserRepository(db)


def get_reset_token_repo(db: AsyncSession = Depends(get_db)) -> ResetTokenRepository:
    return ResetTokenRepository(db)


def get_auth_service(
    user_repo: UserRepository = Depends(get_user_repo),
    reset_token_repo: ResetTokenRepository = Depends(get_reset_token_repo),
) -> AuthService:
    return AuthService(user_repo, reset_token_repo)


def get_ai_provider() -> AIProvider:
    name = config.resolved_ai_provider()
    if name == "mock":
        return MockProvider()
    extra: dict[str, str] = {}
    if config.OPENROUTER_HTTP_REFERER.strip():
        extra["HTTP-Referer"] = config.OPENROUTER_HTTP_REFERER.strip()
    if config.OPENROUTER_APP_NAME.strip():
        extra["X-Title"] = config.OPENROUTER_APP_NAME.strip()
    return OpenAIProvider(
        api_key=config.OPENAI_API_KEY,
        model=config.OPENAI_MODEL,
        base_url=config.OPENAI_BASE_URL,
        default_headers=extra or None,
        max_tokens=config.OPENAI_MAX_TOKENS,
        timeout=config.OPENAI_TIMEOUT_SEC,
    )


async def get_current_user(
    token: str = Depends(oauth2_scheme),
    auth_service: AuthService = Depends(get_auth_service),
) -> User:
    try:
        return await auth_service.get_user_from_access_token(token)
    except AuthenticationError as exc:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail=str(exc)
        ) from exc
