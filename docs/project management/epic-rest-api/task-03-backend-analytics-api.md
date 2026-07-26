### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

This enabler exposes aggregate progress and a row-per-session export feed over sessions and evaluations. It powers the educator dashboard and is the primary surface a future partner platform will integrate against to pull learner progress into their LMS.

*   **[QA-PERF-04 (API Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** Aggregation endpoints must hold p95 ≤ 500ms on a fixture dataset.
*   **[QA-ARCH-02 (Action Trace)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#7-architecture--observability-qa-arch):** Structured logging of learner actions is the source of truth for analytics — this enabler reads it back out.
*   **[QA-SEC-02 (Conversation Privacy)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#5-security--privacy-qa-sec):** Export must not include raw chat content; only structured submission + scoring fields.
*   **[QA-SEC-03 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#5-security--privacy-qa-sec):** Cohort and export endpoints enforce educator/admin scopes.

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **Endpoints:**
    *   `GET /v1/analytics/me?since=&until=`: Authenticated learner's own progress (score trend, case count, weakest sub-score).
    *   `GET /v1/analytics/cohorts/{cohort_id}?since=&until=`: Cohort aggregates — educator/admin only.
    *   `GET /v1/analytics/export?scope=&since=&until=&format=csv|json`: Streamed row-per-session feed.
2.  **Data Schema (Aggregate Types):** Implement typed dataclasses for:
    *   **LearnerProgress:** counts, average total + sub-scores, time-bucketed score trend.
    *   **CohortSummary:** per-learner roll-up + cohort distribution histograms.
    *   **ExportRow:** flat row with `session_id`, `case_id`, `case_version`, `learner_id`, `finished_at`, scores, finding counts per severity.
3.  **Streaming + Safety:** Export uses FastAPI `StreamingResponse` driven by an async generator — no full materialization. CSV writer escapes RFC-4180 and rejects cells beginning with `=`, `+`, `-`, `@` to prevent spreadsheet injection.
4.  **Quality Compliance:** Use **Python 3.14** with **MyPy --strict**; analytics queries are indexed and bounded by `since`/`until`; aggregations are deterministic against a fixture set.

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] Three endpoints reachable under `/v1/analytics/...` and visible in Swagger UI with example responses.
*   [ ] Authorization enforced: learner reading another learner's cohort gets 403; admin can read any.
*   [ ] Aggregations produce identical results across two runs on the same fixture set.
*   [ ] Export streams a 5 000-row fixture without memory growing linearly in row count (verified by a benchmark test).
*   [ ] CSV round-trips through Python's `csv` reader and rejects spreadsheet-injection-prone leading characters.
*   [ ] Integration tests in `backend/tests/test_analytics.py` cover learner / cohort / export paths and all auth outcomes.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
