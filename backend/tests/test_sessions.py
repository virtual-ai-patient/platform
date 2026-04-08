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
            "acceptable_answers": [
                {"field": "final_diagnosis", "answer": "STEMI"}
            ],
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
