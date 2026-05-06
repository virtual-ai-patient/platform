"""Integration tests for POST /sessions/start (Session Initialization)."""

import asyncio
from typing import Any, cast

import pytest
from fastapi.testclient import TestClient
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from models.db import ClinicalCase


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _minimal_case(case_id: str = "session_case_001") -> dict[str, Any]:
    return {
        "case_id": case_id,
        "title": "Acute chest pain",
        "language": "en",
        "difficulty": "medium",
        "specialty": "emergency_medicine",
        "tags": ["chest_pain"],
        "age": 54,
        "sex": "male",
        "persona": "Worried delivery driver.",
        "tone_presets": ["neutral"],
        "chief_complaint": "Chest pain",
        "history_of_present_illness": "Substernal pressure for 45 minutes.",
        "key_history_points": {
            "must_ask": ["Onset and duration"],
            "nice_to_ask": ["Recent exertion"],
            "red_flags": ["Syncope"],
        },
        "final_diagnosis": "STEMI",
        "differential": ["STEMI", "Unstable angina"],
        "severity_or_stage": None,
        "investigations": {
            "catalog_hints": ["ECG"],
            "expected": {
                "must_order": ["ECG"],
                "optional": [],
                "should_not_order": [],
            },
            "results": [
                {
                    "test_name": "ECG",
                    "result_type": "text_report",
                    "value": "ST elevation.",
                    "unit": None,
                    "reference_range": None,
                }
            ],
        },
        "management": {
            "diagnostic_plan": ["Immediate ECG"],
            "treatment_plan": ["Activate cath lab"],
            "contraindications": [],
            "follow_up": [],
        },
        "scoring": {
            "weight_diagnosis": 0.35,
            "weight_diagnostics": 0.25,
            "weight_treatment": 0.30,
            "weight_safety": 0.10,
            "acceptable_answers": [{"field": "final_diagnosis", "answer": "STEMI"}],
            "critical_safety_errors": [],
        },
    }


def _publish_case(case_id: str) -> None:
    """Flip a case's status to 'published' directly in the test DB."""

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
def draft_case_id(client: TestClient, educator_headers: dict[str, str]) -> str:
    """Create a draft case and return its case_id string."""
    payload = _minimal_case("session_draft_001")
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 201
    return str(r.json()["case_id"])


@pytest.fixture()
def published_case_id(client: TestClient, educator_headers: dict[str, str]) -> str:
    """Create a case and immediately publish it, return its case_id string."""
    payload = _minimal_case("session_published_001")
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 201
    cid: str = r.json()["case_id"]
    _publish_case(cid)
    return cid


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------


