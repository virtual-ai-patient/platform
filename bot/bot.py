import asyncio
import logging

from aiogram import Bot, Dispatcher
from aiogram.fsm.storage.memory import MemoryStorage
from aiogram.types import BotCommand

from backend_client import BackendClient
from bot_config import Settings
from middleware import ThrottlingMiddleware
from routers import auth, errors, menu

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

    dp.include_router(errors.router)
    dp.include_router(auth.router)
    dp.include_router(menu.router)

    webhook_info = await bot.get_webhook_info()
    if webhook_info.url:
        logger.warning("Active webhook found: %s — deleting it", webhook_info.url)
        await bot.delete_webhook(drop_pending_updates=False)
    else:
        logger.info("No active webhook, proceeding with polling")

    await bot.set_my_commands([
        BotCommand(command="start",      description="Главное меню и вход"),
        BotCommand(command="cases",      description="Список доступных кейсов"),
        BotCommand(command="order_test", description="Заказать медицинский тест"),
        BotCommand(command="diagnosis",  description="Отправить дифференциальный диагноз"),
        BotCommand(command="treatment",  description="Отправить план лечения"),
        BotCommand(command="debrief",    description="Получить разбор завершённого кейса"),
        BotCommand(command="history",    description="История прошлых сессий"),
        BotCommand(command="help",       description="Список всех команд"),
    ])
    logger.info("Bot commands registered with Telegram")

    await dp.start_polling(bot)


if __name__ == "__main__":
    asyncio.run(main())
