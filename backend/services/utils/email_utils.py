import logging
import smtplib
from email.mime.text import MIMEText

from config import SMTP_HOST, SMTP_PASS, SMTP_PORT, SMTP_USER

logger = logging.getLogger(__name__)


def send_reset_email(to_email: str, reset_link: str) -> None:
    if not SMTP_HOST:
        logger.info("SMTP not configured. Password reset link: %s", reset_link)
        return

    msg = MIMEText(f"Click the link below to reset your password:\n\n{reset_link}")
    msg["Subject"] = "Password Reset"
    msg["From"] = SMTP_USER
    msg["To"] = to_email

    with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as server:
        server.starttls()
        server.login(SMTP_USER, SMTP_PASS)
        server.send_message(msg)
