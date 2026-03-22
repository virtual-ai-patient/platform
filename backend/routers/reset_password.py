import logging

from fastapi import APIRouter, Depends, HTTPException, status

from dependencies import get_auth_service
from exceptions.auth_exceptions import BadRequestError
from models.request import PasswordResetConfirm, PasswordResetRequest
from models.response import MessageResponse
from services.auth_service import AuthService

logger = logging.getLogger(__name__)

router = APIRouter()

_GENERIC_RESPONSE = MessageResponse(
    message="If that email is registered, a reset link has been sent."
)


@router.post("/reset-password/request", response_model=MessageResponse)
async def reset_password_request(
    payload: PasswordResetRequest, service: AuthService = Depends(get_auth_service)
) -> MessageResponse:
    await service.request_password_reset(payload.email)
    return _GENERIC_RESPONSE


@router.post("/reset-password/confirm", response_model=MessageResponse)
async def reset_password_confirm(
    payload: PasswordResetConfirm, service: AuthService = Depends(get_auth_service)
) -> MessageResponse:
    try:
        await service.confirm_password_reset(payload.token, payload.new_password)
    except BadRequestError as exc:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail=str(exc)
        ) from exc
    return MessageResponse(message="Password reset successful.")
