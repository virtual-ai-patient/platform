import re
from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True)
class ScoringFinding:
    category: str
    finding_type: str
    severity: str
    expected: str
    actual: str
    why_matters: str
    how_to_correct: str
    deduction_points: float


@dataclass(frozen=True)
class ScoringResult:
    score_diagnosis: float
    score_diagnostics: float
    score_treatment: float
    score_safety: float
    total_score: float
    findings: list[ScoringFinding]
    reference_solution: dict[str, Any]


def normalize_text(value: str) -> str:
    return re.sub(r"\s+", " ", value.strip().lower())


def text_matches(candidate: str, reference: str) -> bool:
    left = normalize_text(candidate)
    right = normalize_text(reference)
    if not left or not right:
        return False
    return left in right or right in left


def build_reference_solution(snapshot: dict[str, Any]) -> dict[str, Any]:
    investigations = snapshot.get("investigations") or {}
    return {
        "case_id": snapshot.get("case_id"),
        "version": snapshot.get("version"),
        "final_diagnosis": snapshot.get("final_diagnosis"),
        "differential": snapshot.get("differential", []),
        "investigations": {"expected": investigations.get("expected", {})},
        "management": snapshot.get("management", {}),
    }


def _flatten_learner_text(conclusions: dict[str, Any]) -> str:
    parts: list[str] = []
    if final_dx := conclusions.get("final_diagnosis"):
        parts.append(str(final_dx))
    treatment = conclusions.get("treatment_plan") or {}
    for med in treatment.get("medications") or []:
        if isinstance(med, dict):
            for key in ("name", "dose", "route"):
                if med.get(key):
                    parts.append(str(med[key]))
    for field in ("non_pharmacological", "referrals", "follow_up"):
        for item in treatment.get(field) or []:
            parts.append(str(item))
    return " ".join(parts)


def _diagnosis_matches(
    learner_diagnosis: str,
    gold_diagnosis: str,
    acceptable_answers: list[dict[str, Any]],
) -> bool:
    candidates = [gold_diagnosis] + [
        item["answer"]
        for item in acceptable_answers
        if item.get("field") == "final_diagnosis" and item.get("answer")
    ]
    return any(text_matches(learner_diagnosis, candidate) for candidate in candidates)


