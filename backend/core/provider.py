from typing import Protocol, TypeAlias, runtime_checkable


@runtime_checkable
class AIProvider(Protocol):
    async def complete(
        self,
        messages: list[dict[str, str]],
        *,
        temperature: float | None = None,
        json_mode: bool = False,
    ) -> str: ...


BaseAIProvider: TypeAlias = AIProvider
