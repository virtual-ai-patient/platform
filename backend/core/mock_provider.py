"""Deterministic mock for CI — exercises injection / tone / memory paths."""

import re

_INJECTION = (
    "ignore previous",
    "disregard all",
    "system prompt",
    "print your instructions",
    "you are now",
    "jailbreak",
    "developer mode",
)
_DEFAULT = "I don't know, doc — it just hurts something awful."
_REFUSAL = (
    "I'm the patient; I don't know about that stuff. Can we talk about my symptoms?"
)


def _last_user(messages: list[dict[str, str]]) -> str:
    for m in reversed(messages):
        if m.get("role") == "user":
            return (m.get("content") or "").lower()
    return ""


def _system_raw(messages: list[dict[str, str]]) -> str:
    for m in messages:
        if m.get("role") == "system":
            return m.get("content") or ""
    return ""


def _all_user_texts(messages: list[dict[str, str]]) -> str:
    return " ".join(
        m.get("content") or "" for m in messages if m.get("role") == "user"
    )


class MockProvider:
    async def complete(self, messages: list[dict[str, str]]) -> str:
        last = _last_user(messages)
        for needle in _INJECTION:
            if needle in last:
                return _REFUSAL

        raw = _system_raw(messages)
        all_u = _all_user_texts(messages)
        tid_m = re.search(r"SESSION_TONE_ID:\s*(\S+)", raw, flags=re.IGNORECASE)
        tone_id = (tid_m.group(1) if tid_m else "").lower().replace(" ", "_")

        m = re.search(r"MEMORY_TOKEN_(?P<t>[A-Z0-9]+)", all_u, flags=re.IGNORECASE)
        token = m.group("t").upper() if m else None
        if token and (
            (
                "what" in last
                and ("code" in last or "token" in last or "remember" in last)
            )
            or ("still" in last and "remember" in last)
        ):
            return f"Yeah — I still have MEMORY_TOKEN_{token} in mind."

        symptom_q = "pain" in last or "hurt" in last or "ache" in last
        if symptom_q and tone_id in (
            "anxious",
            "nervous",
            "worried",
            "fearful",
        ):
            return (
                "Doctor, I'm on edge — the pain has me going over worst cases "
                "again and again in my head, I can't turn it off."
            )
        if symptom_q and tone_id in (
            "irritated",
            "irritable",
            "angry",
            "grumpy",
        ):
            return "Hurts. There. Can we move on?"

        return _DEFAULT
