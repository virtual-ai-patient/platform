import json
from collections.abc import AsyncIterator
from datetime import datetime
from typing import Any

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from analytics.response import ActionExportRow, SessionExportRow
from models.db import (
    ActionLog,
    CaseSession,
    ClinicalCase,
    Evaluation,
    EvaluationFinding,
    User,
)

_PAGE_SIZE = 500


def _derive_action(role: str, content: str) -> tuple[str, dict[str, Any]]:
    if role == "user":
        return "chat_user", {"text": content}
    if role == "assistant":
        return "chat_assistant", {"text": content}
    if role == "system" and content.startswith("TEST_ORDERED:"):
        return "order_test", {"test_id": content.split(":", 1)[1]}
    try:
        parsed = json.loads(content)
    except (json.JSONDecodeError, TypeError):
        parsed = None
    if isinstance(parsed, dict) and isinstance(parsed.get("action"), str):
        action_type = str(parsed["action"])
        payload = {k: v for k, v in parsed.items() if k != "action"}
        return action_type, payload
    return role, {"raw": content}


class _SessionPageRow:
    def __init__(
        self,
        *,
        session_id: str,
        case_id: str,
        case_version: int | None,
        learner_id: str,
        started_at: datetime,
        finished_at: datetime | None,
        total_score: float | None,
        score_diagnosis: float | None,
        score_diagnostics: float | None,
        score_treatment: float | None,
        score_safety: float | None,
    ) -> None:
        self.session_id = session_id
        self.case_id = case_id
        self.case_version = case_version
        self.learner_id = learner_id
        self.started_at = started_at
        self.finished_at = finished_at
        self.total_score = total_score
        self.score_diagnosis = score_diagnosis
        self.score_diagnostics = score_diagnostics
        self.score_treatment = score_treatment
        self.score_safety = score_safety


class AnalyticsRepository:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def iter_session_rows(
        self,
        *,
        learner_id: str | None,
        since: datetime | None,
        until: datetime | None,
        page_size: int = _PAGE_SIZE,
    ) -> AsyncIterator[SessionExportRow]:
        offset = 0
        while True:
            page = await self._fetch_session_page(
                learner_id, since, until, offset, page_size
            )
            if not page:
                return
            session_ids = [row.session_id for row in page]
            findings_by_session = await self._fetch_findings_by_severity(session_ids)
            for row in page:
                yield SessionExportRow(
                    session_id=row.session_id,
                    case_id=row.case_id,
                    case_version=row.case_version,
                    learner_id=row.learner_id,
                    started_at=row.started_at,
                    finished_at=row.finished_at,
                    total_score=row.total_score,
                    score_diagnosis=row.score_diagnosis,
                    score_diagnostics=row.score_diagnostics,
                    score_treatment=row.score_treatment,
                    score_safety=row.score_safety,
                    findings_by_severity=findings_by_session.get(row.session_id, {}),
                )
            if len(page) < page_size:
                return
            offset += page_size

    async def _fetch_session_page(
        self,
        learner_id: str | None,
        since: datetime | None,
        until: datetime | None,
        offset: int,
        page_size: int,
    ) -> list[_SessionPageRow]:
        query = (
            select(
                CaseSession.session_id,
                ClinicalCase.case_id.label("case_id"),
                Evaluation.case_version.label("case_version"),
                User.username.label("learner_id"),
                CaseSession.created_at.label("started_at"),
                CaseSession.status.label("status"),
                CaseSession.last_activity_at.label("finished_at"),
                Evaluation.total_score.label("total_score"),
                Evaluation.score_diagnosis.label("score_diagnosis"),
                Evaluation.score_diagnostics.label("score_diagnostics"),
                Evaluation.score_treatment.label("score_treatment"),
                Evaluation.score_safety.label("score_safety"),
            )
            .join(User, User.id == CaseSession.user_id)
            .join(ClinicalCase, ClinicalCase.id == CaseSession.clinical_case_id)
            .outerjoin(Evaluation, Evaluation.session_id == CaseSession.session_id)
        )
        if learner_id is not None:
            query = query.where(User.username == learner_id)
        if since is not None:
            query = query.where(CaseSession.created_at >= since)
        if until is not None:
            query = query.where(CaseSession.created_at <= until)

        query = query.order_by(CaseSession.session_id).offset(offset).limit(page_size)
        result = await self._session.execute(query)
        rows = result.all()
        return [
            _SessionPageRow(
                session_id=r.session_id,
                case_id=r.case_id,
                case_version=r.case_version,
                learner_id=r.learner_id,
                started_at=r.started_at,
                finished_at=(
                    r.finished_at if r.status in ("completed", "abandoned") else None
                ),
                total_score=r.total_score,
                score_diagnosis=r.score_diagnosis,
                score_diagnostics=r.score_diagnostics,
                score_treatment=r.score_treatment,
                score_safety=r.score_safety,
            )
            for r in rows
        ]

    async def _fetch_findings_by_severity(
        self, session_ids: list[str]
    ) -> dict[str, dict[str, int]]:
        if not session_ids:
            return {}
        result = await self._session.execute(
            select(
                Evaluation.session_id,
                EvaluationFinding.severity,
                func.count().label("count"),
            )
            .join(EvaluationFinding, EvaluationFinding.evaluation_id == Evaluation.id)
            .where(Evaluation.session_id.in_(session_ids))
            .group_by(Evaluation.session_id, EvaluationFinding.severity)
        )
        out: dict[str, dict[str, int]] = {}
        for session_id, severity, count in result.all():
            out.setdefault(session_id, {})[severity] = int(count)
        return out

    async def iter_action_rows(
        self,
        *,
        session_id: str | None,
        learner_id: str | None,
        since: datetime | None,
        until: datetime | None,
        page_size: int = _PAGE_SIZE,
    ) -> AsyncIterator[ActionExportRow]:
        offset = 0
        while True:
            page = await self._fetch_action_page(
                session_id, learner_id, since, until, offset, page_size
            )
            if not page:
                return
            for row in page:
                action_type, payload = _derive_action(row.role, row.content)
                yield ActionExportRow(
                    session_id=row.session_id,
                    learner_id=row.learner_id,
                    turn_index=row.turn_index,
                    timestamp=row.created_at,
                    action_type=action_type,
                    payload_json=payload,
                )
            if len(page) < page_size:
                return
            offset += page_size

    async def _fetch_action_page(
        self,
        session_id: str | None,
        learner_id: str | None,
        since: datetime | None,
        until: datetime | None,
        offset: int,
        page_size: int,
    ) -> list[Any]:
        turn_index = (
            func.row_number()
            .over(
                partition_by=ActionLog.session_id,
                order_by=ActionLog.created_at,
            )
            .label("turn_index")
        )
        query = (
            select(
                ActionLog.session_id,
                User.username.label("learner_id"),
                ActionLog.role,
                ActionLog.content,
                ActionLog.created_at,
                (turn_index - 1).label("turn_index"),
            )
            .join(CaseSession, CaseSession.session_id == ActionLog.session_id)
            .join(User, User.id == CaseSession.user_id)
        )
        if session_id is not None:
            query = query.where(ActionLog.session_id == session_id)
        if learner_id is not None:
            query = query.where(User.username == learner_id)
        if since is not None:
            query = query.where(ActionLog.created_at >= since)
        if until is not None:
            query = query.where(ActionLog.created_at <= until)

        subquery = query.subquery()
        paged = (
            select(subquery)
            .order_by(subquery.c.session_id, subquery.c.turn_index)
            .offset(offset)
            .limit(page_size)
        )
        result = await self._session.execute(paged)
        return list(result.all())
