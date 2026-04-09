class MockProvider:
    async def complete(self, messages: list[dict[str, str]]) -> str:
        return "I don't know, doc. It just hurts right here, in the middle of my chest."
