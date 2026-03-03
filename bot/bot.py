import asyncio
from typing import Any, Dict, cast

import httpx
from aiogram import Bot, Dispatcher
from aiogram.filters import CommandStart
from aiogram.types import Message

from bot_config import Settings


async def login_to_backend(settings: Settings) -> str:
    async with httpx.AsyncClient(
        base_url=settings.backend_base_url, timeout=10.0
    ) as client:
        response = await client.post(
            "/login",
            json={
                "username": settings.backend_username,
                "password": settings.backend_password,
            },
        )
        response.raise_for_status()
        data = cast(Dict[str, Any], response.json())
        token = data.get("access_token")
        if not isinstance(token, str):
            raise RuntimeError("Backend did not return access_token")
        return token


async def fetch_current_user(settings: Settings, token: str) -> Dict[str, Any]:
    async with httpx.AsyncClient(
        base_url=settings.backend_base_url, timeout=10.0
    ) as client:
        response = await client.get(
            "/me",
            headers={"Authorization": f"Bearer {token}"},
        )
        response.raise_for_status()
        return cast(Dict[str, Any], response.json())


async def main() -> None:
    settings = Settings.from_env()

    bot = Bot(token=settings.telegram_token)
    dp = Dispatcher()

    @dp.message(CommandStart())
    async def handle_start(message: Message) -> None:  # noqa: D401
        """
        /start handler that checks backend auth.
        """
        await message.answer("Logging in to backend...")

        try:
            token = await login_to_backend(settings)
            user = await fetch_current_user(settings, token)
        except Exception as exc:  # noqa: BLE001
            await message.answer(f"Backend auth failed: {exc}")
            return

        username = user.get("username", "unknown")
        await message.answer(f"Hello, {username}! Backend auth is working.")

    await dp.start_polling(bot)


if __name__ == "__main__":
    asyncio.run(main())
