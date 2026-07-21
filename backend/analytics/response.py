from datetime import datetime
from typing import Any

from pydantic import BaseModel, ConfigDict


class SessionExportRow(BaseModel):
    session_id: str
    case_id: str
    case_version: int | None
    learner_id: str
    started_at: datetime
    finished_at: datetime | None
    total_score: float | None
    score_diagnosis: float | None
    score_diagnostics: float | None
    score_treatment: float | None
    score_safety: float | None
    findings_by_severity: dict[str, int]

    model_config = ConfigDict(
        json_schema_extra={
            "examples": [
                {
                    "session_id": "550e8400-e29b-41d4-a716-446655440000",
                    "case_id": "CASE-001",
                    "case_version": 1,
                    "learner_id": "learner",
                    "started_at": "2026-06-14T11:45:00Z",
                    "finished_at": "2026-06-14T12:00:00Z",
                    "total_score": 82.5,
                    "score_diagnosis": 100.0,
                    "score_diagnostics": 75.0,
                    "score_treatment": 80.0,
                    "score_safety": 100.0,
                    "findings_by_severity": {"major": 1, "minor": 2},
                }
            ]
        }
    )


class ActionExportRow(BaseModel):
    session_id: str
    learner_id: str
    turn_index: int
    timestamp: datetime
    action_type: str
    payload_json: dict[str, Any]

    model_config = ConfigDict(
        json_schema_extra={
            "examples": [
                {
                    "session_id": "550e8400-e29b-41d4-a716-446655440000",
                    "learner_id": "learner",
                    "turn_index": 0,
                    "timestamp": "2026-06-14T11:45:03Z",
                    "action_type": "chat_user",
                    "payload_json": {"text": "Where does it hurt?"},
                }
            ]
        }
    )
