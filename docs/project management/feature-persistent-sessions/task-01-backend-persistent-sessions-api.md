### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

Today `case_sessions` already persists every learner action server-side, but the resume path is not exposed: there is no endpoint to list a user's active sessions, no endpoint to return the full state needed to rehydrate a client (frozen case snapshot, chat history, ordered tests, current conclusions), and `POST /sessions/start` will happily create a parallel duplicate session for the same case. This enabler closes those gaps so a logout, app kill, or power cut never costs the learner their work.

*   **[QA-REL-01 (Data Integrity)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#4-reliability--data-integrity-qa-rel):** Zero loss of session state — this is the headline driver.
*   **[QA-PERF-04 (API Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** State rehydration endpoint must hold p95 ≤ 500 ms even on a long chat log.
*   **[QA-SEC-03 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#5-security--privacy-qa-sec):** Learners only see their own active sessions; admins can see any.
*   **[QA-ARCH-02 (Action Trace)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#7-architecture--observability-qa-arch):** Resume is rebuilt from `action_logs` so the action trace remains the single source of truth.

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **Endpoints:**
    *   `GET /v1/sessions/active`: Returns the caller's `active` sessions with `session_id`, `case_id`, `case_title`, `created_at`, `last_activity_at`, and `progress_summary` (turn count, has-conclusions flag).
    *   `GET /v1/sessions/{session_id}/state`: Full rehydration payload — `session` metadata, `case_snapshot`, chat history (windowed but with `next_cursor` for pagination), `ordered_tests`, and current `conclusions`.
    *   `POST /v1/sessions/{session_id}/abandon`: Explicitly mark a session abandoned (used when the learner chooses "start fresh" on the unfinished-sessions prompt).
2.  **Behaviour changes to existing endpoints:**
    *   `POST /sessions/start` now returns `409 Conflict` with the existing `session_id` if the caller already has an `active` session for the same `case_id`. A new `force=true` query flag abandons the old one and starts fresh.
    *   Every successful chat turn / order-test / save-conclusions call updates a new `last_activity_at` column on `case_sessions`.
3.  **Data schema additions:**
    *   `case_sessions.last_activity_at` (timestamptz, indexed) maintained by the existing service-layer write paths.
    *   `SessionRepository.list_active_by_user(user_id)` and `SessionRepository.touch(session_id)` helpers.
4.  **Quality Compliance:** **Python 3.14** with **MyPy --strict**; ownership/admin auth on all three new endpoints; integration tests in `backend/tests/test_persistent_sessions.py` covering list, rehydrate, conflict on duplicate start, force-start, abandon.

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] Alembic migration adds `case_sessions.last_activity_at` (indexed) and is reversible.
*   [ ] `GET /v1/sessions/active` returns only the caller's active sessions, sorted by `last_activity_at desc`.
*   [ ] `GET /v1/sessions/{id}/state` rehydrates a finished test session into an equivalent client state on the next login (verified by an end-to-end test).
*   [ ] `POST /sessions/start` returns 409 with the existing `session_id` when an active session already exists for the same case; `force=true` abandons it and starts fresh.
*   [ ] `last_activity_at` is updated by chat, order-test, and save-conclusions writes (covered by tests).
*   [ ] All three new endpoints appear in Swagger UI with example responses.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
