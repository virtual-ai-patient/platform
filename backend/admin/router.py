from datetime import date

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from admin.repository import AdminRepository
from admin.response import SessionDetailResponse, SessionListResponse
from dependencies import get_db, require_educator_or_admin
from exceptions.auth_exceptions import NotFoundError
from models.db import User

router = APIRouter(prefix="/admin", tags=["admin"])


def get_admin_repo(db: AsyncSession = Depends(get_db)) -> AdminRepository:
    return AdminRepository(db)


@router.get("/sessions", response_model=SessionListResponse)
async def list_sessions(
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=100),
    student: str | None = Query(None),
    case_id: str | None = Query(None),
    on_date: date | None = Query(None),
    _: User = Depends(require_educator_or_admin),
    repo: AdminRepository = Depends(get_admin_repo),
) -> SessionListResponse:
    sessions, total = await repo.list_sessions(
        page=page,
        page_size=page_size,
        student_username=student,
        case_id=case_id,
        on_date=on_date,
    )
    return SessionListResponse(
        sessions=sessions,
        total=total,
        page=page,
        page_size=page_size,
    )


@router.get("/sessions/{session_id}", response_model=SessionDetailResponse)
async def get_session_detail(
    session_id: str,
    _: User = Depends(require_educator_or_admin),
    repo: AdminRepository = Depends(get_admin_repo),
) -> SessionDetailResponse:
    try:
        return await repo.get_session_detail(session_id)
    except NotFoundError as exc:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=str(exc)
        ) from exc
