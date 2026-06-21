"""Integration tests for communication evaluation API (#69)."""

import asyncio
import uuid
from datetime import datetime, timezone
from typing import Any, cast

import pytest
from fastapi.testclient import TestClient
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from communication_eval.judge_schemas import JudgeCriterionOutput, compute_total_score
from dependencies import get_judge_provider
from models.db import ActionLog, ClinicalCase, User
from server import app
from services.utils.auth import hash_password

_TEST_PASSWORD = "secret123"
_COMM_EVAL_PATH = "/sessions/{session_id}/communication-evaluation"


def _minimal_case(case_id: str = "comm_eval_case_001") -> dict[str, Any]:
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
def comm_eval_case_id(client: TestClient, educator_headers: dict[str, str]) -> str:
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

    chat = client.post(
        f"/sessions/{session_id}/chat",
        json={"message": "Where does it hurt?"},
        headers=headers,
    )
    assert chat.status_code == 200

    patch = client.patch(
        f"/sessions/{session_id}/conclusions",
        json={"final_diagnosis": "STEMI"},
        headers=headers,
    )
    assert patch.status_code == 200

    finish = client.post(f"/sessions/{session_id}/finish", headers=headers)
    assert finish.status_code == 200
    return session_id


class _InvalidJsonProvider:
    async def complete(
        self,
        messages: list[dict[str, str]],
        *,
        temperature: float | None = None,
        json_mode: bool = False,
    ) -> str:
        return "not json"


def test_owner_post_communication_evaluation_after_finish(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    r = client.post(
        _COMM_EVAL_PATH.format(session_id=session_id),
        headers=learner_headers,
    )
    assert r.status_code == 200
    body = r.json()
    assert body["session_id"] == session_id
    assert body["model"] == "mock"
    assert body["prompt_version"] == "v1"
    assert body["total_score"] == 76.0
    assert len(body["criteria"]) == 5
    assert {item["criterion"] for item in body["criteria"]} == {
        "open_ended_questions",
        "empathy",
        "structured_history",
        "closing_the_loop",
        "no_leading_questions",
    }


def test_post_idempotent_returns_existing_record(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    path = _COMM_EVAL_PATH.format(session_id=session_id)
    first = client.post(path, headers=learner_headers)
    second = client.post(path, headers=learner_headers)
    assert first.status_code == 200
    assert second.status_code == 200
    assert first.json()["created_at"] == second.json()["created_at"]
    assert first.json()["total_score"] == second.json()["total_score"]


def test_owner_get_communication_evaluation(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    path = _COMM_EVAL_PATH.format(session_id=session_id)
    client.post(path, headers=learner_headers)
    r = client.get(path, headers=learner_headers)
    assert r.status_code == 200
    assert r.json()["session_id"] == session_id


def test_non_owner_post_forbidden(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    _insert_user("other_learner_comm", "learner")
    other_headers = _auth_headers(client, "other_learner_comm")
    r = client.post(
        _COMM_EVAL_PATH.format(session_id=session_id),
        headers=other_headers,
    )
    assert r.status_code == 403


def test_admin_post_any_session(
    client: TestClient,
    learner_headers: dict[str, str],
    admin_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    r = client.post(
        _COMM_EVAL_PATH.format(session_id=session_id),
        headers=admin_headers,
    )
    assert r.status_code == 200


def test_educator_get_any_session(
    client: TestClient,
    learner_headers: dict[str, str],
    educator_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    path = _COMM_EVAL_PATH.format(session_id=session_id)
    client.post(path, headers=learner_headers)
    r = client.get(path, headers=educator_headers)
    assert r.status_code == 200


def test_unfinished_session_returns_409(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    start = client.post(
        "/sessions/start",
        json={"case_id": comm_eval_case_id},
        headers=learner_headers,
    )
    session_id: str = start.json()["session_id"]
    r = client.post(
        _COMM_EVAL_PATH.format(session_id=session_id),
        headers=learner_headers,
    )
    assert r.status_code == 409


def test_missing_session_returns_404(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    r = client.post(
        _COMM_EVAL_PATH.format(session_id="nonexistent-session-id"),
        headers=learner_headers,
    )
    assert r.status_code == 404


def test_get_before_evaluation_returns_409(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    r = client.get(
        _COMM_EVAL_PATH.format(session_id=session_id),
        headers=learner_headers,
    )
    assert r.status_code == 409


def test_mock_provider_deterministic_scores(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    path = _COMM_EVAL_PATH.format(session_id=session_id)
    first = client.post(path, headers=learner_headers).json()
    second = client.post(path, headers=learner_headers).json()
    assert first["total_score"] == second["total_score"] == 76.0
    assert first["criteria"] == second["criteria"]


def test_invalid_judge_json_returns_502_and_does_not_persist(
    client: TestClient,
    learner_headers: dict[str, str],
    comm_eval_case_id: str,
) -> None:
    session_id = _start_and_finish(client, learner_headers, comm_eval_case_id)
    path = _COMM_EVAL_PATH.format(session_id=session_id)
    app.dependency_overrides[get_judge_provider] = lambda: _InvalidJsonProvider()
    try:
        r = client.post(path, headers=learner_headers)
        assert r.status_code == 502
        get_r = client.get(path, headers=learner_headers)
        assert get_r.status_code == 409
    finally:
        app.dependency_overrides.pop(get_judge_provider, None)


def test_compute_total_score() -> None:
    criteria = [
        JudgeCriterionOutput(
            criterion="open_ended_questions",
            score=4,
            rationale="ok",
            quote="q",
        ),
        JudgeCriterionOutput(
            criterion="empathy",
            score=4,
            rationale="ok",
            quote="q",
        ),
        JudgeCriterionOutput(
            criterion="structured_history",
            score=3,
            rationale="ok",
            quote="q",
        ),
        JudgeCriterionOutput(
            criterion="closing_the_loop",
            score=3,
            rationale="ok",
            quote="q",
        ),
        JudgeCriterionOutput(
            criterion="no_leading_questions",
            score=5,
            rationale="ok",
            quote="q",
        ),
    ]
    assert compute_total_score(criteria) == 76.0


def test_build_transcript_filters_non_chat_roles() -> None:
    from communication_eval.judge import build_transcript

    logs = [
        ActionLog(
            id="1",
            session_id="s1",
            role="system",
            content="TEST_ORDERED:ECG",
            created_at=datetime.now(timezone.utc),
        ),
        ActionLog(
            id="2",
            session_id="s1",
            role="user",
            content="Where does it hurt?",
            created_at=datetime.now(timezone.utc),
        ),
        ActionLog(
            id="3",
            session_id="s1",
            role="assistant",
            content="In my chest.",
            created_at=datetime.now(timezone.utc),
        ),
    ]
    transcript = build_transcript(logs)
    assert "TEST_ORDERED" not in transcript
    assert "1. Doctor: Where does it hurt?" in transcript
    assert "2. Patient: In my chest." in transcript
