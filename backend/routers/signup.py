from fastapi import APIRouter, Depends, HTTPException, status

from dependencies import get_auth_service
from exceptions.auth_exceptions import ConflictError
from models.request import SignupRequest
from models.response import UserResponse
from services.auth_service import AuthService

router = APIRouter()


@router.post(
    "/signup", response_model=UserResponse, status_code=status.HTTP_201_CREATED
)
async def signup(
    payload: SignupRequest, service: AuthService = Depends(get_auth_service)
) -> UserResponse:
    try:
        user = await service.signup(payload.username, payload.email, payload.password)
    except ConflictError as exc:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail=str(exc)
        ) from exc
    return UserResponse(
        id=user.id, username=user.username, email=user.email, role=user.role
    )
