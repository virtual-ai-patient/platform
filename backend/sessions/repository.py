from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from models.db import CaseSession


class SessionRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def create(
        self,
        user_id: str,
        clinical_case_id: str,
        snapshot: dict,
    ) -> CaseSession:
        record = CaseSession(
            user_id=user_id,
            clinical_case_id=clinical_case_id,
            frozen_case_snapshot=snapshot,
        )
        self._session.add(record)
        await self._session.commit()
        await self._session.refresh(record)
        return record

    async def get_by_session_id(self, session_id: str) -> CaseSession | None:
        result = await self._session.execute(
            select(CaseSession).where(CaseSession.session_id == session_id)
        )
        return result.scalar_one_or_none()
