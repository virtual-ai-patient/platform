from datetime import datetime

from pydantic import BaseModel


class SessionResponse(BaseModel):
    session_id: str
    case_id: str
    status: str
    created_at: datetime
