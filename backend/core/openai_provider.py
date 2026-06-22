from typing import Any, cast

import openai


class OpenAIProvider:
    def __init__(
        self,
        api_key: str,
        model: str = "gpt-4o-mini",
        base_url: str | None = None,
        *,
        default_headers: dict[str, str] | None = None,
        max_tokens: int = 1024,
        timeout: float = 60.0,
    ) -> None:
        self._client = openai.AsyncOpenAI(
            api_key=api_key,
            base_url=base_url,
            timeout=timeout,
            default_headers=default_headers,
        )
        self._model = model
        self._max_tokens = max_tokens

    @property
    def model_name(self) -> str:
        return self._model

    async def complete(
        self,
        messages: list[dict[str, str]],
        *,
        temperature: float | None = None,
        json_mode: bool = False,
    ) -> str:
        typed_messages = cast(Any, messages)
        json_format = cast(Any, {"type": "json_object"})

        if temperature is not None and json_mode:
            response = await self._client.chat.completions.create(
                model=self._model,
                messages=typed_messages,
                max_tokens=self._max_tokens,
                temperature=temperature,
                response_format=json_format,
            )
        elif temperature is not None:
            response = await self._client.chat.completions.create(
                model=self._model,
                messages=typed_messages,
                max_tokens=self._max_tokens,
                temperature=temperature,
            )
        elif json_mode:
            response = await self._client.chat.completions.create(
                model=self._model,
                messages=typed_messages,
                max_tokens=self._max_tokens,
                response_format=json_format,
            )
        else:
            response = await self._client.chat.completions.create(
                model=self._model,
                messages=typed_messages,
                max_tokens=self._max_tokens,
            )
        content = response.choices[0].message.content
        return content or ""
