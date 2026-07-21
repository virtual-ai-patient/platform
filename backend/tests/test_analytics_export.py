"""Integration tests for GET /analytics/export/sessions and /analytics/export/actions (#93)."""

import asyncio
import csv
import io
import json
import os
from typing import Any, cast

os.environ.setdefault("USE_MOCK_AI", "true")

from fastapi.testclient import TestClient
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from analytics.repository import AnalyticsRepository
from models.db import ClinicalCase


def _minimal_case(case_id: str = "analytics_case_001") -> dict[str, Any]:
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


def _create_case(
    client: TestClient, educator_headers: dict[str, str], case_id: str
) -> str:
    r = client.post("/cases", json=_minimal_case(case_id), headers=educator_headers)
    assert r.status_code == 201
    _publish_case(case_id)
    return case_id


def _start_chat_and_finish(
    client: TestClient, headers: dict[str, str], case_id: str
) -> str:
    """Start a session, exchange one chat turn, order a test, submit conclusions,
    and finish (triggering auto-scoring). Returns the session_id."""
    start = client.post("/sessions/start", json={"case_id": case_id}, headers=headers)
    assert start.status_code == 201
    session_id: str = start.json()["session_id"]

    chat = client.post(
        f"/sessions/{session_id}/chat",
        json={"message": "Where does it hurt?"},
        headers=headers,
    )
    assert chat.status_code == 200

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


# ---------------------------------------------------------------------------
# GET /analytics/export/sessions
# ---------------------------------------------------------------------------


class TestExportSessions:
    def test_learner_can_export_own_sessions_csv(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_sessions_1")
        session_id = _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get("/analytics/export/sessions", headers=learner_headers)
        assert r.status_code == 200
        assert r.headers["content-type"].startswith("text/csv")

        reader = csv.reader(io.StringIO(r.text))
        rows = list(reader)
        header, data_rows = rows[0], rows[1:]
        assert "session_id" in header
        assert any(row[header.index("session_id")] == session_id for row in data_rows)

    def test_learner_scope_all_forbidden(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_sessions_2")
        _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get("/analytics/export/sessions?scope=all", headers=learner_headers)
        assert r.status_code == 403

    def test_educator_scope_all_sees_other_learners(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_sessions_3")
        session_id = _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get("/analytics/export/sessions?scope=all", headers=educator_headers)
        assert r.status_code == 200
        reader = csv.reader(io.StringIO(r.text))
        rows = list(reader)
        header, data_rows = rows[0], rows[1:]
        assert any(row[header.index("session_id")] == session_id for row in data_rows)

    def test_json_format_includes_scores_and_findings(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_sessions_4")
        session_id = _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get(
            "/analytics/export/sessions?format=json", headers=learner_headers
        )
        assert r.status_code == 200
        assert r.headers["content-type"].startswith("application/json")
        rows = r.json()
        row = next(row for row in rows if row["session_id"] == session_id)
        assert row["total_score"] is not None
        assert row["case_version"] == 1
        assert isinstance(row["findings_by_severity"], dict)

    def test_determinism_same_window_same_bytes(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_sessions_5")
        _start_chat_and_finish(client, learner_headers, case_id)

        r1 = client.get("/analytics/export/sessions", headers=learner_headers)
        r2 = client.get("/analytics/export/sessions", headers=learner_headers)
        assert r1.content == r2.content

    def test_empty_window_returns_header_only(
        self,
        client: TestClient,
        learner_headers: dict[str, str],
    ) -> None:
        r = client.get(
            "/analytics/export/sessions?since=2099-01-01T00:00:00Z",
            headers=learner_headers,
        )
        assert r.status_code == 200
        reader = csv.reader(io.StringIO(r.text))
        rows = list(reader)
        assert len(rows) == 1  # header only

    def test_unauthenticated_rejected(self, client: TestClient) -> None:
        r = client.get("/analytics/export/sessions")
        assert r.status_code == 401


# ---------------------------------------------------------------------------
# GET /analytics/export/actions
# ---------------------------------------------------------------------------


class TestExportActions:
    def test_owner_can_export_own_session_actions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_actions_1")
        session_id = _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get(
            f"/analytics/export/actions?session_id={session_id}",
            headers=learner_headers,
        )
        assert r.status_code == 200
        reader = csv.reader(io.StringIO(r.text))
        rows = list(reader)
        header, data_rows = rows[0], rows[1:]
        assert "action_type" in header
        action_types = {row[header.index("action_type")] for row in data_rows}
        assert "chat_user" in action_types
        assert "chat_assistant" in action_types
        assert "order_test" in action_types

    def test_other_learner_cannot_export_session_actions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_actions_2")
        session_id = _start_chat_and_finish(client, learner_headers, case_id)

        _insert_second_learner(client)
        other_headers = _login(client, "learner_two")

        r = client.get(
            f"/analytics/export/actions?session_id={session_id}",
            headers=other_headers,
        )
        assert r.status_code == 403

    def test_educator_can_export_any_session_actions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_actions_3")
        session_id = _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get(
            f"/analytics/export/actions?session_id={session_id}",
            headers=educator_headers,
        )
        assert r.status_code == 200

    def test_learner_cannot_bulk_export_actions(
        self,
        client: TestClient,
        learner_headers: dict[str, str],
    ) -> None:
        r = client.get("/analytics/export/actions", headers=learner_headers)
        assert r.status_code == 403

    def test_educator_bulk_export_actions(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_actions_4")
        _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get("/analytics/export/actions", headers=educator_headers)
        assert r.status_code == 200
        reader = csv.reader(io.StringIO(r.text))
        rows = list(reader)
        assert len(rows) > 1  # header + at least one row

    def test_session_not_found(
        self,
        client: TestClient,
        learner_headers: dict[str, str],
    ) -> None:
        r = client.get(
            "/analytics/export/actions?session_id=nonexistent",
            headers=learner_headers,
        )
        assert r.status_code == 404

    def test_turn_index_is_chronological(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        case_id = _create_case(client, educator_headers, "analytics_actions_5")
        session_id = _start_chat_and_finish(client, learner_headers, case_id)

        r = client.get(
            f"/analytics/export/actions?session_id={session_id}&format=json",
            headers=learner_headers,
        )
        rows = r.json()
        turn_indices = [row["turn_index"] for row in rows]
        assert turn_indices == sorted(turn_indices)
        assert turn_indices[0] == 0

    def test_spreadsheet_injection_neutralised_end_to_end(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        """payload_json cells are always JSON objects (leading '{'), which
        spreadsheet apps never treat as a formula trigger — so the injection
        risk is on scalar cells (e.g. learner_id) instead. Seed a case_id
        that itself starts with a formula-trigger character via a raw DB
        write to CaseSession's joined ClinicalCase, which is out of scope
        here; instead this covers the payload path end-to-end and the unit
        test below covers the neutralisation guarantee directly."""
        case_id = _create_case(client, educator_headers, "analytics_actions_6")
        start = client.post(
            "/sessions/start", json={"case_id": case_id}, headers=learner_headers
        )
        session_id = start.json()["session_id"]

        chat = client.post(
            f"/sessions/{session_id}/chat",
            json={"message": "=cmd|'/c calc'!A0"},
            headers=learner_headers,
        )
        assert chat.status_code == 200

        r = client.get(
            f"/analytics/export/actions?session_id={session_id}",
            headers=learner_headers,
        )
        reader = csv.reader(io.StringIO(r.text))
        rows = list(reader)
        header = rows[0]
        payload_col = header.index("payload_json")
        matching = [row for row in rows[1:] if "cmd" in row[payload_col]]
        assert matching
        payload = json.loads(matching[0][payload_col])
        assert payload["text"].startswith("=cmd")


class TestSanitizeCell:
    """Unit tests for the RFC-4180 + spreadsheet-injection CSV cell guard."""

    def test_leading_equals_is_neutralised(self) -> None:
        from analytics.export import _sanitize_cell

        assert _sanitize_cell("=cmd|'/c calc'!A0") == "'=cmd|'/c calc'!A0"

    def test_leading_plus_minus_at_are_neutralised(self) -> None:
        from analytics.export import _sanitize_cell

        assert _sanitize_cell("+1").startswith("'")
        assert _sanitize_cell("-1").startswith("'")
        assert _sanitize_cell("@SUM(A1)").startswith("'")

    def test_benign_values_are_untouched(self) -> None:
        from analytics.export import _sanitize_cell

        assert _sanitize_cell("chat_user") == "chat_user"
        assert _sanitize_cell(None) == ""

    def test_dict_payload_serialised_as_json(self) -> None:
        from analytics.export import _sanitize_cell

        assert _sanitize_cell({"text": "=cmd"}) == '{"text": "=cmd"}'


def _insert_second_learner(client: TestClient) -> None:
    signup = client.post(
        "/auth/signup",
        json={
            "username": "learner_two",
            "email": "learner_two@example.com",
            "password": "secret123",
        },
    )
    assert signup.status_code in (200, 201)


def _login(client: TestClient, username: str) -> dict[str, str]:
    tokens: dict[str, str] = client.post(
        "/auth/login",
        data={"username": username, "password": "secret123"},
    ).json()
    return {"Authorization": f"Bearer {tokens['access_token']}"}


# ---------------------------------------------------------------------------
# Repository-level pagination correctness (streaming guarantee)
# ---------------------------------------------------------------------------


class TestAnalyticsRepositoryPagination:
    def test_iter_action_rows_paginates_without_gaps_or_duplicates(
        self,
        client: TestClient,
        educator_headers: dict[str, str],
        learner_headers: dict[str, str],
    ) -> None:
        """Seed many action-log rows and confirm a small page_size still yields
        every row exactly once, in order — the guarantee the export streaming
        relies on to avoid materialising the full result set at once."""
        case_id = _create_case(client, educator_headers, "analytics_pagination_1")
        start = client.post(
            "/sessions/start", json={"case_id": case_id}, headers=learner_headers
        )
        session_id = start.json()["session_id"]

        for i in range(25):
            chat = client.post(
                f"/sessions/{session_id}/chat",
                json={"message": f"question {i}"},
                headers=learner_headers,
            )
            assert chat.status_code == 200

        async def _run() -> list[int]:
            session_factory = cast(
                async_sessionmaker[AsyncSession],
                database._TestSessionLocal,  # type: ignore[attr-defined]
            )
            async with session_factory() as session:
                repo = AnalyticsRepository(session)
                turn_indices = []
                async for row in repo.iter_action_rows(
                    session_id=session_id,
                    learner_id=None,
                    since=None,
                    until=None,
                    page_size=3,
                ):
                    turn_indices.append(row.turn_index)
                return turn_indices

        turn_indices = asyncio.run(_run())
        assert turn_indices == list(range(len(turn_indices)))
        assert len(turn_indices) == 50  # 25 user + 25 assistant turns
