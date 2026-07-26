Parent epic: [#13 — Analytics and Observability](https://github.com/virtual-ai-patient/platform/issues/13).

### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

Epic #13 is closed on every acceptance criterion except **"Export functionality for analytics data (CSV/JSON)"** and the related **"Export feature working"** line in the Definition of Done. This enabler delivers exactly that: a backend API that streams both the aggregated analytics view and the raw learner-action trace (the `action_logs` records) as CSV or JSON, so an educator can download a snapshot of a cohort and a researcher can inspect the full action stream behind it.

*   **[QA-ARCH-02 (Structured action trace)](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#8-architecture--observability-qa-arch):** Export reads from the `action_logs` table, which is already the single source of truth for learner actions — this enabler exposes it, does not duplicate it.
*   **[QA-SEC-01 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#4-security--privacy-qa-sec):** Only `educator` and `admin` roles can export cohort data; a `learner` can export only their own actions.
*   **[QA-REPRO-04 (1–5 concurrent demo sessions)](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#6-reproducibility-qa-repro-new):** Export is expected to run on demo-sized datasets (single-host, low concurrency) — streaming is used for correctness, not for throughput at scale.
*   **[QA-REL-02 (Deterministic output)](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#3-reliability--data-integrity-qa-rel):** Two exports over the same time window yield byte-identical CSV output (stable column order, stable row order).

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **Endpoints:**
    *   `GET /v1/analytics/export/sessions?since=&until=&scope=me|cohort:{id}&format=csv|json` — flat row-per-session export (score summary + finding counts). Extends the export slot from the earlier REST-API analytics task.
    *   `GET /v1/analytics/export/actions?session_id=&format=csv|json` — full learner-action stream for a single session (chronological `action_logs` rows: chat turns, test orders, submissions).
    *   `GET /v1/analytics/export/actions?cohort_id=&since=&until=&format=csv|json` — same shape, aggregated across a cohort (educator/admin only).
2.  **Data schema (rows):**
    *   **SessionExportRow:** `session_id`, `case_id`, `case_version`, `learner_id`, `started_at`, `finished_at`, `total_score`, per-subscore fields, `findings_by_severity`.
    *   **ActionExportRow:** `session_id`, `learner_id`, `turn_index`, `timestamp`, `action_type` (`chat_user | chat_assistant | order_test | submit_ddx | submit_diagnosis | submit_plan | save_conclusions`), `payload_json` (the structured action body — never a redacted blob).
3.  **Streaming + safety:** All three endpoints use FastAPI `StreamingResponse` driven by an async generator over paginated repository reads — no full materialisation of the result set. CSV writer follows RFC-4180 and prefixes any cell starting with `=`, `+`, `-`, `@` with a single quote to prevent spreadsheet injection.
4.  **Repository additions (`backend/analytics/repository.py`):** `iter_session_rows(scope, since, until)` and `iter_action_rows(session_id | cohort_id, since, until)`. Both take an explicit `order_by` so exports are stable.
5.  **Quality compliance:** **Python 3.14** with **MyPy --strict**; endpoints appear in Swagger UI with example rows; integration tests in `backend/tests/test_export.py` cover CSV + JSON, learner/educator/admin auth outcomes, empty-window edge case, and determinism (two calls → identical bytes).

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] All three endpoints reachable under `/v1/analytics/export/...` and visible in Swagger UI with example responses.
*   [ ] Sessions export and per-session actions export round-trip cleanly through Python's `csv` reader; spreadsheet-injection-prone leading characters are neutralised.
*   [ ] Authorisation enforced: learner exporting another learner's actions gets 403; learner can export their own; educator/admin can export cohort scope.
*   [ ] Two exports over the same window produce byte-identical CSV output (verified by a determinism test).
*   [ ] Export streams a 5 000-row fixture without memory growing linearly in row count (verified by a benchmark test).
*   [ ] Epic #13's "Export functionality for analytics data (CSV/JSON)" acceptance criterion is checked off in that epic when this task closes.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
