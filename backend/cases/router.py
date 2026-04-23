from typing import Annotated, Literal

from fastapi import APIRouter, Depends, HTTPException, Query, status

from cases.repository import CaseRepository
from cases.request import CreateCaseRequest, UpdateCaseRequest
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


def _require_educator_or_admin(current_user: User = Depends(get_current_user)) -> User:
    if current_user.role not in ("educator", "admin"):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail="Educators or admins only"
        )
    return current_user


@router.get("", response_model=list[CaseResponse])
async def list_cases(
    case_status: Annotated[
        Literal["draft", "review", "published"] | None,
        Query(
            alias="status",
            description="Educators: filter by workflow status",
        ),
    ] = None,
    current_user: User = Depends(get_current_user),
    service: CaseService = Depends(get_case_service),
) -> list[CaseResponse]:
    if current_user.role == "learner":
        return await service.list_cases(status=None, published_only=True)
    if current_user.role == "educator":
        return await service.list_cases(
            status=case_status, published_only=False
        )
    raise HTTPException(
        status_code=status.HTTP_403_FORBIDDEN, detail="Forbidden"
    )


@router.put("/{id}", response_model=CaseResponse)
async def update_case(
    id: str,
    data: UpdateCaseRequest,
    current_user: User = Depends(_require_educator_or_admin),
    service: CaseService = Depends(get_case_service),
) -> CaseResponse:
    case = await service.get_by_id(id)
    if case is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="Case not found"
        )
    return await service.update(case, data)


@router.post("", response_model=CaseResponse, status_code=status.HTTP_201_CREATED)
async def create_case(
    data: CreateCaseRequest,
    current_user: User = Depends(_require_educator_or_admin),
    service: CaseService = Depends(get_case_service),
) -> CaseResponse:
    try:
        return await service.create(data, created_by=current_user.id)
    except ConflictError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc


@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_case(
    id: str,
    current_user: User = Depends(_require_educator_or_admin),
    service: CaseService = Depends(get_case_service),
) -> None:
    case = await service.get_by_id(id)
    if case is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="Case not found"
        )
    await service.delete_existing(case)
