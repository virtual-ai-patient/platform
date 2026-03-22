from fastapi import APIRouter, Depends, HTTPException, status

from dependencies import get_auth_service
from exceptions.auth_exceptions import AuthenticationError
from models.request import RefreshRequest
from models.response import TokenResponse
from services.auth_service import AuthService

router = APIRouter()


@router.post("/refresh", response_model=TokenResponse)
async def refresh(
    payload: RefreshRequest, service: AuthService = Depends(get_auth_service)
) -> TokenResponse:
    try:
        return await service.refresh_tokens(payload.refresh_token)
    except AuthenticationError as exc:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail=str(exc)
        ) from exc
