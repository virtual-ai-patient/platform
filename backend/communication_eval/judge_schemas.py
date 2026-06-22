from typing import Literal

from pydantic import BaseModel, Field, field_validator

CRITERION_NAMES = (
    "open_ended_questions",
    "empathy",
    "structured_history",
    "closing_the_loop",
    "no_leading_questions",
)

CriterionName = Literal[
    "open_ended_questions",
    "empathy",
    "structured_history",
    "closing_the_loop",
    "no_leading_questions",
]


class JudgeCriterionOutput(BaseModel):
    criterion: CriterionName
    score: int = Field(ge=0, le=5)
    rationale: str
    quote: str


class JudgeOutput(BaseModel):
    criteria: list[JudgeCriterionOutput]

    @field_validator("criteria")
    @classmethod
    def all_criteria_present(
        cls, value: list[JudgeCriterionOutput]
    ) -> list[JudgeCriterionOutput]:
        found: set[str] = {item.criterion for item in value}
        expected = set(CRITERION_NAMES)
        if found != expected:
            missing = expected - found
            extra = found - expected
            parts: list[str] = []
            if missing:
                parts.append(f"missing: {sorted(missing)}")
            if extra:
                parts.append(f"unexpected: {sorted(extra)}")
            raise ValueError("; ".join(parts))
        return value


def compute_total_score(criteria: list[JudgeCriterionOutput]) -> float:
    total_points = sum(item.score for item in criteria)
    return round((total_points / 25.0) * 100.0, 1)
