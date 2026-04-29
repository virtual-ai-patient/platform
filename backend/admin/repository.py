from datetime import date

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from admin.response import ActionLogEntry, SessionDetailResponse, SessionSummary
from exceptions.auth_exceptions import NotFoundError
from models.db import ActionLog, CaseSession, ClinicalCase, User


class AdminRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def list_sessions(
        self,
        page: int,
        page_size: int,
        student_username: str | None = None,
        case_id: str | None = None,
        on_date: date | None = None,
    ) -> tuple[list[SessionSummary], int]:
        base = (
            select(
                CaseSession.session_id,
                User.username.label("student_username"),
                ClinicalCase.case_id.label("case_id"),
                ClinicalCase.title.label("case_title"),
                CaseSession.created_at,
            )
            .join(User, User.id == CaseSession.user_id)
            .join(ClinicalCase, ClinicalCase.id == CaseSession.clinical_case_id)
        )

        if student_username is not None:
            base = base.where(User.username == student_username)
        if case_id is not None:
            base = base.where(ClinicalCase.case_id == case_id)
        if on_date is not None:
            base = base.where(func.date(CaseSession.created_at) == on_date)

        count_result = await self._session.execute(
            select(func.count()).select_from(base.subquery())
        )
        total = count_result.scalar_one()

        rows_result = await self._session.execute(
            base.order_by(CaseSession.created_at.desc())
            .offset((page - 1) * page_size)
            .limit(page_size)
        )
        rows = rows_result.all()

        summaries = [
            SessionSummary(
                session_id=r.session_id,
                student_username=r.student_username,
                case_id=r.case_id,
                case_title=r.case_title,
                created_at=r.created_at,
            )
            for r in rows
        ]
        return summaries, total

    async def get_session_detail(self, session_id: str) -> SessionDetailResponse:
        row = await self._session.execute(
            select(
                CaseSession.session_id,
                User.username.label("student_username"),
                ClinicalCase.case_id.label("case_id"),
                ClinicalCase.title.label("case_title"),
                CaseSession.created_at,
            )
            .join(User, User.id == CaseSession.user_id)
            .join(ClinicalCase, ClinicalCase.id == CaseSession.clinical_case_id)
            .where(CaseSession.session_id == session_id)
        )
        session_row = row.one_or_none()
        if session_row is None:
            raise NotFoundError(f"Session '{session_id}' not found")

        logs_result = await self._session.execute(
            select(ActionLog)
            .where(ActionLog.session_id == session_id)
            .order_by(ActionLog.created_at)
        )
        logs = logs_result.scalars().all()

        return SessionDetailResponse(
            session_id=session_row.session_id,
            student_username=session_row.student_username,
            case_id=session_row.case_id,
            case_title=session_row.case_title,
            created_at=session_row.created_at,
            action_log=[
                ActionLogEntry(
                    role=log.role,
                    content=log.content,
                    created_at=log.created_at,
                )
                for log in logs
            ],
        )
