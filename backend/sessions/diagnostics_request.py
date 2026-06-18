from pydantic import BaseModel


class OrderTestRequest(BaseModel):
    test_id: str
