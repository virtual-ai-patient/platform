import time
from collections.abc import Awaitable, Callable
from typing import Any

from aiogram import BaseMiddleware
from aiogram.types import Message, TelegramObject


class ThrottlingMiddleware(BaseMiddleware):
    """Simple per-user rate limiter.

    Rejects messages that arrive faster than `rate_limit` seconds apart
    for the same user. Sends a single warning and then silently drops
    subsequent messages until the cooldown expires.
    """

    def __init__(self, rate_limit: float = 1.0) -> None:
        self._rate_limit = rate_limit
        self._last_called: dict[int, float] = {}
        self._warned: set[int] = set()

    async def __call__(
        self,
        handler: Callable[[TelegramObject, dict[str, Any]], Awaitable[Any]],
        event: TelegramObject,
        data: dict[str, Any],
    ) -> Any:
        if not isinstance(event, Message) or event.from_user is None:
            return await handler(event, data)

        user_id = event.from_user.id
        now = time.monotonic()
        last = self._last_called.get(user_id, 0.0)
        delta = now - last

        if delta < self._rate_limit:
            if user_id not in self._warned:
                self._warned.add(user_id)
                await event.answer(
                    f"Пожалуйста, не отправляйте сообщения так быстро. "
                    f"Подождите {self._rate_limit:.0f} сек."
                )
            return None

        self._last_called[user_id] = now
        self._warned.discard(user_id)
        return await handler(event, data)
