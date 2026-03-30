import hashlib
from typing import Any, Dict

import httpx


class BackendClient:
    def __init__(self, base_url: str, secret_salt: str) -> None:
        self._base_url = base_url
        self._salt = secret_salt

    def _tg_password(self, telegram_user_id: int) -> str:
        """Derive a stable, secret password for a Telegram user.

        Uses HMAC-like SHA-256 with the bot token as salt so the same
        password is always produced for the same user_id without storing it.
        """
        raw = f"{self._salt}:{telegram_user_id}"
        return hashlib.sha256(raw.encode()).hexdigest()[:32]

    async def login(self, username: str, password: str) -> str:
        """Authenticate with backend using form data. Returns access_token."""
        async with httpx.AsyncClient(base_url=self._base_url, timeout=10.0) as client:
            response = await client.post(
                "/auth/login",
                data={"username": username, "password": password},
            )
            response.raise_for_status()
            data: Dict[str, Any] = response.json()
            token = data.get("access_token")
            if not isinstance(token, str):
                raise RuntimeError("Backend did not return access_token")
            return token

    async def signup(
        self, username: str, email: str, password: str
    ) -> Dict[str, Any]:
        """Register a new user. Returns UserResponse dict."""
        async with httpx.AsyncClient(base_url=self._base_url, timeout=10.0) as client:
            response = await client.post(
                "/auth/signup",
                json={"username": username, "email": email, "password": password},
            )
            response.raise_for_status()
            result: Dict[str, Any] = response.json()
            return result

    async def auto_register_and_login(self, telegram_user_id: int) -> str:
        """Ensure a backend account exists for this Telegram user and return access_token.

        Uses a deterministic username and password derived from telegram_user_id
        so re-login is possible even after the in-memory token is lost.
        """
        username = f"tg_{telegram_user_id}"
        email = f"tg_{telegram_user_id}@bot.internal"
        password = self._tg_password(telegram_user_id)

        try:
            await self.signup(username, email, password)
        except httpx.HTTPStatusError as exc:
            if exc.response.status_code != 409:
                raise
            # 409 = already registered, proceed to login

        return await self.login(username, password)

    async def verify(self, token: str) -> Dict[str, Any]:
        """Verify token and return UserResponse dict (id, username, email, role)."""
        async with httpx.AsyncClient(base_url=self._base_url, timeout=10.0) as client:
            response = await client.get(
                "/auth/verify",
                headers={"Authorization": f"Bearer {token}"},
            )
            response.raise_for_status()
            result: Dict[str, Any] = response.json()
            return result
