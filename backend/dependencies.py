from collections.abc import AsyncGenerator

from fastapi import Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

import config
from ai.mock_provider import MockProvider
from ai.openai_provider import OpenAIProvider
from ai.provider import AIProvider
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
    if config.USE_MOCK_AI:
        return MockProvider()
    return OpenAIProvider(api_key=config.OPENAI_API_KEY, model=config.OPENAI_MODEL)


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


async def require_educator_or_admin(
    current_user: User = Depends(get_current_user),
) -> User:
    if current_user.role not in ("educator", "admin"):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Educator or admin role required",
        )
    return current_user
