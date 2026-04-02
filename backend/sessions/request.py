from pydantic import BaseModel


class StartSessionRequest(BaseModel):
    case_id: str 
