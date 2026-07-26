### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

This enabler delivers the scoring backbone of the simulation: it converts the learner's diagnostic and treatment decisions into a structured, persisted evaluation that powers the debrief screen and any downstream analytics. Without this, `finish_session` ends a case with no measurable feedback to the learner.

*   **[QA-PERF-03 (Debriefing Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** Automated evaluation and debriefing generation must complete in ≤ 5 seconds.
*   **[QA-PERF-04 (API Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** Backend API p95 latency must be ≤ 500ms for the read endpoints.
*   **[QA-REL-02 (Deterministic Evaluation)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#4-reliability--data-integrity-qa-rel):** Scoring must remain consistent regardless of LLM temperature or randomness — drives the rules-based scorer choice.
*   **[QA-SEC-03 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#5-security--privacy-qa-sec):** Learners can only read their own evaluation; educators/admins can read any.

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **Endpoints:**
    *   `GET /v1/sessions/{session_id}/scores`: Compact summary (total + four sub-scores) for list views and partner integrations.
    *   `GET /v1/sessions/{session_id}/debrief`: Full debrief with structured findings and the reference (gold) solution.
2.  **Data Schema (Evaluation Artifact):** Implement persisted models for:
    *   **Evaluation:** `session_id` (unique), `case_version`, `total_score`, sub-scores for `diagnosis` / `diagnostics` / `treatment` / `safety`.
    *   **EvaluationFinding:** `category`, `type`, `severity`, `expected`, `actual`, `why_matters`, `how_to_correct` — every deduction is explainable per §6.3 of the technical spec.
    *   **Reference Solution:** Snapshot from the case used by the scorer at evaluation time.
3.  **Scoring Engine:** New `backend/evaluation/` module (`repository.py`, `service.py`, `response.py`, `router.py`) following the existing `backend/sessions/` pattern. `service.score_session(session_id)` runs a rules-based scorer (diagnosis match, must-have/should-not-order tests, treatment coverage, hard safety violations), is idempotent on `session_id`, and is invoked from `finish_session` behind an `EVALUATION_AUTO_SCORE` flag.
4.  **Quality Compliance:** Use **Python 3.14** with **MyPy --strict** for the new module; reject requests with 404 (missing session), 403 (non-owner), 409 (session not finished or not yet scored).

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] Alembic migration for `evaluations` and `evaluation_findings` applies cleanly and is reversible.
*   [ ] `score_session` is idempotent per `session_id` and sub-scores sum to the total within rounding tolerance.
*   [ ] `GET /v1/sessions/{id}/scores` and `GET /v1/sessions/{id}/debrief` are reachable and appear in Swagger UI with example responses.
*   [ ] Authorization paths (owner 200, non-owner 403, admin 200, unfinished 409, missing 404) are covered by integration tests in `backend/tests/test_evaluation.py`.
*   [ ] OpenAPI schema in `frontend/openapi/openapi.json` regenerates with no manual edits.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
