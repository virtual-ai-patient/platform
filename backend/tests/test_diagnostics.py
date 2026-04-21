"""Integration tests for diagnostics endpoints (issue #41).

Endpoints under test:
  GET  /sessions/{session_id}/available-tests
  POST /sessions/{session_id}/order-test

Acceptance criteria:
  AC1 — API returns correct diagnostic data (value, units, reference range) from the case.
  AC2 — Response time is within QA-PERF-02 limit (≤ 2 s).
  AC3 — Ordered tests are stored in history; re-ordering the same test produces no duplicate log.
  AC4 — Unknown tests return a standard Normal result.
"""

import asyncio
import time
from typing import Any, cast

import pytest
from fastapi.testclient import TestClient
from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker

import models.database as database
from models.db import ActionLog, ClinicalCase


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _case_with_diagnostics(case_id: str = "diag_case_001") -> dict[str, Any]:
    return {
        "case_id": case_id,
        "title": "Acute chest pain — diagnostics",
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
            "catalog_hints": ["ECG", "Troponin"],
            "expected": {
                "must_order": ["ECG", "Troponin"],
                "optional": ["Chest X-ray"],
                "should_not_order": ["Elective stress test"],
            },
            "results": [
                {
                    "test_name": "ECG",
                    "result_type": "text_report",
                    "value": "ST elevation in inferior leads.",
                    "unit": None,
                    "reference_range": None,
                },
                {
                    "test_name": "Troponin",
                    "result_type": "lab_value",
                    "value": "2.4",
                    "unit": "ng/mL",
                    "reference_range": "0.00-0.04",
                },
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
            return [{"role": r.role, "content": r.content} for r in rows]

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
    """Published case + active learner session. Returns {session_id, case_id}."""
    case_id = "diag_pub_001"
    r = client.post(
        "/cases", json=_case_with_diagnostics(case_id), headers=educator_headers
    )
    assert r.status_code == 201
    _publish_case(case_id)
    session_id = _start_session(client, case_id, learner_headers)
    return {"session_id": session_id, "case_id": case_id}


# ---------------------------------------------------------------------------
# GET /sessions/{session_id}/available-tests
# ---------------------------------------------------------------------------


def test_available_tests_returns_200(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    r = client.get(
        f"/sessions/{active_session['session_id']}/available-tests",
        headers=learner_headers,
    )
    assert r.status_code == 200


def test_available_tests_response_structure(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    r = client.get(
        f"/sessions/{active_session['session_id']}/available-tests",
        headers=learner_headers,
    )
    body = r.json()
    assert "tests" in body
    assert isinstance(body["tests"], list)
    for item in body["tests"]:
        assert "test_name" in item
        assert "category" in item


def test_available_tests_includes_all_categories(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    r = client.get(
        f"/sessions/{active_session['session_id']}/available-tests",
        headers=learner_headers,
    )
    tests = r.json()["tests"]
    names_by_category: dict[str, list[str]] = {}
    for t in tests:
        names_by_category.setdefault(t["category"], []).append(t["test_name"])

    assert "ECG" in names_by_category.get("must_order", [])
    assert "Troponin" in names_by_category.get("must_order", [])
    assert "Chest X-ray" in names_by_category.get("optional", [])
    assert "Elective stress test" in names_by_category.get("should_not_order", [])


def test_available_tests_unauthenticated_returns_401(
    client: TestClient,
    active_session: dict[str, str],
) -> None:
    r = client.get(f"/sessions/{active_session['session_id']}/available-tests")
    assert r.status_code == 401


def test_available_tests_nonexistent_session_returns_404(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    r = client.get(
        "/sessions/00000000-0000-0000-0000-000000000000/available-tests",
        headers=learner_headers,
    )
    assert r.status_code == 404


def test_available_tests_wrong_user_returns_403(
    client: TestClient,
    educator_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    r = client.get(
        f"/sessions/{active_session['session_id']}/available-tests",
        headers=educator_headers,
    )
    assert r.status_code == 403


# ---------------------------------------------------------------------------
# POST /sessions/{session_id}/order-test — AC1: correct data
# ---------------------------------------------------------------------------


def test_order_test_text_report_returns_correct_value(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC1 — Text-report test returns the expected value from the case."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/order-test",
        json={"test_id": "ECG"},
        headers=learner_headers,
    )
    assert r.status_code == 200
    body = r.json()
    assert body["test_name"] == "ECG"
    assert body["result_type"] == "text_report"
    assert body["value"] == "ST elevation in inferior leads."
    assert body["is_normal_default"] is False


def test_order_test_lab_value_returns_unit_and_reference_range(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC1 — Lab-value test returns value, unit, and reference_range."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/order-test",
        json={"test_id": "Troponin"},
        headers=learner_headers,
    )
    assert r.status_code == 200
    body = r.json()
    assert body["test_name"] == "Troponin"
    assert body["result_type"] == "lab_value"
    assert body["value"] == "2.4"
    assert body["unit"] == "ng/mL"
    assert body["reference_range"] == "0.00-0.04"
    assert body["is_normal_default"] is False


def test_order_test_undefined_test_returns_normal_default(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC4 — Ordering a test not in the case returns a Normal default."""
    r = client.post(
        f"/sessions/{active_session['session_id']}/order-test",
        json={"test_id": "Lumbar Puncture"},
        headers=learner_headers,
    )
    assert r.status_code == 200
    body = r.json()
    assert body["test_name"] == "Lumbar Puncture"
    assert body["is_normal_default"] is True
    assert isinstance(body["value"], str)
    assert len(body["value"]) > 0


# ---------------------------------------------------------------------------
# POST /sessions/{session_id}/order-test — AC2: response time ≤ 2 s
# ---------------------------------------------------------------------------


def test_order_test_latency_under_2s(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC2 — Order-test response time is within the QA-PERF-02 limit (≤ 2 s)."""
    start = time.monotonic()
    r = client.post(
        f"/sessions/{active_session['session_id']}/order-test",
        json={"test_id": "ECG"},
        headers=learner_headers,
    )
    elapsed_ms = (time.monotonic() - start) * 1000
    assert r.status_code == 200
    assert elapsed_ms < 2000, f"order-test took {elapsed_ms:.1f} ms, expected ≤ 2000 ms"


# ---------------------------------------------------------------------------
# POST /sessions/{session_id}/order-test — AC3: dedup logging
# ---------------------------------------------------------------------------


def test_order_test_logs_test_ordered_event(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC3 — First order creates exactly one TEST_ORDERED log entry."""
    session_id = active_session["session_id"]
    client.post(
        f"/sessions/{session_id}/order-test",
        json={"test_id": "ECG"},
        headers=learner_headers,
    )
    logs = _get_action_logs(session_id)
    system_logs = [log for log in logs if log["role"] == "system"]
    assert len(system_logs) == 1
    assert system_logs[0]["content"] == "TEST_ORDERED:ECG"


def test_order_test_reorder_does_not_duplicate_log(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC3 — Re-ordering the same test produces no duplicate log entry."""
    session_id = active_session["session_id"]
    for _ in range(3):
        r = client.post(
            f"/sessions/{session_id}/order-test",
            json={"test_id": "ECG"},
            headers=learner_headers,
        )
        assert r.status_code == 200

    logs = _get_action_logs(session_id)
    ecg_logs = [log for log in logs if log["content"] == "TEST_ORDERED:ECG"]
    assert len(ecg_logs) == 1


def test_order_test_reorder_returns_same_result(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """AC3 — Re-ordering the same test returns the same result."""
    session_id = active_session["session_id"]
    r1 = client.post(
        f"/sessions/{session_id}/order-test",
        json={"test_id": "Troponin"},
        headers=learner_headers,
    )
    r2 = client.post(
        f"/sessions/{session_id}/order-test",
        json={"test_id": "Troponin"},
        headers=learner_headers,
    )
    assert r1.json() == r2.json()


def test_order_test_different_tests_each_get_own_log(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    """Each distinct test gets its own log entry."""
    session_id = active_session["session_id"]
    client.post(
        f"/sessions/{session_id}/order-test",
        json={"test_id": "ECG"},
        headers=learner_headers,
    )
    client.post(
        f"/sessions/{session_id}/order-test",
        json={"test_id": "Troponin"},
        headers=learner_headers,
    )

    logs = _get_action_logs(session_id)
    system_logs = [log for log in logs if log["role"] == "system"]
    contents = {log["content"] for log in system_logs}
    assert "TEST_ORDERED:ECG" in contents
    assert "TEST_ORDERED:Troponin" in contents
    assert len(system_logs) == 2


# ---------------------------------------------------------------------------
# POST /sessions/{session_id}/order-test — auth & ownership
# ---------------------------------------------------------------------------


def test_order_test_unauthenticated_returns_401(
    client: TestClient,
    active_session: dict[str, str],
) -> None:
    r = client.post(
        f"/sessions/{active_session['session_id']}/order-test",
        json={"test_id": "ECG"},
    )
    assert r.status_code == 401


def test_order_test_nonexistent_session_returns_404(
    client: TestClient,
    learner_headers: dict[str, str],
) -> None:
    r = client.post(
        "/sessions/00000000-0000-0000-0000-000000000000/order-test",
        json={"test_id": "ECG"},
        headers=learner_headers,
    )
    assert r.status_code == 404


def test_order_test_wrong_user_returns_403(
    client: TestClient,
    educator_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    r = client.post(
        f"/sessions/{active_session['session_id']}/order-test",
        json={"test_id": "ECG"},
        headers=educator_headers,
    )
    assert r.status_code == 403


def test_order_test_missing_test_id_returns_422(
    client: TestClient,
    learner_headers: dict[str, str],
    active_session: dict[str, str],
) -> None:
    r = client.post(
        f"/sessions/{active_session['session_id']}/order-test",
        json={},
        headers=learner_headers,
    )
    assert r.status_code == 422
