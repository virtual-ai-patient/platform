"""Unit tests for rules-based evaluation scorer."""

from evaluation.scorer import compute_score, normalize_text, text_matches


def _snapshot() -> dict[str, object]:
    return {
        "case_id": "CASE-001",
        "version": 2,
        "final_diagnosis": "STEMI",
        "investigations": {
            "expected": {
                "must_order": ["ECG", "Troponin"],
                "optional": [],
                "should_not_order": ["D-dimer"],
            }
        },
        "management": {
            "diagnostic_plan": ["Immediate ECG"],
            "treatment_plan": ["Activate cath lab"],
            "contraindications": [],
        },
        "scoring": {
            "weight_diagnosis": 0.4,
            "weight_diagnostics": 0.3,
            "weight_treatment": 0.2,
            "weight_safety": 0.1,
            "acceptable_answers": [{"field": "final_diagnosis", "answer": "STEMI"}],
            "critical_safety_errors": [],
        },
    }


def test_normalize_text_collapses_whitespace() -> None:
    assert normalize_text("  STEMI  ") == "stemi"


def test_text_matches_substring_bidirectional() -> None:
    assert text_matches("Acute STEMI anterior wall", "STEMI")
    assert text_matches("STEMI", "Acute STEMI")


def test_perfect_score_when_all_criteria_met() -> None:
    conclusions = {
        "final_diagnosis": "STEMI",
        "treatment_plan": {
            "medications": [{"name": "Activate cath lab", "dose": "", "route": ""}],
            "non_pharmacological": ["Immediate ECG"],
            "referrals": [],
            "follow_up": [],
        },
    }
    result = compute_score(_snapshot(), conclusions, ["ECG", "Troponin"])
    assert result.total_score == 100.0
    assert result.score_diagnosis == 100.0
    assert result.score_diagnostics == 100.0
    assert result.findings == []


def test_wrong_diagnosis_zeros_diagnosis_subscore() -> None:
    conclusions = {"final_diagnosis": "Pneumonia", "treatment_plan": {}}
    result = compute_score(_snapshot(), conclusions, ["ECG", "Troponin"])
    assert result.score_diagnosis == 0.0
    assert any(f.finding_type == "wrong_diagnosis" for f in result.findings)


def test_missing_must_order_reduces_diagnostics_score() -> None:
    conclusions = {"final_diagnosis": "STEMI", "treatment_plan": {}}
    result = compute_score(_snapshot(), conclusions, ["ECG"])
    assert result.score_diagnostics == 50.0
    assert any(f.finding_type == "missing_must_order" for f in result.findings)


def test_weighted_total_within_rounding_tolerance() -> None:
    conclusions = {"final_diagnosis": "Pneumonia", "treatment_plan": {}}
    result = compute_score(_snapshot(), conclusions, [])
    weighted = (
        result.score_diagnosis * 0.4
        + result.score_diagnostics * 0.3
        + result.score_treatment * 0.2
        + result.score_safety * 0.1
    )
    assert abs(result.total_score - round(weighted, 1)) <= 0.1
