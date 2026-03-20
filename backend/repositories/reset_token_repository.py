from datetime import datetime, timezone

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from models.db import ResetToken


class ResetTokenRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def create(
        self, user_id: str, token_hash: str, expires_at: datetime
    ) -> ResetToken:
        token = ResetToken(
            user_id=user_id, token_hash=token_hash, expires_at=expires_at
        )
        self._session.add(token)
        await self._session.commit()
        return token

    async def get_active_tokens(self) -> list[ResetToken]:
        now = datetime.now(timezone.utc)
        result = await self._session.execute(
            select(ResetToken).where(
                ResetToken.is_used == False,  # noqa: E712
                ResetToken.expires_at > now,
            )
        )
        return list(result.scalars().all())

    async def mark_used(self, token: ResetToken) -> None:
        token.is_used = True
        await self._session.commit()