def test_start_session_published_case_learner(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """AC #1 — POST /sessions/start returns 201 with a unique session_id."""
    r = client.post(
        "/sessions/start",
        json={"case_id": published_case_id},
        headers=learner_headers,
    )
    assert r.status_code == 201
    body = r.json()
    assert "session_id" in body
    assert body["case_id"] == published_case_id
    assert body["status"] == "active"
    assert "created_at" in body


def test_start_session_draft_case_learner_forbidden(
    client: TestClient,
    learner_headers: dict[str, str],
    draft_case_id: str,
) -> None:
    """AC #2 — Learners cannot start a draft case (403 Forbidden)."""
    r = client.post(
        "/sessions/start",
        json={"case_id": draft_case_id},
        headers=learner_headers,
    )
    assert r.status_code == 403


def test_start_session_draft_case_educator_allowed(
    client: TestClient,
    educator_headers: dict[str, str],
    draft_case_id: str,
) -> None:
    """Educators can start even draft cases (no status restriction)."""
    r = client.post(
        "/sessions/start",
        json={"case_id": draft_case_id},
        headers=educator_headers,
    )
    assert r.status_code == 201
    assert "session_id" in r.json()


def test_start_session_nonexistent_case(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    """Requesting a non-existent case_id returns 404 Not Found."""
    r = client.post(
        "/sessions/start",
        json={"case_id": "does_not_exist_xyz"},
        headers=learner_headers,
    )
    assert r.status_code == 404


def test_start_session_unauthenticated(client: TestClient) -> None:
    """Unauthenticated request returns 401 Unauthorized."""
    r = client.post(
        "/sessions/start",
        json={"case_id": "any_case"},
    )
    assert r.status_code == 401


# ---------------------------------------------------------------------------
# Helpers for conclusions / finish tests
# ---------------------------------------------------------------------------


def _start_session(client: TestClient, headers: dict[str, str], case_id: str) -> str:
    r = client.post("/sessions/start", json={"case_id": case_id}, headers=headers)
    assert r.status_code == 201
    return str(r.json()["session_id"])


_FULL_CONCLUSIONS = {
    "differential_diagnoses": [
        {"rank": 1, "condition": "STEMI"},
        {"rank": 2, "condition": "Unstable angina"},
    ],
    "final_diagnosis": "STEMI",
    "treatment_plan": {
        "medications": [{"name": "Aspirin", "dose": "325mg", "route": "oral"}],
        "non_pharmacological": ["Oxygen therapy"],
        "referrals": ["Cardiology"],
        "follow_up": ["Repeat ECG in 30 min"],
    },
}


# ---------------------------------------------------------------------------
# PATCH /sessions/{id}/conclusions
# ---------------------------------------------------------------------------


def test_save_conclusions_partial(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """PATCH with only differential diagnoses is accepted (incremental save)."""
    sid = _start_session(client, learner_headers, published_case_id)
    r = client.patch(
        f"/sessions/{sid}/conclusions",
        json={"differential_diagnoses": [{"rank": 1, "condition": "STEMI"}]},
        headers=learner_headers,
    )
    assert r.status_code == 200
    body = r.json()
    assert body["session_id"] == sid
    assert body["status"] == "active"
    assert body["conclusions"]["differential_diagnoses"][0]["condition"] == "STEMI"


def test_save_conclusions_full(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """PATCH with all fields stores the complete conclusions payload."""
    sid = _start_session(client, learner_headers, published_case_id)
    r = client.patch(
        f"/sessions/{sid}/conclusions",
        json=_FULL_CONCLUSIONS,
        headers=learner_headers,
    )
    assert r.status_code == 200
    body = r.json()
    assert body["conclusions"]["final_diagnosis"] == "STEMI"
    assert body["conclusions"]["treatment_plan"]["medications"][0]["dose"] == "325mg"


def test_save_conclusions_merges_incrementally(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """Two consecutive PATCHes merge: second call adds final_diagnosis to existing data."""
    sid = _start_session(client, learner_headers, published_case_id)
    client.patch(
        f"/sessions/{sid}/conclusions",
        json={"differential_diagnoses": [{"rank": 1, "condition": "STEMI"}]},
        headers=learner_headers,
    )
    r2 = client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "STEMI"},
        headers=learner_headers,
    )
    assert r2.status_code == 200
    conclusions = r2.json()["conclusions"]
    assert conclusions["final_diagnosis"] == "STEMI"
    assert conclusions["differential_diagnoses"][0]["condition"] == "STEMI"


def test_save_conclusions_not_owner(
    client: TestClient,
    learner_headers: dict[str, str],
    educator_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """A user who does not own the session gets 403."""
    sid = _start_session(client, learner_headers, published_case_id)
    r = client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "Something"},
        headers=educator_headers,
    )
    assert r.status_code == 403


def test_save_conclusions_nonexistent_session(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    """Non-existent session_id returns 404."""
    r = client.patch(
        "/sessions/does-not-exist/conclusions",
        json={"final_diagnosis": "X"},
        headers=learner_headers,
    )
    assert r.status_code == 404


def test_save_conclusions_unauthenticated(client: TestClient) -> None:
    """Unauthenticated request returns 401."""
    r = client.patch("/sessions/some-id/conclusions", json={"final_diagnosis": "X"})
    assert r.status_code == 401


# ---------------------------------------------------------------------------
# POST /sessions/{id}/finish
# ---------------------------------------------------------------------------


def test_finish_session_success(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """AC: finish with final_diagnosis present → status becomes 'completed'."""
    sid = _start_session(client, learner_headers, published_case_id)
    client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "STEMI"},
        headers=learner_headers,
    )
    r = client.post(f"/sessions/{sid}/finish", headers=learner_headers)
    assert r.status_code == 200
    body = r.json()
    assert body["status"] == "completed"
    assert body["session_id"] == sid


def test_finish_session_blocks_further_edits(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """AC: after finishing, PATCH conclusions returns 409 Conflict."""
    sid = _start_session(client, learner_headers, published_case_id)
    client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "STEMI"},
        headers=learner_headers,
    )
    client.post(f"/sessions/{sid}/finish", headers=learner_headers)
    r = client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "Changed"},
        headers=learner_headers,
    )
    assert r.status_code == 409


def test_finish_session_blocks_double_finish(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """Calling finish twice returns 409 on the second call."""
    sid = _start_session(client, learner_headers, published_case_id)
    client.patch(
        f"/sessions/{sid}/conclusions",
        json={"final_diagnosis": "STEMI"},
        headers=learner_headers,
    )
    client.post(f"/sessions/{sid}/finish", headers=learner_headers)
    r = client.post(f"/sessions/{sid}/finish", headers=learner_headers)
    assert r.status_code == 409


def test_finish_session_missing_final_diagnosis(
    client: TestClient,
    learner_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """AC: finishing without final_diagnosis returns 400 Bad Request."""
    sid = _start_session(client, learner_headers, published_case_id)
    r = client.post(f"/sessions/{sid}/finish", headers=learner_headers)
    assert r.status_code == 400


def test_finish_session_not_owner(
    client: TestClient,
    learner_headers: dict[str, str],
    educator_headers: dict[str, str],
    published_case_id: str,
) -> None:
    """A user who does not own the session gets 403 on finish."""
    sid = _start_session(client, learner_headers, published_case_id)
    r = client.post(f"/sessions/{sid}/finish", headers=educator_headers)
    assert r.status_code == 403


def test_finish_session_nonexistent(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    """Non-existent session_id returns 404 on finish."""
    r = client.post("/sessions/does-not-exist/finish", headers=learner_headers)
    assert r.status_code == 404


def test_finish_session_unauthenticated(client: TestClient) -> None:
    """Unauthenticated request returns 401."""
    r = client.post("/sessions/some-id/finish")
    assert r.status_code == 401
