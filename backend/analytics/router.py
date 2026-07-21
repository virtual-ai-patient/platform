from collections.abc import AsyncIterator
from datetime import datetime
from typing import Literal

from fastapi import APIRouter, Depends, HTTPException, Query, status
from fastapi.responses import StreamingResponse
from sqlalchemy.ext.asyncio import AsyncSession

from analytics.export import stream_csv, stream_json
from analytics.repository import AnalyticsRepository
from analytics.response import ActionExportRow, SessionExportRow
from dependencies import get_current_user, get_db
from models.db import User
from sessions.repository import SessionRepository

router = APIRouter(prefix="/analytics", tags=["analytics"])

_SESSION_FIELDS = list(SessionExportRow.model_fields.keys())
_ACTION_FIELDS = list(ActionExportRow.model_fields.keys())


def get_analytics_repo(db: AsyncSession = Depends(get_db)) -> AnalyticsRepository:
    return AnalyticsRepository(db)


def get_session_repo(db: AsyncSession = Depends(get_db)) -> SessionRepository:
    return SessionRepository(db)


def _to_response(
    format: Literal["csv", "json"],
    fieldnames: list[str],
    rows: AsyncIterator[SessionExportRow] | AsyncIterator[ActionExportRow],
    filename: str,
) -> StreamingResponse:
    if format == "csv":
        return StreamingResponse(
            stream_csv(fieldnames, rows),
            media_type="text/csv",
            headers={"Content-Disposition": f'attachment; filename="{filename}.csv"'},
        )
    return StreamingResponse(
        stream_json(rows),
        media_type="application/json",
        headers={"Content-Disposition": f'attachment; filename="{filename}.json"'},
    )


@router.get("/export/sessions")
async def export_sessions(
    format: Literal["csv", "json"] = Query("csv"),
    scope: Literal["me", "all"] = Query("me"),
    since: datetime | None = Query(None),
    until: datetime | None = Query(None),
    current_user: User = Depends(get_current_user),
    repo: AnalyticsRepository = Depends(get_analytics_repo),
) -> StreamingResponse:
    if scope == "all" and current_user.role not in ("educator", "admin"):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Educator or admin role required to export cohort scope",
        )

    learner_id = None if scope == "all" else current_user.username
    rows = repo.iter_session_rows(learner_id=learner_id, since=since, until=until)
    return _to_response(format, _SESSION_FIELDS, rows, "sessions_export")


@router.get("/export/actions")
async def export_actions(
    format: Literal["csv", "json"] = Query("csv"),
    session_id: str | None = Query(None),
    since: datetime | None = Query(None),
    until: datetime | None = Query(None),
    current_user: User = Depends(get_current_user),
    repo: AnalyticsRepository = Depends(get_analytics_repo),
    session_repo: SessionRepository = Depends(get_session_repo),
) -> StreamingResponse:
    if session_id is not None:
        session = await session_repo.get_by_session_id(session_id)
        if session is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Session '{session_id}' not found",
            )
        if session.user_id != current_user.id and current_user.role not in (
            "educator",
            "admin",
        ):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="You do not have access to this session",
            )
        learner_filter = None
    else:
        if current_user.role not in ("educator", "admin"):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Educator or admin role required to export cohort actions",
            )
        learner_filter = None

    rows = repo.iter_action_rows(
        session_id=session_id,
        learner_id=learner_filter,
        since=since,
        until=until,
    )
    return _to_response(format, _ACTION_FIELDS, rows, "actions_export")
