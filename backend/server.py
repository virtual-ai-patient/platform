import logging
from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import models.database as _db
from config import (
    ADMIN_EMAIL,
    ADMIN_PASSWORD,
    ADMIN_USERNAME,
    EDUCATOR_EMAIL,
    EDUCATOR_PASSWORD,
    EDUCATOR_USERNAME,
    LEARNER_EMAIL,
    LEARNER_PASSWORD,
    LEARNER_USERNAME,
)
from models.database import Base
from repositories.user_repository import UserRepository
from cases.router import router as cases_router
from routers import login, refresh, reset_password, signup, verify
<<<<<<< HEAD
from services.utils.auth import hash_password
=======
from sessions.router import router as sessions_router
>>>>>>> 97d1017 (feat(backend): sessions:#28)

logging.basicConfig(level=logging.INFO)

logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    async with _db.engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    async with _db.SessionLocal() as session:
        repo = UserRepository(session)
        if not await repo.exists_by_username_or_email(ADMIN_USERNAME, ADMIN_EMAIL):
            await repo.create(
                ADMIN_USERNAME,
                ADMIN_EMAIL,
                hash_password(ADMIN_PASSWORD),
                role="admin",
            )
            logger.info("Admin user seeded: %s", ADMIN_USERNAME)
        else:
            logger.info("Admin user already exists, skipping seed")

        if not await repo.exists_by_username_or_email(
            EDUCATOR_USERNAME, EDUCATOR_EMAIL
        ):
            await repo.create(
                EDUCATOR_USERNAME,
                EDUCATOR_EMAIL,
                hash_password(EDUCATOR_PASSWORD),
                role="educator",
            )
            logger.info("Educator user seeded: %s", EDUCATOR_USERNAME)
        else:
            logger.info("Educator user already exists, skipping seed")

        if not await repo.exists_by_username_or_email(
            LEARNER_USERNAME, LEARNER_EMAIL
        ):
            await repo.create(
                LEARNER_USERNAME,
                LEARNER_EMAIL,
                hash_password(LEARNER_PASSWORD),
                role="learner",
            )
            logger.info("Learner user seeded: %s", LEARNER_USERNAME)
        else:
            logger.info("Learner user already exists, skipping seed")

    yield


app = FastAPI(lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(signup.router, prefix="/auth", tags=["auth"])
app.include_router(login.router, prefix="/auth", tags=["auth"])
app.include_router(refresh.router, prefix="/auth", tags=["auth"])
app.include_router(verify.router, prefix="/auth", tags=["auth"])
app.include_router(reset_password.router, prefix="/auth", tags=["auth"])
app.include_router(cases_router)
app.include_router(sessions_router)
