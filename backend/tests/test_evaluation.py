"""Integration tests for GET /sessions/{id}/scores and /debrief (#63)."""

import asyncio
import uuid
from typing import Any, cast

import pytest
from fastapi.testclient import TestClient
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from models.db import ClinicalCase, User
from services.utils.auth import hash_password

_TEST_PASSWORD = "secret123"


def _minimal_case(case_id: str = "eval_case_001") -> dict[str, Any]:
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


def _insert_user(username: str, role: str) -> None:
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


def _auth_headers(client: TestClient, username: str) -> dict[str, str]:
    tokens: dict[str, str] = client.post(
        "/auth/login",
        data={"username": username, "password": _TEST_PASSWORD},
    ).json()
    return {"Authorization": f"Bearer {tokens['access_token']}"}


@pytest.fixture()
def eval_case_id(client: TestClient, educator_headers: dict[str, str]) -> str:
    payload = _minimal_case()
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 201
    case_id: str = r.json()["case_id"]
    _publish_case(case_id)
    return case_id


def _start_and_finish(
    client: TestClient,
    headers: dict[str, str],
    case_id: str,
) -> str:
    start = client.post("/sessions/start", json={"case_id": case_id}, headers=headers)
    assert start.status_code == 201
    session_id: str = start.json()["session_id"]

    order = client.post(
        f"/sessions/{session_id}/order-test",
        json={"test_id": "ECG"},
        headers=headers,
    )
    assert order.status_code == 200

    patch = client.patch(
        f"/sessions/{session_id}/conclusions",
        json={
            "final_diagnosis": "STEMI",
            "treatment_plan": {
                "medications": [{"name": "Activate cath lab", "dose": "", "route": ""}],
                "non_pharmacological": ["Immediate ECG"],
                "referrals": [],
                "follow_up": [],
            },
        },
        headers=headers,
    )
    assert patch.status_code == 200

    finish = client.post(f"/sessions/{session_id}/finish", headers=headers)
    assert finish.status_code == 200
    return session_id


def test_owner_get_scores_after_finish(
    client: TestClient,
    learner_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, eval_case_id)
    r = client.get(f"/sessions/{session_id}/scores", headers=learner_headers)
    assert r.status_code == 200
    body = r.json()
    assert body["session_id"] == session_id
    assert "total_score" in body
    assert body["score_diagnosis"] == 100.0


def test_owner_get_debrief_after_finish(
    client: TestClient,
    learner_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, eval_case_id)
    r = client.get(f"/sessions/{session_id}/debrief", headers=learner_headers)
    assert r.status_code == 200
    body = r.json()
    assert body["session_id"] == session_id
    assert "findings" in body
    assert "reference_solution" in body
    assert body["conclusions"]["final_diagnosis"] == "STEMI"


def test_non_owner_get_scores_forbidden(
    client: TestClient,
    learner_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, eval_case_id)
    _insert_user("other_learner", "learner")
    other_headers = _auth_headers(client, "other_learner")
    r = client.get(f"/sessions/{session_id}/scores", headers=other_headers)
    assert r.status_code == 403


def test_admin_get_scores_any_session(
    client: TestClient,
    learner_headers: dict[str, str],
    admin_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, eval_case_id)
    r = client.get(f"/sessions/{session_id}/scores", headers=admin_headers)
    assert r.status_code == 200


def test_educator_get_debrief_any_session(
    client: TestClient,
    learner_headers: dict[str, str],
    educator_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, eval_case_id)
    r = client.get(f"/sessions/{session_id}/debrief", headers=educator_headers)
    assert r.status_code == 200


def test_unfinished_session_returns_409(
    client: TestClient,
    learner_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    start = client.post(
        "/sessions/start", json={"case_id": eval_case_id}, headers=learner_headers
    )
    session_id: str = start.json()["session_id"]
    r = client.get(f"/sessions/{session_id}/scores", headers=learner_headers)
    assert r.status_code == 409


def test_missing_session_returns_404(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    r = client.get(
        "/sessions/nonexistent-session-id/scores",
        headers=learner_headers,
    )
    assert r.status_code == 404


def test_score_idempotent_on_repeated_reads(
    client: TestClient,
    learner_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, eval_case_id)
    first = client.get(f"/sessions/{session_id}/scores", headers=learner_headers)
    second = client.get(f"/sessions/{session_id}/scores", headers=learner_headers)
    assert first.status_code == 200
    assert second.status_code == 200
    assert first.json()["total_score"] == second.json()["total_score"]
    assert first.json()["scored_at"] == second.json()["scored_at"]


def test_weighted_total_within_tolerance(
    client: TestClient,
    learner_headers: dict[str, str],
    eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, eval_case_id)
    body = client.get(f"/sessions/{session_id}/scores", headers=learner_headers).json()
    weighted = (
        body["score_diagnosis"] * 0.35
        + body["score_diagnostics"] * 0.25
        + body["score_treatment"] * 0.30
        + body["score_safety"] * 0.10
    )
    assert abs(body["total_score"] - round(weighted, 1)) <= 0.1
