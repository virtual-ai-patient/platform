from datetime import datetime, timedelta
from typing import Any, Dict

import jwt
from jwt import ExpiredSignatureError, InvalidTokenError


SECRET_KEY = "CHANGE_ME_TO_A_SECURE_RANDOM_KEY"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30


def create_access_token(subject: str) -> str:
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode = {"sub": subject, "exp": expire}
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


def decode_access_token(token: str) -> Dict[str, Any]:
    try:
        return jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except ExpiredSignatureError as exc:
        raise InvalidTokenError("Token has expired") from exc
    except InvalidTokenError:
        raise
