from typing import Protocol, runtime_checkable


@runtime_checkable
class AIProvider(Protocol):
    async def complete(self, messages: list[dict[str, str]]) -> str: ...
