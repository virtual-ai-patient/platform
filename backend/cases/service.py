from cases.repository import CaseRepository
from cases.request import CreateCaseRequest, UpdateCaseRequest
from cases.response import (
    AcceptableAnswerResponse,
    CaseResponse,
    ExpectedTestsResponse,
    InvestigationResultResponse,
    InvestigationsResponse,
    KeyHistoryPointsResponse,
    ManagementResponse,
    ScoringResponse,
)
from exceptions.auth_exceptions import ConflictError
from models.db import ClinicalCase


def _to_response(case: ClinicalCase) -> CaseResponse:
    must_ask = [p.content for p in case.history_points if p.point_type == "must_ask"]
    nice_to_ask = [
        p.content for p in case.history_points if p.point_type == "nice_to_ask"
    ]
    red_flags = [p.content for p in case.history_points if p.point_type == "red_flag"]

    must_order = [
        t.test_name for t in case.expected_tests if t.category == "must_order"
    ]
    optional = [t.test_name for t in case.expected_tests if t.category == "optional"]
    should_not_order = [
        t.test_name for t in case.expected_tests if t.category == "should_not_order"
    ]

    diagnostic_plan = [
        s.step for s in case.management_steps if s.step_type == "diagnostic_plan"
    ]
    treatment_plan = [
        s.step for s in case.management_steps if s.step_type == "treatment_plan"
    ]
    contraindications = [
        s.step for s in case.management_steps if s.step_type == "contraindication"
    ]
    follow_up = [s.step for s in case.management_steps if s.step_type == "follow_up"]

    return CaseResponse(
        id=case.id,
        case_id=case.case_id,
        status=case.status,
        version=case.version,
        created_by=case.created_by,
        title=case.title,
        language=case.language,
        difficulty=case.difficulty,
        specialty=case.specialty,
        tags=[t.tag for t in case.tags],
        age=case.age,
        sex=case.sex,
        persona=case.persona,
        tone_presets=[tp.preset for tp in case.tone_presets],
        chief_complaint=case.chief_complaint,
        history_of_present_illness=case.history_of_present_illness,
        key_history_points=KeyHistoryPointsResponse(
            must_ask=must_ask,
            nice_to_ask=nice_to_ask,
            red_flags=red_flags,
        ),
        final_diagnosis=case.final_diagnosis,
        differential=[d.diagnosis for d in case.differentials],
        severity_or_stage=case.severity_or_stage,
        investigations=InvestigationsResponse(
            catalog_hints=[h.hint for h in case.catalog_hints],
            expected=ExpectedTestsResponse(
                must_order=must_order,
                optional=optional,
                should_not_order=should_not_order,
            ),
            results=[
                InvestigationResultResponse(
                    test_name=r.test_name,
                    result_type=r.result_type,
                    value=r.value,
                    unit=r.unit,
                    reference_range=r.reference_range,
                )
                for r in case.investigation_results
            ],
        ),
        management=ManagementResponse(
            diagnostic_plan=diagnostic_plan,
            treatment_plan=treatment_plan,
            contraindications=contraindications,
            follow_up=follow_up,
        ),
        scoring=ScoringResponse(
            weight_diagnosis=case.weight_diagnosis,
            weight_diagnostics=case.weight_diagnostics,
            weight_treatment=case.weight_treatment,
            weight_safety=case.weight_safety,
            acceptable_answers=[
                AcceptableAnswerResponse(field=a.field, answer=a.answer)
                for a in case.acceptable_answers
            ],
            critical_safety_errors=[e.error for e in case.safety_errors],
        ),
    )


class CaseService:
    def __init__(self, repo: CaseRepository) -> None:
        self._repo = repo

    async def create(self, data: CreateCaseRequest, created_by: str) -> CaseResponse:
        if await self._repo.get_by_case_id(data.case_id) is not None:
            raise ConflictError(f"Case with case_id '{data.case_id}' already exists")
        case = await self._repo.create(data, created_by)
        return _to_response(case)

    async def get_by_id(self, id: str) -> ClinicalCase | None:
        return await self._repo.get_by_id(id)

    async def list_cases(
        self, status: str | None, published_only: bool
    ) -> list[CaseResponse]:
        cases = await self._repo.list_cases(
            status=status, published_only=published_only
        )
        return [_to_response(c) for c in cases]

    async def update(self, case: ClinicalCase, data: UpdateCaseRequest) -> CaseResponse:
        updated = await self._repo.update(case, data)
        return _to_response(updated)
