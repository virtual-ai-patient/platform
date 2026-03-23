from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message

router = Router()

_COMING_SOON = "Скоро будет доступно."

HELP_TEXT = (
    "Доступные команды:\n\n"
    "/start — главное меню и вход\n"
    "/cases — список доступных кейсов\n"
    "/order_test — заказать медицинский тест\n"
    "/diagnosis — отправить дифференциальный диагноз\n"
    "/treatment — отправить план лечения\n"
    "/debrief — получить разбор завершённого кейса\n"
    "/history — история прошлых сессий\n"
    "/help — эта справка"
)


@router.message(Command("help"))
async def cmd_help(message: Message) -> None:
    await message.answer(HELP_TEXT)


@router.message(Command("cases"))
async def cmd_cases(message: Message) -> None:
    await message.answer(_COMING_SOON)


@router.message(Command("order_test"))
async def cmd_order_test(message: Message) -> None:
    await message.answer(_COMING_SOON)


@router.message(Command("diagnosis"))
async def cmd_diagnosis(message: Message) -> None:
    await message.answer(_COMING_SOON)


@router.message(Command("treatment"))
async def cmd_treatment(message: Message) -> None:
    await message.answer(_COMING_SOON)


@router.message(Command("debrief"))
async def cmd_debrief(message: Message) -> None:
    await message.answer(_COMING_SOON)


@router.message(Command("history"))
async def cmd_history(message: Message) -> None:
    await message.answer(_COMING_SOON)


@router.message()
async def cmd_unknown(message: Message) -> None:
    await message.answer(
        "Не понимаю эту команду. Напишите /help для списка доступных команд."
    )
