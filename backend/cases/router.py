from fastapi import APIRouter, Depends, HTTPException, status

from cases.repository import CaseRepository
from cases.request import CreateCaseRequest
from cases.response import CaseResponse
from cases.service import CaseService
from dependencies import get_current_user, get_db
from exceptions.auth_exceptions import ConflictError
from models.db import User
from sqlalchemy.ext.asyncio import AsyncSession

router = APIRouter(prefix="/cases", tags=["cases"])


def get_case_repo(db: AsyncSession = Depends(get_db)) -> CaseRepository:
    return CaseRepository(db)


def get_case_service(repo: CaseRepository = Depends(get_case_repo)) -> CaseService:
    return CaseService(repo)


def _require_educator(current_user: User = Depends(get_current_user)) -> User:
    if current_user.role != "educator":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail="Educators only"
        )
    return current_user


@router.post("", response_model=CaseResponse, status_code=status.HTTP_201_CREATED)
async def create_case(
    data: CreateCaseRequest,
    current_user: User = Depends(_require_educator),
    service: CaseService = Depends(get_case_service),
) -> CaseResponse:
    try:
        return await service.create(data, created_by=current_user.id)
    except ConflictError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc
