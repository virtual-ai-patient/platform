"""Integration tests for GET /admin/sessions and GET /admin/sessions/{session_id}."""

import asyncio
from typing import Any, cast

from fastapi.testclient import TestClient
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from models.db import ActionLog, ClinicalCase


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _minimal_case(case_id: str = "admin_case_001") -> dict[str, Any]:
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
            "acceptable_answers": [],
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


def _seed_action_logs(session_id: str, messages: list[tuple[str, str]]) -> None:
    """Insert action log rows directly for a given session."""

    async def _run() -> None:
        session_factory = cast(
            async_sessionmaker[AsyncSession],
            database._TestSessionLocal,  # type: ignore[attr-defined]
        )
        async with session_factory() as session:
            for role, content in messages:
                session.add(
                    ActionLog(session_id=session_id, role=role, content=content)
                )
            await session.commit()

    asyncio.run(_run())


def _create_case_and_session(
    client: TestClient,
    educator_headers: dict[str, str],
    learner_headers: dict[str, str],
    case_id: str = "admin_case_001",
) -> str:
    """Create a published case and start a learner session. Returns session_id."""
    r = client.post("/cases", json=_minimal_case(case_id), headers=educator_headers)
    assert r.status_code == 201
    _publish_case(case_id)
    r = client.post(
        "/sessions/start", json={"case_id": case_id}, headers=learner_headers
    )
    assert r.status_code == 201
    return str(r.json()["session_id"])


# ---------------------------------------------------------------------------
# GET /admin/sessions
# ---------------------------------------------------------------------------


class TestListSessions:
    def test_educator_can_list_sessions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get("/admin/sessions", headers=educator_headers)
        assert r.status_code == 200
        body = r.json()
        assert body["total"] >= 1
        assert len(body["sessions"]) >= 1
        session = body["sessions"][0]
        assert "session_id" in session
        assert "student_username" in session
        assert "case_id" in session
        assert "case_title" in session
        assert "created_at" in session

    def test_admin_can_list_sessions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
        admin_headers: dict[str, str],
    ) -> None:
        _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get("/admin/sessions", headers=admin_headers)
        assert r.status_code == 200

    def test_learner_cannot_list_sessions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get("/admin/sessions", headers=learner_headers)
        assert r.status_code == 403

    def test_unauthenticated_cannot_list_sessions(self, client: TestClient) -> None:
        r = client.get("/admin/sessions")
        assert r.status_code == 401

    def test_pagination(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        _create_case_and_session(
            client, educator_headers, learner_headers, "admin_case_p1"
        )
        _create_case_and_session(
            client, educator_headers, learner_headers, "admin_case_p2"
        )
        r = client.get("/admin/sessions?page=1&page_size=1", headers=educator_headers)
        assert r.status_code == 200
        body = r.json()
        assert body["total"] == 2
        assert len(body["sessions"]) == 1
        assert body["page"] == 1
        assert body["page_size"] == 1

    def test_filter_by_student(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get("/admin/sessions?student=learner", headers=educator_headers)
        assert r.status_code == 200
        body = r.json()
        assert all(s["student_username"] == "learner" for s in body["sessions"])

    def test_filter_by_unknown_student_returns_empty(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get("/admin/sessions?student=nobody", headers=educator_headers)
        assert r.status_code == 200
        assert r.json()["total"] == 0

    def test_filter_by_case_id(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        _create_case_and_session(
            client, educator_headers, learner_headers, "admin_case_filter"
        )
        r = client.get(
            "/admin/sessions?case_id=admin_case_filter", headers=educator_headers
        )
        assert r.status_code == 200
        body = r.json()
        assert body["total"] >= 1
        assert all(s["case_id"] == "admin_case_filter" for s in body["sessions"])

    def test_empty_list_when_no_sessions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
    ) -> None:
        r = client.get("/admin/sessions", headers=educator_headers)
        assert r.status_code == 200
        assert r.json()["total"] == 0


# ---------------------------------------------------------------------------
# GET /admin/sessions/{session_id}
# ---------------------------------------------------------------------------


class TestGetSessionDetail:
    def test_returns_session_detail(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        session_id = _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get(f"/admin/sessions/{session_id}", headers=educator_headers)
        assert r.status_code == 200
        body = r.json()
        assert body["session_id"] == session_id
        assert body["student_username"] == "learner"
        assert body["case_id"] == "admin_case_001"
        assert body["case_title"] == "Acute chest pain"
        assert "created_at" in body
        assert "action_log" in body

    def test_action_log_contains_messages(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        session_id = _create_case_and_session(client, educator_headers, learner_headers)
        _seed_action_logs(
            session_id,
            [("user", "Where does it hurt?"), ("assistant", "In my chest.")],
        )
        r = client.get(f"/admin/sessions/{session_id}", headers=educator_headers)
        assert r.status_code == 200
        log = r.json()["action_log"]
        assert len(log) == 2
        assert log[0]["role"] == "user"
        assert log[0]["content"] == "Where does it hurt?"
        assert log[1]["role"] == "assistant"
        assert "created_at" in log[0]

    def test_action_log_ordered_by_timestamp(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        session_id = _create_case_and_session(client, educator_headers, learner_headers)
        _seed_action_logs(
            session_id,
            [("user", "first"), ("assistant", "second"), ("user", "third")],
        )
        r = client.get(f"/admin/sessions/{session_id}", headers=educator_headers)
        log = r.json()["action_log"]
        timestamps = [e["created_at"] for e in log]
        assert timestamps == sorted(timestamps)

    def test_404_for_unknown_session(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
    ) -> None:
        r = client.get("/admin/sessions/nonexistent-session", headers=educator_headers)
        assert r.status_code == 404

    def test_learner_cannot_access_detail(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        session_id = _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get(f"/admin/sessions/{session_id}", headers=learner_headers)
        assert r.status_code == 403

    def test_unauthenticated_cannot_access_detail(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        session_id = _create_case_and_session(client, educator_headers, learner_headers)
        r = client.get(f"/admin/sessions/{session_id}")
        assert r.status_code == 401
