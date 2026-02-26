from fastapi import FastAPI, HTTPException, status

from auth import create_access_token
from models_request import LoginRequest
from models_response import TokenResponse


app = FastAPI()


@app.post("/login", response_model=TokenResponse)
def login(payload: LoginRequest) -> TokenResponse:
    if not (payload.username == "admin" and payload.password == "password"):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid username or password",
        )

    token = create_access_token(subject=payload.username)
    return TokenResponse(access_token=token)
