from pydantic import BaseModel
import os


class Settings(BaseModel):
    telegram_token: str
    backend_base_url: str = "http://localhost:8000"
    backend_username: str = "admin"
    backend_password: str = "password"

    @classmethod
    def from_env(cls) -> "Settings":
        token = os.getenv("TELEGRAM_BOT_TOKEN")
        if not token:
            raise RuntimeError("TELEGRAM_BOT_TOKEN environment variable is required")
        return cls(
            telegram_token=token,
            backend_base_url=os.getenv("BACKEND_BASE_URL", "http://localhost:8000"),
            backend_username=os.getenv("BACKEND_USERNAME", "admin"),
            backend_password=os.getenv("BACKEND_PASSWORD", "password"),
        )
