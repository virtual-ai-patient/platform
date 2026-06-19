"""Integration tests for persistent session API (issue #70)."""

import asyncio
from typing import Any, cast

import pytest
from fastapi.testclient import TestClient
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from models.db import ClinicalCase


# ---------------------------------------------------------------------------
# Helpers shared with test_sessions.py
# ---------------------------------------------------------------------------


def _minimal_case(case_id: str = "persist_case_001") -> dict[str, Any]:
    return {
        "case_id": case_id,
        "title": "Persistent test case",
        "language": "en",
        "difficulty": "easy",
        "specialty": "general",
        "tags": [],
        "age": 30,
        "sex": "female",
        "persona": "Quiet accountant.",
        "tone_presets": ["neutral"],
        "chief_complaint": "Headache",
        "history_of_present_illness": "Tension headache for two days.",
        "key_history_points": {
            "must_ask": ["Duration"],
            "nice_to_ask": [],
            "red_flags": [],
        },
        "final_diagnosis": "Tension headache",
        "differential": ["Tension headache", "Migraine"],
        "severity_or_stage": None,
        "investigations": {
            "catalog_hints": [],
            "expected": {"must_order": [], "optional": [], "should_not_order": []},
            "results": [],
        },
        "management": {
            "diagnostic_plan": [],
            "treatment_plan": ["Analgesia"],
            "contraindications": [],
            "follow_up": [],
        },
        "scoring": {
            "weight_diagnosis": 0.4,
            "weight_diagnostics": 0.2,
            "weight_treatment": 0.3,
            "weight_safety": 0.1,
            "acceptable_answers": [
                {"field": "final_diagnosis", "answer": "Tension headache"}
            ],
            "critical_safety_errors": [],
        },
    }


def _publish_case(case_id: str) -> None:
    async def _run() -> None:
        session_factory = cast(
            async_sessionmaker[AsyncSession],
            database._TestSessionLocal,  # type: ignore[attr-defined]
        )
        async with session_factory() as session:
            await session.execute(
                update(ClinicalCase)
                .where(ClinicalCase.case_id == case_id)
                .values(status="published")
            )
            await session.commit()

    asyncio.run(_run())


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture()
def published_case_id(client: TestClient, educator_headers: dict[str, str]) -> str:
    r = client.post(
        "/cases", json=_minimal_case("persist_pub_001"), headers=educator_headers
    )
    assert r.status_code == 201
    cid: str = r.json()["case_id"]
    _publish_case(cid)
    return cid


