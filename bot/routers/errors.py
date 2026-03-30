import logging

from aiogram import Router
from aiogram.types import ErrorEvent

router = Router()
logger = logging.getLogger(__name__)


@router.errors()
async def handle_error(event: ErrorEvent) -> bool:
    logger.exception("Unhandled exception in handler: %s", event.exception)
    return True
