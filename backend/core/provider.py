from typing import Protocol, TypeAlias, runtime_checkable


@runtime_checkable
class AIProvider(Protocol):
    async def complete(self, messages: list[dict[str, str]]) -> str: ...


BaseAIProvider: TypeAlias = AIProvider
