from pydantic import BaseModel, ConfigDict


class TurnResult(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    text: str
    latency_ms: float
