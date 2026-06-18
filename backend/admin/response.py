from datetime import datetime

from pydantic import BaseModel


class ActionLogEntry(BaseModel):
    role: str
    content: str
    created_at: datetime


class SessionSummary(BaseModel):
    session_id: str
    student_username: str
    case_id: str
    case_title: str
    created_at: datetime


class SessionListResponse(BaseModel):
    sessions: list[SessionSummary]
    total: int
    page: int
    page_size: int


class SessionDetailResponse(BaseModel):
    session_id: str
    student_username: str
    case_id: str
    case_title: str
    created_at: datetime
    action_log: list[ActionLogEntry]
