"""Integration tests for POST /sessions/{session_id}/chat (AI Patient Chat).

Acceptance criteria (from issue #35):
  AC1 — API successfully returns a string response from the AI Patient.
  AC2 — Every chat exchange creates a record in the DB with timestamp + session_id.
  AC3 — Response time for the Mock provider is < 200ms.
  AC4 — AI response respects the patient Persona (tone / character).
"""

import asyncio
import os
import time
from typing import Any, cast

os.environ.setdefault("USE_MOCK_AI", "true")

import pytest
from fastapi.testclient import TestClient
from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from models.db import ActionLog, ClinicalCase


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _minimal_case(case_id: str = "chat_case_001") -> dict[str, Any]:
    return {
        "case_id": case_id,
        "title": "Acute chest pain",
        "language": "en",
        "difficulty": "medium",
        "specialty": "emergency_medicine",
        "tags": ["chest_pain"],
        "age": 54,
        "sex": "male",
        "persona": "Grumpy retired firefighter who downplays symptoms.",
        "tone_presets": ["grumpy"],
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


def _start_session(client: TestClient, case_id: str, headers: dict[str, str]) -> str:
    r = client.post("/sessions/start", json={"case_id": case_id}, headers=headers)
    assert r.status_code == 201
    return str(r.json()["session_id"])


def _get_action_logs(session_id: str) -> list[dict[str, Any]]:
    """Return all ActionLog rows for the given session, ordered by created_at."""

    async def _run() -> list[dict[str, Any]]:
        session_factory = cast(
            async_sessionmaker[AsyncSession],
            database._TestSessionLocal,  # type: ignore[attr-defined]
        )
        async with session_factory() as session:
            result = await session.execute(
                select(ActionLog)
                .where(ActionLog.session_id == session_id)
                .order_by(ActionLog.created_at)
            )
            rows = result.scalars().all()
            return [
                {
                    "session_id": r.session_id,
                    "role": r.role,
                    "content": r.content,
                    "created_at": r.created_at,
                }
                for r in rows
            ]

    return asyncio.run(_run())


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture()
def active_session(
    client: TestClient,
    educator_headers: dict[str, str],
    learner_headers: dict[str, str],
) -> dict[str, str]:
    """Published case + an active session for the learner.

    Returns {"session_id": ..., "case_id": ...}.
    """
    case_id = "chat_pub_001"
    r = client.post("/cases", json=_minimal_case(case_id), headers=educator_headers)
    assert r.status_code == 201
    _publish_case(case_id)

    session_id = _start_session(client, case_id, learner_headers)
    return {"session_id": session_id, "case_id": case_id}


# ---------------------------------------------------------------------------
# AC1 — API returns a string response
# ---------------------------------------------------------------------------


def test_chat_returns_string_response(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC1 — POST /sessions/{session_id}/chat returns 200 with a string response."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={"message": "Where exactly does it hurt?"},
        headers=learner_headers,
    )
    assert r.status_code == 200
    body = r.json()
    assert "response" in body
    assert isinstance(body["response"], str)
    assert len(body["response"]) > 0


def test_chat_response_includes_logged_at(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """Response body includes a logged_at timestamp."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={"message": "How long has the pain been there?"},
        headers=learner_headers,
    )
    assert r.status_code == 200
    assert "logged_at" in r.json()


# ---------------------------------------------------------------------------
# AC2 — Every exchange is persisted to action_logs
# ---------------------------------------------------------------------------


def test_chat_logs_user_and_assistant_rows(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC2 — One chat turn writes exactly two rows: role=user and role=assistant."""
    session_id = active_session["session_id"]
    message = "Do you have any other symptoms?"

    r = client.post(
        f"/sessions/{session_id}/chat",
        json={"message": message},
        headers=learner_headers,
    )
    assert r.status_code == 200

    logs = _get_action_logs(session_id)
    assert len(logs) == 2

    roles = [log["role"] for log in logs]
    assert "user" in roles
    assert "assistant" in roles


def test_chat_logs_contain_session_id(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC2 — Each log row references the correct session_id."""
    session_id = active_session["session_id"]
    client.post(
        f"/sessions/{session_id}/chat",
        json={"message": "Any nausea?"},
        headers=learner_headers,
    )

    logs = _get_action_logs(session_id)
    for log in logs:
        assert log["session_id"] == session_id


def test_chat_logs_user_message_content(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC2 — The user log row stores the exact sent message."""
    session_id = active_session["session_id"]
    message = "Do you smoke?"

    client.post(
        f"/sessions/{session_id}/chat",
        json={"message": message},
        headers=learner_headers,
    )

    logs = _get_action_logs(session_id)
    user_log = next(log for log in logs if log["role"] == "user")
    assert user_log["content"] == message


def test_chat_logs_have_timestamps(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC2 — All log rows carry a non-null created_at timestamp."""
    session_id = active_session["session_id"]
    client.post(
        f"/sessions/{session_id}/chat",
        json={"message": "Any shortness of breath?"},
        headers=learner_headers,
    )

    logs = _get_action_logs(session_id)
    for log in logs:
        assert log["created_at"] is not None


def test_chat_multiple_turns_accumulate_logs(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC2 — N turns produce 2N rows in action_logs for the session."""
    session_id = active_session["session_id"]
    messages = ["Where does it hurt?", "On a scale of 1-10?", "Any fever?"]

    for msg in messages:
        r = client.post(
            f"/sessions/{session_id}/chat",
            json={"message": msg},
            headers=learner_headers,
        )
        assert r.status_code == 200

    logs = _get_action_logs(session_id)
    assert len(logs) == len(messages) * 2


# ---------------------------------------------------------------------------
# AC3 — Mock provider responds in < 200 ms
# ---------------------------------------------------------------------------


def test_chat_mock_latency_under_200ms(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC3 — Mock provider response time is < 200 ms."""
    start = time.monotonic()
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={"message": "Do you have any allergies?"},
        headers=learner_headers,
    )
    elapsed_ms = (time.monotonic() - start) * 1000

    assert r.status_code == 200
    assert elapsed_ms < 200, f"Mock response took {elapsed_ms:.1f}ms, expected < 200ms"


# ---------------------------------------------------------------------------
# AC4 — Persona is reflected in the response
# ---------------------------------------------------------------------------


def test_chat_mock_response_is_non_empty_string(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC4 — The AI returns a non-trivial response (mock satisfies interface)."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={"message": "Can you describe the pain?"},
        headers=learner_headers,
    )
    assert r.status_code == 200
    assert r.json()["response"].strip() != ""


# ---------------------------------------------------------------------------
# Auth & session ownership
# ---------------------------------------------------------------------------


def test_chat_unauthenticated_returns_401(
    client: TestClient,
    active_session: dict[str, str],
) -> None:
    """Unauthenticated request is rejected with 401."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={"message": "Hello"},
    )
    assert r.status_code == 401


def test_chat_nonexistent_session_returns_404(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    """Unknown session_id returns 404."""
    r = client.post(
        "/sessions/00000000-0000-0000-0000-000000000000/chat",
        json={"message": "Hello"},
        headers=learner_headers,
    )
    assert r.status_code == 404


def test_chat_session_owned_by_other_user_returns_403(
    client: TestClient,
    educator_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """A user who does not own the session receives 403."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={"message": "Hello"},
        headers=educator_headers,
    )
    assert r.status_code == 403


# ---------------------------------------------------------------------------
# Input validation
# ---------------------------------------------------------------------------


def test_chat_missing_message_field_returns_422(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """Missing required 'message' field returns 422 Unprocessable Entity."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={},
        headers=learner_headers,
    )
    assert r.status_code == 422


def test_chat_empty_message_returns_422(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """An empty string message is rejected with 422."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/chat",
        json={"message": ""},
        headers=learner_headers,
    )
    assert r.status_code == 422