def compute_score(
    snapshot: dict[str, Any],
    conclusions: dict[str, Any],
    ordered_tests: list[str],
) -> ScoringResult:
    scoring = snapshot.get("scoring") or {}
    weights = {
        "diagnosis": float(scoring.get("weight_diagnosis", 0.25)),
        "diagnostics": float(scoring.get("weight_diagnostics", 0.25)),
        "treatment": float(scoring.get("weight_treatment", 0.25)),
        "safety": float(scoring.get("weight_safety", 0.25)),
    }
    findings: list[ScoringFinding] = []

    learner_diagnosis = str(conclusions.get("final_diagnosis") or "")
    gold_diagnosis = str(snapshot.get("final_diagnosis") or "")
    acceptable = list(scoring.get("acceptable_answers") or [])

    if _diagnosis_matches(learner_diagnosis, gold_diagnosis, acceptable):
        score_diagnosis = 100.0
    else:
        score_diagnosis = 0.0
        findings.append(
            ScoringFinding(
                category="diagnosis",
                finding_type="wrong_diagnosis",
                severity="critical",
                expected=gold_diagnosis,
                actual=learner_diagnosis or "(not provided)",
                why_matters="An incorrect final diagnosis can lead to harmful management.",
                how_to_correct=(
                    "Review history, investigations, and differentials before committing "
                    f"to the diagnosis: {gold_diagnosis}."
                ),
                deduction_points=100.0,
            )
        )

    expected = (snapshot.get("investigations") or {}).get("expected") or {}
    must_order = list(expected.get("must_order") or [])
    should_not_order = list(expected.get("should_not_order") or [])
    ordered_set = set(ordered_tests)

    diagnostics_deduction = 0.0
    if must_order:
        per_missing = 100.0 / len(must_order)
        for test_name in must_order:
            if test_name not in ordered_set:
                diagnostics_deduction += per_missing
                findings.append(
                    ScoringFinding(
                        category="diagnostics",
                        finding_type="missing_must_order",
                        severity="major",
                        expected=f"Order {test_name}",
                        actual="Test not ordered",
                        why_matters="Must-order tests are required to confirm or rule out key diagnoses.",
                        how_to_correct=f"Order {test_name} during the diagnostic workup.",
                        deduction_points=per_missing,
                    )
                )

    if should_not_order:
        per_unnecessary = 100.0 / len(should_not_order)
        for test_name in should_not_order:
            if test_name in ordered_set:
                diagnostics_deduction += per_unnecessary
                findings.append(
                    ScoringFinding(
                        category="diagnostics",
                        finding_type="unnecessary_test",
                        severity="major",
                        expected=f"Do not order {test_name}",
                        actual=f"Ordered {test_name}",
                        why_matters="Unnecessary tests add cost, delay, and may mislead the workup.",
                        how_to_correct=f"Avoid ordering {test_name} unless clearly indicated.",
                        deduction_points=per_unnecessary,
                    )
                )

    score_diagnostics = max(0.0, 100.0 - diagnostics_deduction)

    management = snapshot.get("management") or {}
    gold_steps = list(management.get("treatment_plan") or []) + list(
        management.get("diagnostic_plan") or []
    )
    learner_text = _flatten_learner_text(conclusions)
    treatment_deduction = 0.0
    if gold_steps:
        per_missed = 100.0 / len(gold_steps)
        for step in gold_steps:
            if not text_matches(learner_text, str(step)):
                treatment_deduction += per_missed
                findings.append(
                    ScoringFinding(
                        category="treatment",
                        finding_type="missing_treatment_step",
                        severity="major",
                        expected=str(step),
                        actual="Not documented in treatment plan",
                        why_matters="Missing management steps can worsen patient outcomes.",
                        how_to_correct=f"Include in the plan: {step}.",
                        deduction_points=per_missed,
                    )
                )
    score_treatment = max(0.0, 100.0 - treatment_deduction)

    safety_deduction = 0.0
    critical_errors = list(scoring.get("critical_safety_errors") or [])
    contraindications = list(management.get("contraindications") or [])
    safety_corpus = normalize_text(learner_text)

    for test_name in should_not_order:
        if test_name in ordered_set:
            penalty = 50.0
            safety_deduction += penalty
            findings.append(
                ScoringFinding(
                    category="safety",
                    finding_type="safety_violation",
                    severity="critical",
                    expected=f"Do not order {test_name}",
                    actual=f"Ordered {test_name}",
                    why_matters="Ordering contraindicated or inappropriate tests is a patient safety risk.",
                    how_to_correct=f"Remove {test_name} from the diagnostic plan.",
                    deduction_points=penalty,
                )
            )

    for error_text in critical_errors + contraindications:
        normalized_error = normalize_text(str(error_text))
        if normalized_error and normalized_error in safety_corpus:
            safety_deduction += 50.0
            findings.append(
                ScoringFinding(
                    category="safety",
                    finding_type="safety_violation",
                    severity="critical",
                    expected=f"Avoid: {error_text}",
                    actual="Potential safety issue detected in submitted plan",
                    why_matters="Safety violations can cause immediate patient harm.",
                    how_to_correct=f"Remove or revise actions related to: {error_text}.",
                    deduction_points=50.0,
                )
            )

    score_safety = max(0.0, 100.0 - safety_deduction)

    total_score = round(
        score_diagnosis * weights["diagnosis"]
        + score_diagnostics * weights["diagnostics"]
        + score_treatment * weights["treatment"]
        + score_safety * weights["safety"],
        1,
    )

    return ScoringResult(
        score_diagnosis=round(score_diagnosis, 1),
        score_diagnostics=round(score_diagnostics, 1),
        score_treatment=round(score_treatment, 1),
        score_safety=round(score_safety, 1),
        total_score=total_score,
        findings=findings,
        reference_solution=build_reference_solution(snapshot),
    )
