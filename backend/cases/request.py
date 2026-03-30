from typing import Annotated, Literal

from pydantic import BaseModel, field_validator, model_validator


class KeyHistoryPointsRequest(BaseModel):
    must_ask: list[str]
    nice_to_ask: list[str]
    red_flags: list[str]


class ExpectedTestsRequest(BaseModel):
    must_order: list[str]
    optional: list[str]
    should_not_order: list[str]


class InvestigationResultRequest(BaseModel):
    test_name: str
    result_type: Literal["text_report", "lab_value"]
    value: str
    unit: str | None = None
    reference_range: str | None = None

    @model_validator(mode="after")
    def lab_value_requires_unit_and_range(self) -> "InvestigationResultRequest":
        if self.result_type == "lab_value" and (
            self.unit is None or self.reference_range is None
        ):
            raise ValueError(
                "unit and reference_range are required for lab_value results"
            )
        return self


class InvestigationsRequest(BaseModel):
    catalog_hints: list[str] = []
    expected: ExpectedTestsRequest
    results: list[InvestigationResultRequest] = []


class ManagementRequest(BaseModel):
    diagnostic_plan: list[str]
    treatment_plan: list[str]
    contraindications: list[str]
    follow_up: list[str]


class AcceptableAnswerRequest(BaseModel):
    field: str
    answer: str


_WEIGHT_TOLERANCE = 1e-6


class ScoringRequest(BaseModel):
    weight_diagnosis: Annotated[float, ">=0"]
    weight_diagnostics: Annotated[float, ">=0"]
    weight_treatment: Annotated[float, ">=0"]
    weight_safety: Annotated[float, ">=0"]
    acceptable_answers: list[AcceptableAnswerRequest] = []
    critical_safety_errors: list[str] = []

    @model_validator(mode="after")
    def weights_sum_to_one(self) -> "ScoringRequest":
        total = (
            self.weight_diagnosis
            + self.weight_diagnostics
            + self.weight_treatment
            + self.weight_safety
        )
        if abs(total - 1.0) > _WEIGHT_TOLERANCE:
            raise ValueError(f"Scoring weights must sum to 1.0 (got {total:.6f})")
        return self


class CreateCaseRequest(BaseModel):
    case_id: str
    title: str
    language: Literal["en"]
    difficulty: Literal["easy", "medium", "hard"]
    specialty: str
    tags: list[str] = []
    age: int
    sex: Literal["female", "male", "other"]
    persona: str
    tone_presets: list[str] = []
    chief_complaint: str
    history_of_present_illness: str
    key_history_points: KeyHistoryPointsRequest
    final_diagnosis: str
    differential: list[str] = []
    severity_or_stage: str | None = None
    investigations: InvestigationsRequest
    management: ManagementRequest
    scoring: ScoringRequest
    status: Literal["draft", "review", "published"] = "draft"

    @field_validator("case_id")
    @classmethod
    def case_id_not_empty(cls, v: str) -> str:
        if not v.strip():
            raise ValueError("case_id must not be empty")
        return v


class UpdateCaseRequest(BaseModel):
    title: str | None = None
    language: Literal["en"] | None = None
    difficulty: Literal["easy", "medium", "hard"] | None = None
    specialty: str | None = None
    tags: list[str] | None = None
    age: int | None = None
    sex: Literal["female", "male", "other"] | None = None
    persona: str | None = None
    tone_presets: list[str] | None = None
    chief_complaint: str | None = None
    history_of_present_illness: str | None = None
    key_history_points: KeyHistoryPointsRequest | None = None
    final_diagnosis: str | None = None
    differential: list[str] | None = None
    severity_or_stage: str | None = None
    investigations: InvestigationsRequest | None = None
    management: ManagementRequest | None = None
    scoring: ScoringRequest | None = None
    status: Literal["draft", "review", "published"] | None = None
