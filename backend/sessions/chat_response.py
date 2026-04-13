from datetime import datetime

from pydantic import BaseModel


class ChatResponse(BaseModel):
    response: str
    logged_at: datetime
