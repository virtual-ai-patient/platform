from pydantic import BaseModel


class KeyHistoryPointsResponse(BaseModel):
    must_ask: list[str]
    nice_to_ask: list[str]
    red_flags: list[str]


class ExpectedTestsResponse(BaseModel):
    must_order: list[str]
    optional: list[str]
    should_not_order: list[str]


class InvestigationResultResponse(BaseModel):
    test_name: str
    result_type: str
    value: str
    unit: str | None
    reference_range: str | None


class InvestigationsResponse(BaseModel):
    catalog_hints: list[str]
    expected: ExpectedTestsResponse
    results: list[InvestigationResultResponse]


class ManagementResponse(BaseModel):
    diagnostic_plan: list[str]
    treatment_plan: list[str]
    contraindications: list[str]
    follow_up: list[str]


class AcceptableAnswerResponse(BaseModel):
    field: str
    answer: str


class ScoringResponse(BaseModel):
    weight_diagnosis: float
    weight_diagnostics: float
    weight_treatment: float
    weight_safety: float
    acceptable_answers: list[AcceptableAnswerResponse]
    critical_safety_errors: list[str]


class CaseResponse(BaseModel):
    id: str
    case_id: str
    status: str
    version: int
    created_by: str
    title: str
    language: str
    difficulty: str
    specialty: str
    tags: list[str]
    age: int
    sex: str
    persona: str
    tone_presets: list[str]
    chief_complaint: str
    history_of_present_illness: str
    key_history_points: KeyHistoryPointsResponse
    final_diagnosis: str
    differential: list[str]
    severity_or_stage: str | None
    investigations: InvestigationsResponse
    management: ManagementResponse
    scoring: ScoringResponse
