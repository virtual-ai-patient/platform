from datetime import datetime
from typing import Any

from pydantic import BaseModel, ConfigDict, Field


class ScoresResponse(BaseModel):
    session_id: str
    case_version: int
    total_score: float
    score_diagnosis: float
    score_diagnostics: float
    score_treatment: float
    score_safety: float
    scored_at: datetime

    model_config = ConfigDict(
        json_schema_extra={
            "examples": [
                {
                    "session_id": "550e8400-e29b-41d4-a716-446655440000",
                    "case_version": 1,
                    "total_score": 82.5,
                    "score_diagnosis": 100.0,
                    "score_diagnostics": 75.0,
                    "score_treatment": 80.0,
                    "score_safety": 100.0,
                    "scored_at": "2026-06-14T12:00:00Z",
                }
            ]
        }
    )


class EvaluationFindingResponse(BaseModel):
    category: str
    finding_type: str = Field(serialization_alias="type")
    severity: str
    expected: str
    actual: str
    why_matters: str
    how_to_correct: str
    deduction_points: float

    model_config = ConfigDict(populate_by_name=True)


class DebriefResponse(BaseModel):
    session_id: str
    case_version: int
    total_score: float
    score_diagnosis: float
    score_diagnostics: float
    score_treatment: float
    score_safety: float
    scored_at: datetime
    findings: list[EvaluationFindingResponse]
    reference_solution: dict[str, Any]
    conclusions: dict[str, Any]

    model_config = ConfigDict(
        json_schema_extra={
            "examples": [
                {
                    "session_id": "550e8400-e29b-41d4-a716-446655440000",
                    "case_version": 1,
                    "total_score": 82.5,
                    "score_diagnosis": 100.0,
                    "score_diagnostics": 75.0,
                    "score_treatment": 80.0,
                    "score_safety": 100.0,
                    "scored_at": "2026-06-14T12:00:00Z",
                    "findings": [
                        {
                            "category": "diagnostics",
                            "type": "missing_must_order",
                            "severity": "major",
                            "expected": "Order ECG",
                            "actual": "Test not ordered",
                            "why_matters": "Must-order tests are required to confirm or rule out key diagnoses.",
                            "how_to_correct": "Order ECG during the diagnostic workup.",
                            "deduction_points": 25.0,
                        }
                    ],
                    "reference_solution": {
                        "case_id": "CASE-001",
                        "version": 1,
                        "final_diagnosis": "STEMI",
                        "management": {"treatment_plan": ["Activate cath lab"]},
                    },
                    "conclusions": {
                        "final_diagnosis": "STEMI",
                        "treatment_plan": {"medications": []},
                    },
                }
            ]
        }
    )
