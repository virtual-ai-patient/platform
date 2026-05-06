from datetime import datetime
from typing import Any

from pydantic import BaseModel


class SessionResponse(BaseModel):
    session_id: str
    case_id: str
    status: str
    created_at: datetime


class ConclusionsResponse(BaseModel):
    session_id: str
    status: str
    conclusions: dict[str, Any] | None
