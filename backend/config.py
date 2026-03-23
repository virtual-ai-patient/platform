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

ADMIN_USERNAME: str = os.environ.get("ADMIN_USERNAME", "admin")
ADMIN_EMAIL: str = os.environ.get("ADMIN_EMAIL", "admin@example.com")
ADMIN_PASSWORD: str = os.environ.get("ADMIN_PASSWORD", "changeme")
