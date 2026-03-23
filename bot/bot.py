import asyncio
import logging
from contextlib import asynccontextmanager
from typing import AsyncGenerator

from aiogram import Bot, Dispatcher
from aiogram.fsm.storage.memory import MemoryStorage

from backend_client import BackendClient
from bot_config import Settings
from middleware import ThrottlingMiddleware
from routers import auth, menu

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


async def main() -> None:
    settings = Settings.from_env()
    client = BackendClient(
        base_url=settings.backend_base_url,
        secret_salt=settings.telegram_token,
    )

    # Health-check: verify the backend service account is reachable
    try:
        token = await client.login(settings.backend_username, settings.backend_password)
        user = await client.verify(token)
        logger.info("Backend connection verified. Service account: %s", user.get("username"))
    except Exception as exc:  # noqa: BLE001
        logger.warning("Backend health-check failed: %s", exc)

    bot = Bot(token=settings.telegram_token)
    storage = MemoryStorage()
    dp = Dispatcher(storage=storage)

    dp.message.middleware(ThrottlingMiddleware(rate_limit=1.0))

    dp.include_router(auth.router)
    dp.include_router(menu.router)

    await dp.start_polling(bot)


if __name__ == "__main__":
    asyncio.run(main())
