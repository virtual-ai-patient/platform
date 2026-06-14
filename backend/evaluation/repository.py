from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from evaluation.scorer import ScoringResult
from models.db import Evaluation, EvaluationFinding


class EvaluationRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_session_id(self, session_id: str) -> Evaluation | None:
        result = await self._session.execute(
            select(Evaluation)
            .options(selectinload(Evaluation.findings))
            .where(Evaluation.session_id == session_id)
        )
        return result.scalar_one_or_none()

    async def create(
        self,
        session_id: str,
        case_version: int,
        result: ScoringResult,
    ) -> Evaluation:
        record = Evaluation(
            session_id=session_id,
            case_version=case_version,
            total_score=result.total_score,
            score_diagnosis=result.score_diagnosis,
            score_diagnostics=result.score_diagnostics,
            score_treatment=result.score_treatment,
            score_safety=result.score_safety,
            reference_solution=result.reference_solution,
            findings=[
                EvaluationFinding(
                    category=finding.category,
                    finding_type=finding.finding_type,
                    severity=finding.severity,
                    expected=finding.expected,
                    actual=finding.actual,
                    why_matters=finding.why_matters,
                    how_to_correct=finding.how_to_correct,
                    deduction_points=finding.deduction_points,
                )
                for finding in result.findings
            ],
        )
        self._session.add(record)
        await self._session.commit()
        await self._session.refresh(record)
        loaded = await self.get_by_session_id(session_id)
        assert loaded is not None
        return loaded
