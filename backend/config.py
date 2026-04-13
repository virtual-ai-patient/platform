import os

from dotenv import load_dotenv

load_dotenv()

DATABASE_URL: str = os.environ["DATABASE_URL"]
SECRET_KEY: str = os.environ.get("SECRET_KEY", "CHANGE_ME_TO_A_SECURE_RANDOM_KEY")
FRONTEND_URL: str = os.environ.get("FRONTEND_URL", "http://localhost:8000")

SMTP_HOST: str | None = os.environ.get("SMTP_HOST") or None
SMTP_PORT: int = int(os.environ.get("SMTP_PORT", "587"))
SMTP_USER: str = os.environ.get("SMTP_USER", "")
SMTP_PASS: str = os.environ.get("SMTP_PASS", "")

USE_MOCK_AI: bool = os.environ.get("USE_MOCK_AI", "true").lower() == "true"
OPENAI_API_KEY: str = os.environ.get("OPENAI_API_KEY", "")
OPENAI_MODEL: str = os.environ.get("OPENAI_MODEL", "llama-3.1-8b-instant")

ADMIN_USERNAME: str = os.environ.get("ADMIN_USERNAME", "admin")
ADMIN_EMAIL: str = os.environ.get("ADMIN_EMAIL", "admin@example.com")
ADMIN_PASSWORD: str = os.environ.get("ADMIN_PASSWORD", "changeme")

EDUCATOR_USERNAME: str = os.environ.get("EDUCATOR_USERNAME", "educator")
EDUCATOR_EMAIL: str = os.environ.get("EDUCATOR_EMAIL", "educator@example.com")
EDUCATOR_PASSWORD: str = os.environ.get("EDUCATOR_PASSWORD", "changeme")

LEARNER_USERNAME: str = os.environ.get("LEARNER_USERNAME", "user")
LEARNER_EMAIL: str = os.environ.get("LEARNER_EMAIL", "user@example.com")
LEARNER_PASSWORD: str = os.environ.get("LEARNER_PASSWORD", "changeme")
