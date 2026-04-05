from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload
from sqlalchemy.sql.base import ExecutableOption

from cases.request import CreateCaseRequest, UpdateCaseRequest
from models.db import (
    CaseAcceptableAnswer,
    CaseCatalogHint,
    CaseDifferential,
    CaseExpectedTest,
    CaseHistoryPoint,
    CaseInvestigationResult,
    CaseManagementStep,
    CaseSafetyError,
    CaseTag,
    CaseTonePreset,
    ClinicalCase,
)


def _load_all() -> list[ExecutableOption]:
    return [
        selectinload(ClinicalCase.tags),
        selectinload(ClinicalCase.tone_presets),
        selectinload(ClinicalCase.history_points),
        selectinload(ClinicalCase.differentials),
        selectinload(ClinicalCase.catalog_hints),
        selectinload(ClinicalCase.expected_tests),
        selectinload(ClinicalCase.investigation_results),
        selectinload(ClinicalCase.management_steps),
        selectinload(ClinicalCase.acceptable_answers),
        selectinload(ClinicalCase.safety_errors),
    ]


def _build_children(case_id: str, data: CreateCaseRequest) -> list[object]:
    children: list[object] = []

    for tag in data.tags:
        children.append(CaseTag(case_id=case_id, tag=tag))

    for preset in data.tone_presets:
        children.append(CaseTonePreset(case_id=case_id, preset=preset))

    for content in data.key_history_points.must_ask:
        children.append(
            CaseHistoryPoint(case_id=case_id, point_type="must_ask", content=content)
        )
    for content in data.key_history_points.nice_to_ask:
        children.append(
            CaseHistoryPoint(case_id=case_id, point_type="nice_to_ask", content=content)
        )
    for content in data.key_history_points.red_flags:
        children.append(
            CaseHistoryPoint(case_id=case_id, point_type="red_flag", content=content)
        )

    for rank, diagnosis in enumerate(data.differential, start=1):
        children.append(
            CaseDifferential(case_id=case_id, rank=rank, diagnosis=diagnosis)
        )

    for hint in data.investigations.catalog_hints:
        children.append(CaseCatalogHint(case_id=case_id, hint=hint))

    expected = data.investigations.expected
    for name in expected.must_order:
        children.append(
            CaseExpectedTest(case_id=case_id, test_name=name, category="must_order")
        )
    for name in expected.optional:
        children.append(
            CaseExpectedTest(case_id=case_id, test_name=name, category="optional")
        )
    for name in expected.should_not_order:
        children.append(
            CaseExpectedTest(
                case_id=case_id, test_name=name, category="should_not_order"
            )
        )

    for result in data.investigations.results:
        children.append(
            CaseInvestigationResult(
                case_id=case_id,
                test_name=result.test_name,
                result_type=result.result_type,
                value=result.value,
                unit=result.unit,
                reference_range=result.reference_range,
            )
        )

    mgmt = data.management
    for order, step in enumerate(mgmt.diagnostic_plan, start=1):
        children.append(
            CaseManagementStep(
                case_id=case_id, step_type="diagnostic_plan", step=step, order=order
            )
        )
    for order, step in enumerate(mgmt.treatment_plan, start=1):
        children.append(
            CaseManagementStep(
                case_id=case_id, step_type="treatment_plan", step=step, order=order
            )
        )
    for order, step in enumerate(mgmt.contraindications, start=1):
        children.append(
            CaseManagementStep(
                case_id=case_id,
                step_type="contraindication",
                step=step,
                order=order,
            )
        )
    for order, step in enumerate(mgmt.follow_up, start=1):
        children.append(
            CaseManagementStep(
                case_id=case_id, step_type="follow_up", step=step, order=order
            )
        )

    for aa in data.scoring.acceptable_answers:
        children.append(
            CaseAcceptableAnswer(case_id=case_id, field=aa.field, answer=aa.answer)
        )

    for error in data.scoring.critical_safety_errors:
        children.append(CaseSafetyError(case_id=case_id, error=error))

    return children


class CaseRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def create(self, data: CreateCaseRequest, created_by: str) -> ClinicalCase:
        case = ClinicalCase(
            case_id=data.case_id,
            status=data.status,
            created_by=created_by,
            title=data.title,
            language=data.language,
            difficulty=data.difficulty,
            specialty=data.specialty,
            age=data.age,
            sex=data.sex,
            persona=data.persona,
            chief_complaint=data.chief_complaint,
            history_of_present_illness=data.history_of_present_illness,
            final_diagnosis=data.final_diagnosis,
            severity_or_stage=data.severity_or_stage,
            weight_diagnosis=data.scoring.weight_diagnosis,
            weight_diagnostics=data.scoring.weight_diagnostics,
            weight_treatment=data.scoring.weight_treatment,
            weight_safety=data.scoring.weight_safety,
        )
        self._session.add(case)
        await self._session.flush()  # get case.id before building children

        for child in _build_children(case.id, data):
            self._session.add(child)

        await self._session.commit()
        await self._session.refresh(case)
        return await self.get_by_id(case.id)  # type: ignore[return-value]

    async def get_by_id(self, id: str) -> ClinicalCase | None:
        result = await self._session.execute(
            select(ClinicalCase).where(ClinicalCase.id == id).options(*_load_all())
        )
        return result.scalar_one_or_none()

    async def get_by_case_id(self, case_id: str) -> ClinicalCase | None:
        result = await self._session.execute(
            select(ClinicalCase)
            .where(ClinicalCase.case_id == case_id)
            .options(*_load_all())
        )
        return result.scalar_one_or_none()

    async def list_cases(
        self, status: str | None = None, published_only: bool = False
    ) -> list[ClinicalCase]:
        stmt = select(ClinicalCase).options(*_load_all())
        if published_only:
            stmt = stmt.where(ClinicalCase.status == "published")
        elif status is not None:
            stmt = stmt.where(ClinicalCase.status == status)
        result = await self._session.execute(stmt)
        return list(result.scalars().all())

    async def update(self, case: ClinicalCase, data: UpdateCaseRequest) -> ClinicalCase:
        scalar_fields = (
            "title",
            "language",
            "difficulty",
            "specialty",
            "age",
            "sex",
            "persona",
            "chief_complaint",
            "history_of_present_illness",
            "final_diagnosis",
            "severity_or_stage",
            "status",
        )
        for field in scalar_fields:
            value = getattr(data, field)
            if value is not None:
                setattr(case, field, value)

        if data.scoring is not None:
            case.weight_diagnosis = data.scoring.weight_diagnosis
            case.weight_diagnostics = data.scoring.weight_diagnostics
            case.weight_treatment = data.scoring.weight_treatment
            case.weight_safety = data.scoring.weight_safety

        if data.status == "published":
            case.version += 1

        # Replace child collections when provided
        if data.tags is not None:
            case.tags.clear()
            for tag in data.tags:
                self._session.add(CaseTag(case_id=case.id, tag=tag))

        if data.tone_presets is not None:
            case.tone_presets.clear()
            for preset in data.tone_presets:
                self._session.add(CaseTonePreset(case_id=case.id, preset=preset))

        if data.key_history_points is not None:
            case.history_points.clear()
            for content in data.key_history_points.must_ask:
                self._session.add(
                    CaseHistoryPoint(
                        case_id=case.id, point_type="must_ask", content=content
                    )
                )
            for content in data.key_history_points.nice_to_ask:
                self._session.add(
                    CaseHistoryPoint(
                        case_id=case.id, point_type="nice_to_ask", content=content
                    )
                )
            for content in data.key_history_points.red_flags:
                self._session.add(
                    CaseHistoryPoint(
                        case_id=case.id, point_type="red_flag", content=content
                    )
                )

        if data.differential is not None:
            case.differentials.clear()
            for rank, diagnosis in enumerate(data.differential, start=1):
                self._session.add(
                    CaseDifferential(case_id=case.id, rank=rank, diagnosis=diagnosis)
                )

        if data.investigations is not None:
            case.catalog_hints.clear()
            case.expected_tests.clear()
            case.investigation_results.clear()
            for hint in data.investigations.catalog_hints:
                self._session.add(CaseCatalogHint(case_id=case.id, hint=hint))
            expected = data.investigations.expected
            for name in expected.must_order:
                self._session.add(
                    CaseExpectedTest(
                        case_id=case.id, test_name=name, category="must_order"
                    )
                )
            for name in expected.optional:
                self._session.add(
                    CaseExpectedTest(
                        case_id=case.id, test_name=name, category="optional"
                    )
                )
            for name in expected.should_not_order:
                self._session.add(
                    CaseExpectedTest(
                        case_id=case.id,
                        test_name=name,
                        category="should_not_order",
                    )
                )
            for r in data.investigations.results:
                self._session.add(
                    CaseInvestigationResult(
                        case_id=case.id,
                        test_name=r.test_name,
                        result_type=r.result_type,
                        value=r.value,
                        unit=r.unit,
                        reference_range=r.reference_range,
                    )
                )

        if data.management is not None:
            case.management_steps.clear()
            mgmt = data.management
            for order, step in enumerate(mgmt.diagnostic_plan, start=1):
                self._session.add(
                    CaseManagementStep(
                        case_id=case.id,
                        step_type="diagnostic_plan",
                        step=step,
                        order=order,
                    )
                )
            for order, step in enumerate(mgmt.treatment_plan, start=1):
                self._session.add(
                    CaseManagementStep(
                        case_id=case.id,
                        step_type="treatment_plan",
                        step=step,
                        order=order,
                    )
                )
            for order, step in enumerate(mgmt.contraindications, start=1):
                self._session.add(
                    CaseManagementStep(
                        case_id=case.id,
                        step_type="contraindication",
                        step=step,
                        order=order,
                    )
                )
            for order, step in enumerate(mgmt.follow_up, start=1):
                self._session.add(
                    CaseManagementStep(
                        case_id=case.id,
                        step_type="follow_up",
                        step=step,
                        order=order,
                    )
                )

        if data.scoring is not None:
            case.acceptable_answers.clear()
            case.safety_errors.clear()
            for aa in data.scoring.acceptable_answers:
                self._session.add(
                    CaseAcceptableAnswer(
                        case_id=case.id, field=aa.field, answer=aa.answer
                    )
                )
            for error in data.scoring.critical_safety_errors:
                self._session.add(CaseSafetyError(case_id=case.id, error=error))

        await self._session.commit()
        return await self.get_by_id(case.id)  # type: ignore[return-value]

    async def delete(self, case: ClinicalCase) -> None:
        await self._session.delete(case)
        await self._session.commit()
