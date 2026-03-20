from fastapi import APIRouter, Depends

from dependencies import get_current_user
from models.db import User
from models.response import UserResponse

router = APIRouter()


@router.get("/verify", response_model=UserResponse)
async def verify(current_user: User = Depends(get_current_user)) -> UserResponse:
    return UserResponse(
        id=current_user.id,
        username=current_user.username,
        email=current_user.email,
        role=current_user.role,
    )
