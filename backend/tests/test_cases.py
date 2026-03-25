from typing import Any

from fastapi.testclient import TestClient

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _minimal_case() -> dict[str, Any]:
    return {
        "case_id": "chest_pain_001",
        "title": "Acute chest pain",
        "language": "en",
        "difficulty": "medium",
        "specialty": "emergency_medicine",
        "tags": ["chest_pain"],
        "age": 54,
        "sex": "male",
        "persona": "Worried delivery driver.",
        "tone_presets": ["neutral", "anxious"],
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
                "must_order": ["ECG", "Troponin"],
                "optional": ["Chest X-ray"],
                "should_not_order": ["Elective stress test"],
            },
            "results": [
                {
                    "test_name": "ECG",
                    "result_type": "text_report",
                    "value": "ST elevation in II, III, aVF.",
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
            "contraindications": ["Discharge without ruling out ACS"],
            "follow_up": ["Cardiology follow-up"],
        },
        "scoring": {
            "weight_diagnosis": 0.35,
            "weight_diagnostics": 0.25,
            "weight_treatment": 0.30,
            "weight_safety": 0.10,
            "acceptable_answers": [
                {"field": "final_diagnosis", "answer": "STEMI"},
                {"field": "final_diagnosis", "answer": "ST-elevation MI"},
            ],
            "critical_safety_errors": ["Discharge with ongoing chest pain"],
        },
    }


# ---------------------------------------------------------------------------
# POST /cases
# ---------------------------------------------------------------------------


def test_create_case_success(
    client: TestClient, educator_headers: dict[str, str]
) -> None:
    r = client.post("/cases", json=_minimal_case(), headers=educator_headers)
    assert r.status_code == 201
    body = r.json()
    assert body["case_id"] == "chest_pain_001"
    assert body["status"] == "draft"
    assert body["version"] == 1
    assert "id" in body


def test_create_case_learner_forbidden(
    client: TestClient, learner_headers: dict[str, str]
) -> None:
    r = client.post("/cases", json=_minimal_case(), headers=learner_headers)
    assert r.status_code == 403


def test_create_case_unauthenticated(client: TestClient) -> None:
    r = client.post("/cases", json=_minimal_case())
    assert r.status_code == 401


def test_create_case_missing_chief_complaint(
    client: TestClient, educator_headers: dict[str, str]
) -> None:
    payload = _minimal_case()
    del payload["chief_complaint"]
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 422


def test_create_case_missing_persona(
    client: TestClient, educator_headers: dict[str, str]
) -> None:
    payload = _minimal_case()
    del payload["persona"]
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 422


def test_create_case_duplicate_case_id(
    client: TestClient, educator_headers: dict[str, str]
) -> None:
    client.post("/cases", json=_minimal_case(), headers=educator_headers)
    r = client.post("/cases", json=_minimal_case(), headers=educator_headers)
    assert r.status_code == 409


def test_create_case_invalid_language(
    client: TestClient, educator_headers: dict[str, str]
) -> None:
    payload = _minimal_case()
    payload["language"] = "fr"
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 422


def test_create_case_invalid_difficulty(
    client: TestClient, educator_headers: dict[str, str]
) -> None:
    payload = _minimal_case()
    payload["difficulty"] = "impossible"
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 422


def test_create_case_scoring_weights_not_summing_to_one(
    client: TestClient, educator_headers: dict[str, str]
) -> None:
    payload = _minimal_case()
    payload["scoring"]["weight_diagnosis"] = 0.99
    r = client.post("/cases", json=payload, headers=educator_headers)
    assert r.status_code == 422
