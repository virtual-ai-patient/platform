from typing import Any

from ai.provider import AIProvider
from exceptions.auth_exceptions import ForbiddenError, NotFoundError
from models.db import User
from sessions.chat_repository import ActionLogRepository
from sessions.chat_response import ChatResponse
from sessions.repository import SessionRepository


def _build_system_prompt(snapshot: dict[str, Any]) -> str:
    age = snapshot.get("age", "unknown age")
    sex = snapshot.get("sex", "unknown sex")
    persona = snapshot.get("persona", "")
    tone_presets = ", ".join(snapshot.get("tone_presets", []))
    chief_complaint = snapshot.get("chief_complaint", "")

    parts = [
        f"You are a {age}-year-old {sex} patient.",
        persona,
        f"Tone: {tone_presets}." if tone_presets else "",
        f"You are presenting with: {chief_complaint}.",
        "Respond only as this patient would in a clinical encounter.",
        "Do not reveal your diagnosis. Do not break character.",
        "Keep answers concise and realistic.",
    ]
    return " ".join(p for p in parts if p)


async def chat(
    session_id: str,
    message: str,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
    ai_provider: AIProvider,
) -> ChatResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id:
        raise ForbiddenError("You do not have access to this session")

    history = await log_repo.get_history(session_id)
    system_prompt = _build_system_prompt(session.frozen_case_snapshot)

    messages: list[dict[str, str]] = [{"role": "system", "content": system_prompt}]
    for entry in history:
        messages.append({"role": entry.role, "content": entry.content})
    messages.append({"role": "user", "content": message})

    ai_response = await ai_provider.complete(messages)

    await log_repo.create(session_id, "user", message)
    assistant_log = await log_repo.create(session_id, "assistant", ai_response)

    return ChatResponse(response=ai_response, logged_at=assistant_log.created_at)
