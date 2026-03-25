import asyncio
import os
from typing import Any

import models.database as database
from fastapi.testclient import TestClient
from models.db import User
from repositories.user_repository import UserRepository
from server import app
from sqlalchemy import func, select


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _login_admin(client: TestClient) -> Any:
    r = client.post(
        "/auth/login",
        data={
            "username": os.environ["ADMIN_USERNAME"],
            "password": os.environ["ADMIN_PASSWORD"],
        },
    )
    return r.json()


# ---------------------------------------------------------------------------
# Admin seeding tests
# ---------------------------------------------------------------------------


def test_admin_can_login_after_startup(client: TestClient) -> None:
    """Admin user is seeded by lifespan and can authenticate immediately."""
    r = client.post(
        "/auth/login",
        data={
            "username": os.environ["ADMIN_USERNAME"],
            "password": os.environ["ADMIN_PASSWORD"],
        },
    )
    assert r.status_code == 200
    assert "access_token" in r.json()


def test_admin_has_admin_role(client: TestClient) -> None:
    """Seeded admin has role='admin', not the default 'learner'."""
    tokens = _login_admin(client)
    r = client.get(
        "/auth/verify",
        headers={"Authorization": f"Bearer {tokens['access_token']}"},
    )
    assert r.status_code == 200
    assert r.json()["role"] == "admin"


def test_admin_password_is_hashed(client: TestClient) -> None:
    """Admin password is stored as a bcrypt hash, never as plaintext."""

    async def _get_hashed() -> str:
        async with database._TestSessionLocal() as session:  # type: ignore[attr-defined]
            repo = UserRepository(session)
            user = await repo.get_by_username(os.environ["ADMIN_USERNAME"])
            assert user is not None
            return user.hashed_password

    hashed = asyncio.run(_get_hashed())
    assert hashed != os.environ["ADMIN_PASSWORD"]  # not stored as plaintext
    assert hashed.startswith("$2b$")               # bcrypt signature


def test_admin_seed_is_idempotent(client: TestClient) -> None:
    """Running lifespan a second time on an already-seeded DB does not create a duplicate."""
    # Trigger a second lifespan cycle on the same (already-seeded) DB.
    with TestClient(app, raise_server_exceptions=True):
        pass  # lifespan runs again; must not crash or insert a duplicate

    async def _count() -> int:
        async with database._TestSessionLocal() as session:  # type: ignore[attr-defined]
            result = await session.execute(
                select(func.count()).where(User.username == os.environ["ADMIN_USERNAME"])
            )
            return int(result.scalar_one())

    assert asyncio.run(_count()) == 1  # exactly one admin row, not two
