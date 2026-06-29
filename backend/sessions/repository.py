from datetime import datetime, timezone
from typing import Any

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
        snapshot: dict[str, Any],
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

    async def list_active_by_user(self, user_id: str) -> list[CaseSession]:
        result = await self._session.execute(
            select(CaseSession)
            .where(CaseSession.user_id == user_id, CaseSession.status == "active")
            .order_by(CaseSession.last_activity_at.desc())
        )
        return list(result.scalars().all())

    async def list_completed_by_user(self, user_id: str) -> list[CaseSession]:
        result = await self._session.execute(
            select(CaseSession)
            .where(CaseSession.user_id == user_id, CaseSession.status == "completed")
            .order_by(CaseSession.last_activity_at.desc())
        )
        return list(result.scalars().all())

    async def get_active_by_user_and_case(
        self, user_id: str, clinical_case_id: str
    ) -> CaseSession | None:
        result = await self._session.execute(
            select(CaseSession).where(
                CaseSession.user_id == user_id,
                CaseSession.clinical_case_id == clinical_case_id,
                CaseSession.status == "active",
            )
        )
        return result.scalar_one_or_none()

    async def touch(self, session_id: str) -> None:
        record = await self.get_by_session_id(session_id)
        if record is not None:
            record.last_activity_at = datetime.now(timezone.utc)
            await self._session.commit()


    async def update_conclusions(
        self, session_id: str, conclusions: dict[str, Any]
    ) -> CaseSession | None:
        record = await self.get_by_session_id(session_id)
        if record is None:
            return None
        record.conclusions = conclusions
        await self._session.commit()
        await self._session.refresh(record)
        return record

    async def update_status(
        self, session_id: str, new_status: str
    ) -> CaseSession | None:
        record = await self.get_by_session_id(session_id)
        if record is None:
            return None
        record.status = new_status
        await self._session.commit()
        await self._session.refresh(record)
        return record
