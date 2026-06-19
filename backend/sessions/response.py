from datetime import datetime
from typing import Any

from pydantic import BaseModel


class SessionResponse(BaseModel):
    session_id: str
    case_id: str
    status: str
    created_at: datetime
    last_activity_at: datetime


class ConclusionsResponse(BaseModel):
    session_id: str
    status: str
    conclusions: dict[str, Any] | None



class ProgressSummary(BaseModel):
    turn_count: int
    has_conclusions: bool


class ActiveSessionItem(BaseModel):
    session_id: str
    case_id: str
    case_title: str
    created_at: datetime
    last_activity_at: datetime
    progress_summary: ProgressSummary


class ChatMessage(BaseModel):
    role: str
    content: str
    logged_at: datetime


class SessionStateResponse(BaseModel):
    session_id: str
    status: str
    created_at: datetime
    last_activity_at: datetime
    case_snapshot: dict[str, Any]
    chat_history: list[ChatMessage]
    next_cursor: int | None
    ordered_tests: list[str]
    conclusions: dict[str, Any] | None
