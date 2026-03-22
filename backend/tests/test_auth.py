from typing import Any

import pytest
from fastapi.testclient import TestClient

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _signup(
    client: TestClient, username: str = "alice", password: str = "secret123"
) -> Any:
    return client.post(
        "/auth/signup",
        json={
            "username": username,
            "email": f"{username}@example.com",
            "password": password,
        },
    ).json()


def _login(
    client: TestClient, username: str = "alice", password: str = "secret123"
) -> Any:
    return client.post(
        "/auth/login",
        data={"username": username, "password": password},
    ).json()


# ---------------------------------------------------------------------------
# Signup
# ---------------------------------------------------------------------------


def test_signup_success(client: TestClient) -> None:
    r = client.post(
        "/auth/signup",
        json={
            "username": "alice",
            "email": "alice@example.com",
            "password": "secret123",
        },
    )
    assert r.status_code == 201
    body = r.json()
    assert body["username"] == "alice"
    assert body["role"] == "learner"
    assert "id" in body


def test_signup_duplicate_username(client: TestClient) -> None:
    _signup(client)
    r = client.post(
        "/auth/signup",
        json={
            "username": "alice",
            "email": "other@example.com",
            "password": "secret123",
        },
    )
    assert r.status_code == 409


def test_signup_duplicate_email(client: TestClient) -> None:
    _signup(client)
    r = client.post(
        "/auth/signup",
        json={"username": "bob", "email": "alice@example.com", "password": "secret123"},
    )
    assert r.status_code == 409


# ---------------------------------------------------------------------------
# Login
# ---------------------------------------------------------------------------


def test_login_success(client: TestClient) -> None:
    _signup(client)
    r = client.post("/auth/login", data={"username": "alice", "password": "secret123"})
    assert r.status_code == 200
    body = r.json()
    assert "access_token" in body
    assert "refresh_token" in body
    assert body["token_type"] == "bearer"


def test_login_wrong_password(client: TestClient) -> None:
    _signup(client)
    r = client.post("/auth/login", data={"username": "alice", "password": "wrong"})
    assert r.status_code == 401


def test_login_unknown_user(client: TestClient) -> None:
    r = client.post("/auth/login", data={"username": "nobody", "password": "secret123"})
    assert r.status_code == 401


# ---------------------------------------------------------------------------
# Verify
# ---------------------------------------------------------------------------


def test_verify_valid_token(client: TestClient) -> None:
    _signup(client)
    tokens = _login(client)
    r = client.get(
        "/auth/verify", headers={"Authorization": f"Bearer {tokens['access_token']}"}
    )
    assert r.status_code == 200
    assert r.json()["username"] == "alice"


def test_verify_invalid_token(client: TestClient) -> None:
    r = client.get("/auth/verify", headers={"Authorization": "Bearer not.a.token"})
    assert r.status_code == 401


def test_verify_refresh_token_rejected(client: TestClient) -> None:
    _signup(client)
    tokens = _login(client)
    r = client.get(
        "/auth/verify", headers={"Authorization": f"Bearer {tokens['refresh_token']}"}
    )
    assert r.status_code == 401


# ---------------------------------------------------------------------------
# Refresh
# ---------------------------------------------------------------------------


def test_refresh_success(client: TestClient) -> None:
    _signup(client)
    tokens = _login(client)
    r = client.post("/auth/refresh", json={"refresh_token": tokens["refresh_token"]})
    assert r.status_code == 200
    new_tokens = r.json()
    assert "access_token" in new_tokens
    assert "refresh_token" in new_tokens


def test_refresh_with_access_token_rejected(client: TestClient) -> None:
    _signup(client)
    tokens = _login(client)
    r = client.post("/auth/refresh", json={"refresh_token": tokens["access_token"]})
    assert r.status_code == 401


# ---------------------------------------------------------------------------
# Password reset
# ---------------------------------------------------------------------------


def test_reset_request_known_email(client: TestClient) -> None:
    _signup(client)
    r = client.post("/auth/reset-password/request", json={"email": "alice@example.com"})
    assert r.status_code == 200
    assert (
        "reset link" in r.json()["message"].lower()
        or "registered" in r.json()["message"].lower()
    )


def test_reset_request_unknown_email_returns_generic(client: TestClient) -> None:
    r = client.post(
        "/auth/reset-password/request", json={"email": "nobody@example.com"}
    )
    # Must not reveal whether the email exists.
    assert r.status_code == 200


def test_reset_confirm_invalid_token(client: TestClient) -> None:
    r = client.post(
        "/auth/reset-password/confirm",
        json={"token": "invalid-token", "new_password": "newpass123"},
    )
    assert r.status_code == 400


def test_reset_full_flow(client: TestClient, monkeypatch: pytest.MonkeyPatch) -> None:
    """Signup → request reset → capture token → confirm → login with new password."""
    _signup(client)

    captured: list[str] = []

    def _fake_send(to_email: str, reset_link: str) -> None:
        captured.append(reset_link)

    import services.auth_service as auth_service_module

    monkeypatch.setattr(auth_service_module, "send_reset_email", _fake_send)

    client.post("/auth/reset-password/request", json={"email": "alice@example.com"})
    assert captured, "send_reset_email was not called"

    token = captured[0].split("token=")[1]

    r = client.post(
        "/auth/reset-password/confirm",
        json={"token": token, "new_password": "newpass123"},
    )
    assert r.status_code == 200

    # Old password no longer works.
    assert (
        client.post(
            "/auth/login", data={"username": "alice", "password": "secret123"}
        ).status_code
        == 401
    )
    # New password works.
    assert (
        client.post(
            "/auth/login", data={"username": "alice", "password": "newpass123"}
        ).status_code
        == 200
    )


def test_reset_token_cannot_be_reused(
    client: TestClient, monkeypatch: pytest.MonkeyPatch
) -> None:
    _signup(client)

    captured: list[str] = []

    def _fake_send(to_email: str, reset_link: str) -> None:
        captured.append(reset_link)

    import services.auth_service as auth_service_module

    monkeypatch.setattr(auth_service_module, "send_reset_email", _fake_send)

    client.post("/auth/reset-password/request", json={"email": "alice@example.com"})
    token = captured[0].split("token=")[1]

    client.post(
        "/auth/reset-password/confirm",
        json={"token": token, "new_password": "newpass123"},
    )

    r = client.post(
        "/auth/reset-password/confirm",
        json={"token": token, "new_password": "anotherpass"},
    )
    assert r.status_code == 400
