from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from communication_eval.judge_schemas import JudgeOutput
from models.db import CommunicationCriterion, CommunicationEvaluation


class CommunicationEvaluationRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_session_id(
        self, session_id: str
    ) -> CommunicationEvaluation | None:
        result = await self._session.execute(
            select(CommunicationEvaluation)
            .options(selectinload(CommunicationEvaluation.criteria))
            .where(CommunicationEvaluation.session_id == session_id)
        )
        return result.scalar_one_or_none()

    async def create(
        self,
        session_id: str,
        model: str,
        prompt_version: str,
        total_score: float,
        judge_output: JudgeOutput,
    ) -> CommunicationEvaluation:
        record = CommunicationEvaluation(
            session_id=session_id,
            model=model,
            prompt_version=prompt_version,
            total_score=total_score,
            criteria=[
                CommunicationCriterion(
                    criterion=item.criterion,
                    score=item.score,
                    rationale=item.rationale,
                    quote=item.quote,
                )
                for item in judge_output.criteria
            ],
        )
        self._session.add(record)
        await self._session.commit()
        await self._session.refresh(record)
        loaded = await self.get_by_session_id(session_id)
        if loaded is None:
            raise RuntimeError(
                f"Communication evaluation for session '{session_id}' "
                "was not found after create"
            )
        return loaded
