### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

The current rules-based evaluator scores diagnosis, diagnostics, treatment, and safety, but the doctor–patient conversation itself is unscored. Communication quality (open-ended questions, empathy, structured history-taking, closing the loop, avoidance of leading questions) is a primary educational target of the simulation. This enabler runs an LLM-as-judge over the persisted chat log and emits a per-criterion communication score that the debrief screen can display.

*   **[QA-PERF-03 (Debriefing Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** Automated evaluation must complete in ≤ 5 seconds — the judge runs once per finished session, not on every chat turn.
*   **[QA-REL-02 (Deterministic Evaluation)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#4-reliability--data-integrity-qa-rel):** Judge calls use `temperature=0` and a fixed rubric prompt so re-runs over the same chat yield the same score.
*   **[QA-ARCH-01 (Pluggable AI Adapters)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#7-architecture--observability-qa-arch):** Judge calls go through the existing `AIProvider` interface so the model can be swapped without touching scoring logic.
*   **[QA-SAFE-02 (No Real Medical Advice)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#6-ai-safety--guardrails-qa-safe):** Judge prompt is constrained to communication style only — it must not emit any clinical recommendation back to the learner.

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **Endpoints:**
    *   `POST /v1/sessions/{session_id}/communication-evaluation`: Triggers (or re-runs) the LLM judge over the session's chat log. Idempotent: returns the existing record if already scored.
    *   `GET /v1/sessions/{session_id}/communication-evaluation`: Returns the persisted per-criterion result.
2.  **Data Schema (Communication Evaluation):**
    *   **CommunicationEvaluation:** `session_id` (unique), `model`, `prompt_version`, `total_score` (0–100), `created_at`.
    *   **CommunicationCriterion:** `evaluation_id`, `criterion` (e.g. `open_ended_questions`, `empathy`, `structured_history`, `closing_the_loop`, `no_leading_questions`), `score` (0–5), `rationale`, `quote` (short excerpt from the chat).
3.  **Judge pipeline (`backend/communication_eval/service.py`):**
    *   Loads the full `ActionLog` for the session, filters to user/assistant turns, and renders them as a numbered transcript.
    *   Sends a single LLM call via `AIProvider.complete` with `temperature=0` and a versioned rubric prompt that requires JSON output (score per criterion + short rationale + a verbatim quote from the transcript).
    *   Validates the JSON against a Pydantic schema; rejects with a 502 and an error event if it doesn't parse.
    *   Persists the result through `backend/communication_eval/repository.py`.
4.  **Quality Compliance:** **Python 3.14** with **MyPy --strict**; finished session required (409 if not); ownership/admin auth identical to `/scores` and `/debrief`.

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] Alembic migration for `communication_evaluations` and `communication_criteria` applies cleanly and is reversible.
*   [ ] `POST .../communication-evaluation` is idempotent per `session_id` (second call returns the existing record).
*   [ ] Both endpoints reachable under `/v1/sessions/{id}/communication-evaluation` and visible in Swagger UI.
*   [ ] Re-running the judge on the same transcript with the same `prompt_version` yields identical scores (verified by a test using the mock provider).
*   [ ] Judge rejects malformed JSON output with a clear 502 instead of corrupting the DB.
*   [ ] Auth paths covered by tests: owner 200, non-owner 403, admin 200, unfinished session 409, missing session 404.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
