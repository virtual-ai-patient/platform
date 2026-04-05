# Set env vars before any app imports so config.py reads the right values.
import os

os.environ.setdefault("SECRET_KEY", "test-secret-key-that-is-long-enough-for-hs256")
os.environ.setdefault("FRONTEND_URL", "http://localhost:8080")
os.environ.setdefault("ADMIN_USERNAME", "admin")
os.environ.setdefault("ADMIN_EMAIL", "admin@example.com")
os.environ.setdefault("ADMIN_PASSWORD", "changeme")
# DATABASE_URL is set per-worker in the session fixture below; provide a
# fallback so the module-level import in database.py doesn't crash on collection.
os.environ.setdefault("DATABASE_URL", "sqlite+aiosqlite:///./test_auth.db")

import asyncio
import uuid
from collections.abc import AsyncGenerator, Generator
from typing import cast

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine

import models.database as database
from models.database import Base
from dependencies import get_db
from models.db import User
from server import app
from services.utils.auth import hash_password

_TEST_PASSWORD = "secret123"


@pytest.fixture(scope="session", autouse=True)
def _worker_db(worker_id: str) -> Generator[None, None, None]:
    """Give each xdist worker its own SQLite file to avoid DB conflicts."""
    db_file = "test_auth.db" if worker_id == "master" else f"test_auth_{worker_id}.db"
    db_path = f"tests/{db_file}"
    url = f"sqlite+aiosqlite:///./{db_path}"

    # Remove stale DB from any previous interrupted run.
    try:
        os.remove(db_path)
    except FileNotFoundError:
        pass

    engine = create_async_engine(url, connect_args={"check_same_thread": False})
    session_local = async_sessionmaker(engine, expire_on_commit=False)

    # Patch module-level references used by the app.
    database.engine = engine
    database.SessionLocal = session_local

    async def _override_get_db() -> AsyncGenerator[AsyncSession, None]:
        async with session_local() as session:
            yield session

    app.dependency_overrides[get_db] = _override_get_db

    # Store on the database module so the client fixture can reference them.
    database._test_engine = engine  # type: ignore[attr-defined]
    database._TestSessionLocal = session_local  # type: ignore[attr-defined]

    yield

    # Clean up the DB file after the session.
    asyncio.run(engine.dispose())
    try:
        os.remove(db_path)
    except FileNotFoundError:
        pass


@pytest.fixture()
def client() -> Generator[TestClient, None, None]:
    # Each test gets a fresh schema.
    engine = database._test_engine  # type: ignore[attr-defined]

    async def _reset() -> None:
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.drop_all)
            await conn.run_sync(Base.metadata.create_all)

    asyncio.run(_reset())

    with TestClient(app, raise_server_exceptions=True) as c:
        yield c


def _insert_user(username: str, role: str) -> None:
    """Insert a user with the given role directly into the test DB."""

    async def _run() -> None:
        session_factory = cast(
            async_sessionmaker[AsyncSession],
            database._TestSessionLocal,  # type: ignore[attr-defined]
        )
        async with session_factory() as session:
            session.add(
                User(
                    id=str(uuid.uuid4()),
                    username=username,
                    email=f"{username}@example.com",
                    hashed_password=hash_password(_TEST_PASSWORD),
                    role=role,
                )
            )
            await session.commit()

    asyncio.run(_run())


@pytest.fixture()
def educator_headers(client: TestClient) -> dict[str, str]:
    # Distinct from the platform-seeded EDUCATOR_USERNAME (default "educator") so
    # tests do not violate unique constraints after lifespan seeding.
    _insert_user("test_educator", "educator")
    tokens: dict[str, str] = client.post(
        "/auth/login",
        data={"username": "test_educator", "password": _TEST_PASSWORD},
    ).json()
    return {"Authorization": f"Bearer {tokens['access_token']}"}


@pytest.fixture()
def learner_headers(client: TestClient) -> dict[str, str]:
    _insert_user("learner", "learner")
    tokens: dict[str, str] = client.post(
        "/auth/login", data={"username": "learner", "password": _TEST_PASSWORD}
    ).json()
    return {"Authorization": f"Bearer {tokens['access_token']}"}


@pytest.fixture()
def admin_headers(client: TestClient) -> dict[str, str]:
    _insert_user("test_admin_api", "admin")
    tokens: dict[str, str] = client.post(
        "/auth/login",
        data={"username": "test_admin_api", "password": _TEST_PASSWORD},
    ).json()
    return {"Authorization": f"Bearer {tokens['access_token']}"}
