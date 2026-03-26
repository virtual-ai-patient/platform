import logging
from typing import Any, Dict

import httpx
from aiogram import Router
from aiogram.filters import CommandStart
from aiogram.fsm.context import FSMContext
from aiogram.types import (
    CallbackQuery,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
    Message,
)

from backend_client import BackendClient
from bot_config import Settings
from routers.menu import HELP_TEXT
from states import CaseStates

router = Router()
logger = logging.getLogger(__name__)

_TOKEN_KEY = "access_token"


def _learner_menu() -> InlineKeyboardMarkup:
    return InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="Кейсы", callback_data="menu:cases"),
         InlineKeyboardButton(text="История", callback_data="menu:history")],
        [InlineKeyboardButton(text="Помощь", callback_data="menu:help")],
    ])


def _educator_menu() -> InlineKeyboardMarkup:
    return InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="Кейсы", callback_data="menu:cases"),
         InlineKeyboardButton(text="Создать кейс", callback_data="menu:create_case")],
        [InlineKeyboardButton(text="Студенты", callback_data="menu:students"),
         InlineKeyboardButton(text="Помощь", callback_data="menu:help")],
    ])


def _admin_menu() -> InlineKeyboardMarkup:
    return InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="Статистика", callback_data="menu:stats"),
         InlineKeyboardButton(text="Пользователи", callback_data="menu:users")],
        [InlineKeyboardButton(text="Помощь", callback_data="menu:help")],
    ])


def _menu_for_role(role: str) -> InlineKeyboardMarkup:
    if role == "educator":
        return _educator_menu()
    if role == "admin":
        return _admin_menu()
    return _learner_menu()


async def _get_or_refresh_token(
    state: FSMContext,
    client: BackendClient,
    telegram_user_id: int,
) -> tuple[str, Dict[str, Any]]:
    """Return (access_token, user_info). Re-registers/re-logins if token is missing or expired."""
    data = await state.get_data()
    token: str | None = data.get(_TOKEN_KEY)

    if token:
        try:
            user_info = await client.verify(token)
            return token, user_info
        except httpx.HTTPStatusError:
            pass  # token expired or invalid — fall through to re-login

    token = await client.auto_register_and_login(telegram_user_id)
    await state.update_data({_TOKEN_KEY: token})
    user_info = await client.verify(token)
    return token, user_info


@router.message(CommandStart())
async def handle_start(message: Message, state: FSMContext) -> None:
    if message.from_user is None:
        logger.warning("Received /start with no from_user, ignoring")
        return

    logger.info("Received /start from user %s", message.from_user.id)

    settings = Settings.from_env()
    client = BackendClient(
        base_url=settings.backend_base_url,
        secret_salt=settings.telegram_token,
    )

    telegram_user_id = message.from_user.id
    first_name = message.from_user.first_name or "Пользователь"

    try:
        token, user_info = await _get_or_refresh_token(state, client, telegram_user_id)
    except Exception as exc:  # noqa: BLE001
        logger.error("Auth failed for user %s: %s", telegram_user_id, exc)
        await message.answer("Не удалось подключиться к серверу. Попробуйте позже.")
        return

    role: str = user_info.get("role", "learner")
    username: str = user_info.get("username", first_name)

    # Session persistence: offer to resume if user was in an active case
    current_state = await state.get_state()
    if current_state == CaseStates.in_conversation.state:
        resume_kb = InlineKeyboardMarkup(inline_keyboard=[
            [InlineKeyboardButton(text="Продолжить кейс", callback_data="session:resume"),
             InlineKeyboardButton(text="Выйти из кейса", callback_data="session:exit")],
        ])
        await message.answer(
            f"С возвращением, {first_name}! У вас есть незавершённый кейс.\n"
            "Хотите продолжить?",
            reply_markup=resume_kb,
        )
        return

    await message.answer(
        f"Добро пожаловать, {first_name}!\n"
        f"Вы вошли как <b>{username}</b> (роль: {role}).",
        parse_mode="HTML",
        reply_markup=_menu_for_role(role),
    )
    logger.info("User %s authenticated (role=%s)", telegram_user_id, role)


@router.callback_query(lambda c: c.data and c.data.startswith("session:"))
async def handle_session_callback(callback: CallbackQuery, state: FSMContext) -> None:
    action = (callback.data or "").split(":")[1]
    await callback.answer()
    assert isinstance(callback.message, Message)
    if action == "resume":
        await callback.message.answer(
            "Возвращаемся к кейсу... (функция будет доступна после реализации модуля кейсов)"
        )
    elif action == "exit":
        await state.clear()
        role = "learner"
        await callback.message.answer(
            "Кейс завершён. Главное меню:",
            reply_markup=_menu_for_role(role),
        )


@router.callback_query(lambda c: c.data and c.data.startswith("menu:"))
async def handle_menu_callback(callback: CallbackQuery) -> None:
    action = (callback.data or "").split(":")[1]
    stubs = {
        "cases": "Список кейсов — скоро будет доступно.",
        "history": "История сессий — скоро будет доступно.",
        "help": HELP_TEXT,
        "create_case": "Создание кейсов — скоро будет доступно.",
        "students": "Список студентов — скоро будет доступно.",
        "stats": "Статистика — скоро будет доступно.",
        "users": "Управление пользователями — скоро будет доступно.",
    }
    text = stubs.get(action, "Неизвестное действие.")
    await callback.answer()
    assert isinstance(callback.message, Message)
    await callback.message.answer(text)
