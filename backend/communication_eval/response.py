from datetime import datetime

from pydantic import BaseModel, ConfigDict


class CommunicationCriterionResponse(BaseModel):
    criterion: str
    score: int
    rationale: str
    quote: str


class CommunicationEvaluationResponse(BaseModel):
    session_id: str
    model: str
    prompt_version: str
    total_score: float
    created_at: datetime
    criteria: list[CommunicationCriterionResponse]

    model_config = ConfigDict(
        json_schema_extra={
            "examples": [
                {
                    "session_id": "550e8400-e29b-41d4-a716-446655440000",
                    "model": "mock",
                    "prompt_version": "v1",
                    "total_score": 76.0,
                    "created_at": "2026-06-19T12:00:00Z",
                    "criteria": [
                        {
                            "criterion": "open_ended_questions",
                            "score": 4,
                            "rationale": "Used open-ended questions.",
                            "quote": "Can you tell me more?",
                        }
                    ],
                }
            ]
        }
    )
