from pydantic import BaseModel, Field


class StartSessionRequest(BaseModel):
    case_id: str


class DifferentialDiagnosisItem(BaseModel):
    rank: int = Field(..., ge=1)
    condition: str


class Medication(BaseModel):
    name: str
    dose: str
    route: str


class TreatmentPlan(BaseModel):
    medications: list[Medication] = []
    non_pharmacological: list[str] = []
    referrals: list[str] = []
    follow_up: list[str] = []


class ConclusionsRequest(BaseModel):
    differential_diagnoses: list[DifferentialDiagnosisItem] | None = None
    final_diagnosis: str | None = None
    treatment_plan: TreatmentPlan | None = None
