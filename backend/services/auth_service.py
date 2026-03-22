import logging
from datetime import datetime, timedelta, timezone

import jwt

from services.utils.auth import (
    RESET_TOKEN_EXPIRE_MINUTES,
    create_access_token,
    create_refresh_token,
    decode_token,
    generate_reset_token,
    hash_password,
    verify_password,
    verify_reset_token,
)
from config import FRONTEND_URL
from services.utils.email_utils import send_reset_email
from exceptions.auth_exceptions import (
    AuthenticationError,
    BadRequestError,
    ConflictError,
)
from models.db import User
from models.response import TokenResponse
from repositories.reset_token_repository import ResetTokenRepository
from repositories.user_repository import UserRepository

logger = logging.getLogger(__name__)


class AuthService:
    def __init__(
        self, user_repo: UserRepository, reset_token_repo: ResetTokenRepository
    ) -> None:
        self._users = user_repo
        self._tokens = reset_token_repo

    async def signup(self, username: str, email: str, password: str) -> User:
        if await self._users.exists_by_username_or_email(username, email):
            raise ConflictError("Username or email already registered")
        user = await self._users.create(username, email, hash_password(password))
        logger.info("New user registered: %s", user.username)
        return user

    async def authenticate(self, username: str, password: str) -> User:
        user = await self._users.get_by_username(username)
        if user is None or not verify_password(password, user.hashed_password):
            logger.warning("Failed login attempt for username: %s", username)
            raise AuthenticationError("Invalid username or password")
        logger.info("Successful login: %s", user.username)
        return user

    def build_tokens(self, user: User) -> TokenResponse:
        return TokenResponse(
            access_token=create_access_token(user.username, user.role),
            refresh_token=create_refresh_token(user.username),
        )

    async def refresh_tokens(self, refresh_token: str) -> TokenResponse:
        try:
            decoded = decode_token(refresh_token)
        except jwt.InvalidTokenError as exc:
            raise AuthenticationError(str(exc)) from exc
        if decoded.get("type") != "refresh":
            raise AuthenticationError("Invalid token type")
        user = await self._users.get_by_username(str(decoded.get("sub", "")))
        if user is None:
            raise AuthenticationError("User not found")
        return self.build_tokens(user)

    async def get_user_from_access_token(self, token: str) -> User:
        try:
            decoded = decode_token(token)
        except jwt.InvalidTokenError as exc:
            raise AuthenticationError(str(exc)) from exc
        if decoded.get("type") != "access":
            raise AuthenticationError("Invalid token type")
        username = decoded.get("sub")
        if not isinstance(username, str):
            raise AuthenticationError("Invalid token payload")
        user = await self._users.get_by_username(username)
        if user is None:
            raise AuthenticationError("User not found")
        return user

    async def request_password_reset(self, email: str) -> None:
        user = await self._users.get_by_email(email)
        if user is None:
            return  # enumeration protection
        plain_token, token_hash = generate_reset_token()
        expires_at = datetime.now(timezone.utc) + timedelta(
            minutes=RESET_TOKEN_EXPIRE_MINUTES
        )
        await self._tokens.create(user.id, token_hash, expires_at)
        reset_link = f"{FRONTEND_URL}/reset-password?token={plain_token}"
        send_reset_email(user.email, reset_link)
        logger.info("Password reset requested for user: %s", user.username)

    async def confirm_password_reset(self, token: str, new_password: str) -> None:
        candidates = await self._tokens.get_active_tokens()
        matched = next(
            (t for t in candidates if verify_reset_token(token, t.token_hash)), None
        )
        if matched is None:
            raise BadRequestError("Invalid or expired reset token")
        await self._tokens.mark_used(matched)
        user = await self._users.get_by_id(matched.user_id)
        assert user is not None  # FK constraint guarantees existence
        await self._users.update_password(user, hash_password(new_password))
        logger.info("Password reset successful for user_id: %s", matched.user_id)