@pytest.fixture()
def active_session_id(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> str:
    r = client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    assert r.status_code == 201
    return str(r.json()["session_id"])


# ---------------------------------------------------------------------------
# GET /sessions/active
# ---------------------------------------------------------------------------


def test_list_active_sessions_returns_caller_sessions(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    r = client.get("/sessions/active", headers=learner_headers)
    assert r.status_code == 200
    items = r.json()
    assert len(items) == 1
    item = items[0]
    assert "session_id" in item
    assert item["case_id"] == published_case_id
    assert "case_title" in item
    assert "created_at" in item
    assert "last_activity_at" in item
    assert "progress_summary" in item
    assert item["progress_summary"]["turn_count"] == 0
    assert item["progress_summary"]["has_conclusions"] is False


def test_list_active_sessions_excludes_completed(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    r = client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    sid = r.json()["session_id"]
    client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "Tension headache"},
        headers=learner_headers,
    )
    client.post(f"/sessions/{sid}/finish", headers=learner_headers)

    r2 = client.get("/sessions/active", headers=learner_headers)
    assert r2.status_code == 200
    assert r2.json() == []


def test_list_active_sessions_unauthenticated(client: TestClient) -> None:
    r = client.get("/sessions/active")
    assert r.status_code == 401


def test_list_active_sessions_empty(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    r = client.get("/sessions/active", headers=learner_headers)
    assert r.status_code == 200
    assert r.json() == []


def test_list_active_sessions_progress_summary_reflects_conclusions(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    r = client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    sid = r.json()["session_id"]
    client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "Tension headache"},
        headers=learner_headers,
    )

    r2 = client.get("/sessions/active", headers=learner_headers)
    assert r2.status_code == 200
    summary = r2.json()[0]["progress_summary"]
    assert summary["has_conclusions"] is True


# ---------------------------------------------------------------------------
# GET /sessions/{id}/state
# ---------------------------------------------------------------------------


def test_get_session_state_success(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session_id: str,
) -> None:
    r = client.get(f"/sessions/{active_session_id}/state", headers=learner_headers)
    assert r.status_code == 200
    body = r.json()
    assert body["session_id"] == active_session_id
    assert body["status"] == "active"
    assert "created_at" in body
    assert "last_activity_at" in body
    assert "case_snapshot" in body
    assert "chat_history" in body
    assert body["chat_history"] == []
    assert body["next_cursor"] is None
    assert body["ordered_tests"] == []
    assert body["conclusions"] is None


def test_get_session_state_includes_conclusions(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session_id: str,
) -> None:
    client.patch(
        f"/sessions/{active_session_id}/conclusions",
        json={"final_diagnosis": "Tension headache"},
        headers=learner_headers,
    )
    r = client.get(f"/sessions/{active_session_id}/state", headers=learner_headers)
    assert r.status_code == 200
    assert r.json()["conclusions"]["final_diagnosis"] == "Tension headache"


def test_get_session_state_not_owner(
    client: TestClient,
    learner_headers: dict[str, str],
    educator_headers: dict[str, str],
    active_session_id: str,
) -> None:
    r = client.get(f"/sessions/{active_session_id}/state", headers=educator_headers)
    assert r.status_code == 403


def test_get_session_state_admin_can_access_any(
    client: TestClient,
    learner_headers: dict[str, str],
    admin_headers: dict[str, str],
    active_session_id: str,
) -> None:
    r = client.get(f"/sessions/{active_session_id}/state", headers=admin_headers)
    assert r.status_code == 200
    assert r.json()["session_id"] == active_session_id


def test_get_session_state_nonexistent(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    r = client.get("/sessions/does-not-exist/state", headers=learner_headers)
    assert r.status_code == 404


def test_get_session_state_unauthenticated(
    client: TestClient,
    active_session_id: str,
) -> None:
    r = client.get(f"/sessions/{active_session_id}/state")
    assert r.status_code == 401


# ---------------------------------------------------------------------------
# POST /sessions/start — duplicate / force
# ---------------------------------------------------------------------------


def test_start_session_duplicate_returns_409(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    r1 = client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    assert r1.status_code == 201
    existing_sid = r1.json()["session_id"]

    r2 = client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    assert r2.status_code == 409
    detail = r2.json()["detail"]
    assert detail["existing_session_id"] == existing_sid


def test_start_session_force_abandons_old_and_starts_fresh(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    r1 = client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    old_sid = r1.json()["session_id"]

    r2 = client.post(
        "/sessions/start?force=true",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    assert r2.status_code == 201
    new_sid = r2.json()["session_id"]
    assert new_sid != old_sid

    r3 = client.get(f"/sessions/{old_sid}/state", headers=learner_headers)
    assert r3.json()["status"] == "abandoned"


def test_start_session_no_conflict_for_different_cases(
    client: TestClient,
    learner_headers: dict[str, str],
    educator_headers: dict[str, str],
) -> None:
    r1 = client.post(
        "/cases",
        json=_minimal_case("persist_case_a"),
        headers=educator_headers,
    )
    assert r1.status_code == 201
    _publish_case("persist_case_a")

    r2 = client.post(
        "/cases",
        json=_minimal_case("persist_case_b"),
        headers=educator_headers,
    )
    assert r2.status_code == 201
    _publish_case("persist_case_b")

    ra = client.post(
        "/sessions/start",
        json={"case_id": "persist_case_a"},
        headers=learner_headers,
    )
    assert ra.status_code == 201

    rb = client.post(
        "/sessions/start",
        json={"case_id": "persist_case_b"},
        headers=learner_headers,
    )
    assert rb.status_code == 201


# ---------------------------------------------------------------------------
# POST /sessions/{id}/abandon
# ---------------------------------------------------------------------------


def test_abandon_session_success(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session_id: str,
) -> None:
    r = client.post(f"/sessions/{active_session_id}/abandon", headers=learner_headers)
    assert r.status_code == 200
    body = r.json()
    assert body["session_id"] == active_session_id
    assert body["status"] == "abandoned"


def test_abandon_session_removes_from_active_list(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session_id: str,
) -> None:
    client.post(f"/sessions/{active_session_id}/abandon", headers=learner_headers)
    r = client.get("/sessions/active", headers=learner_headers)
    assert r.status_code == 200
    assert r.json() == []


def test_abandon_session_not_owner(
    client: TestClient,
    learner_headers: dict[str, str],
    educator_headers: dict[str, str],
    active_session_id: str,
) -> None:
    r = client.post(f"/sessions/{active_session_id}/abandon", headers=educator_headers)
    assert r.status_code == 403


def test_abandon_session_already_completed_returns_409(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session_id: str,
) -> None:
    client.patch(
        f"/sessions/{active_session_id}/conclusions",
        json={"final_diagnosis": "Tension headache"},
        headers=learner_headers,
    )
    client.post(f"/sessions/{active_session_id}/finish", headers=learner_headers)

    r = client.post(f"/sessions/{active_session_id}/abandon", headers=learner_headers)
    assert r.status_code == 409


def test_abandon_session_nonexistent(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    r = client.post("/sessions/ghost-id/abandon", headers=learner_headers)
    assert r.status_code == 404


def test_abandon_session_unauthenticated(
    client: TestClient,
    active_session_id: str,
) -> None:
    r = client.post(f"/sessions/{active_session_id}/abandon")
    assert r.status_code == 401


# ---------------------------------------------------------------------------
# last_activity_at is updated on write operations
# ---------------------------------------------------------------------------


def test_last_activity_at_updated_on_save_conclusions(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session_id: str,
) -> None:
    r0 = client.get(f"/sessions/{active_session_id}/state", headers=learner_headers)
    t0 = r0.json()["last_activity_at"]

    import time

    time.sleep(0.05)

    client.patch(
        f"/sessions/{active_session_id}/conclusions",
        json={"final_diagnosis": "Tension headache"},
        headers=learner_headers,
    )

    r1 = client.get(f"/sessions/{active_session_id}/state", headers=learner_headers)
    t1 = r1.json()["last_activity_at"]

    assert t1 >= t0
