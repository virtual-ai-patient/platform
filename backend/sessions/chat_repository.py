from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from models.db import ActionLog


class ActionLogRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def create(self, session_id: str, role: str, content: str) -> ActionLog:
        record = ActionLog(session_id=session_id, role=role, content=content)
        self._session.add(record)
        await self._session.commit()
        await self._session.refresh(record)
        return record

    async def get_history(self, session_id: str) -> list[ActionLog]:
        result = await self._session.execute(
            select(ActionLog)
            .where(ActionLog.session_id == session_id)
            .order_by(ActionLog.created_at)
        )
        return list(result.scalars().all())

    async def get_history_page(
        self, session_id: str, limit: int, offset: int
    ) -> list[ActionLog]:
        result = await self._session.execute(
            select(ActionLog)
            .where(ActionLog.session_id == session_id)
            .order_by(ActionLog.created_at)
            .limit(limit)
            .offset(offset)
        )
        return list(result.scalars().all())

    async def count_by_session(self, session_id: str) -> int:
        result = await self._session.execute(
            select(func.count())
            .select_from(ActionLog)
            .where(ActionLog.session_id == session_id)
        )
        return int(result.scalar_one())
