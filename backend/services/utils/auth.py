import base64
import hashlib
import secrets
from datetime import datetime, timedelta, timezone
from typing import Any

import bcrypt
import jwt
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm  # noqa: F401
from jwt import ExpiredSignatureError, InvalidTokenError

from config import SECRET_KEY

ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
REFRESH_TOKEN_EXPIRE_DAYS = 7
RESET_TOKEN_EXPIRE_MINUTES = 30

# Reusable FastAPI security dependency — import this in server.py.
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")


def _prehash(value: str) -> bytes:
    """SHA-256 prehash → 44-byte base64 payload for bcrypt.

    bcrypt has a hard 72-byte input limit. Prehashing normalises any input to a
    fixed 44-byte base64 string, avoiding truncation or errors.
    """
    return base64.b64encode(hashlib.sha256(value.encode()).digest())


# ---------------------------------------------------------------------------
# Password helpers
# ---------------------------------------------------------------------------


def hash_password(password: str) -> str:
    return bcrypt.hashpw(_prehash(password), bcrypt.gensalt()).decode()


def verify_password(plain: str, hashed: str) -> bool:
    return bcrypt.checkpw(_prehash(plain), hashed.encode())


# ---------------------------------------------------------------------------
# JWT helpers
# ---------------------------------------------------------------------------


def create_access_token(subject: str, role: str) -> str:
    expire = datetime.now(timezone.utc) + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    payload = {"sub": subject, "role": role, "type": "access", "exp": expire}
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)


def create_refresh_token(subject: str) -> str:
    expire = datetime.now(timezone.utc) + timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS)
    payload = {"sub": subject, "type": "refresh", "exp": expire}
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)


def decode_token(token: str) -> dict[str, Any]:
    try:
        return jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except ExpiredSignatureError as exc:
        raise InvalidTokenError("Token has expired") from exc


# ---------------------------------------------------------------------------
# Password-reset token helpers
# ---------------------------------------------------------------------------


def generate_reset_token() -> tuple[str, str]:
    """Return (plain_token, hashed_token). Store only the hash."""
    plain = secrets.token_urlsafe(32)
    hashed = bcrypt.hashpw(_prehash(plain), bcrypt.gensalt()).decode()
    return plain, hashed


def verify_reset_token(plain: str, hashed: str) -> bool:
    return bcrypt.checkpw(_prehash(plain), hashed.encode())
