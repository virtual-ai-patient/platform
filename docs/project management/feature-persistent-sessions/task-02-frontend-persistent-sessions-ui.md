### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

Even with the backend persistence in place, the Flutter client today drops chat state on logout, app kill, or network drop and silently lets the learner start a duplicate session on the same case. This enabler adds a "You have unfinished sessions" surface on app launch and a resume flow that calls the new rehydration endpoint so the learner picks up exactly where they left off.

*   **[QA-REL-01 (Data Integrity)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#4-reliability--data-integrity-qa-rel):** Client must never silently overwrite or lose persisted session state — every interruption recovers cleanly on next launch.
*   **[QA-PERF-04 (API Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** Unfinished-sessions check happens once on launch behind a loading skeleton; resume payload is hydrated before navigation completes.
*   **[QA-SEC-03 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#5-security--privacy-qa-sec):** Resume relies on the authenticated `/me` token; sessions belonging to other users are never reachable from the resume UI.

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **OpenAPI client:** Regenerate via `frontend/openapi/openapi.bash` after the backend enabler lands.
2.  **Repository:** Extend `frontend/lib/domains/sessions/session_repository.dart` with `listActive()`, `getState(sessionId)`, `abandon(sessionId)`, and a `start(caseId, {force})` that handles the 409-with-existing-session response.
3.  **Launch hook:** On successful auth, the app shell calls `listActive()`. If the result is non-empty, present an `UnfinishedSessionsSheet` modal with one row per active session: case title, last activity, progress summary, and two actions — **Resume** and **Abandon**.
4.  **Resume flow:** "Resume" fetches `/state`, hydrates the chat, ordered tests, and conclusions stores, then navigates to the case session screen at the last turn. "Abandon" calls `POST .../abandon` and removes the row from the sheet.
5.  **Duplicate-start handling:** When the learner taps "Start case" on a case they already have active, the existing 409 response opens a dialog: "You already have an unfinished session for this case" → **Resume existing** | **Start fresh** (calls `start(force: true)`).
6.  **Quality Compliance:** **Flutter / Dart strong mode** with `flutter analyze` clean; explicit UI for loading, empty, 200, 403, and network-error states.

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] `UnfinishedSessionsSheet` opens automatically after login when the user has at least one active session.
*   [ ] "Resume" rehydrates chat history, ordered tests, and current conclusions identically to the state before disconnect (verified by an end-to-end test using a recorded session fixture).
*   [ ] "Abandon" removes the session from the sheet and is reflected by a `409 → no longer active` on any subsequent action.
*   [ ] Tapping "Start case" on a case with an active session opens the duplicate-start dialog instead of creating a parallel session.
*   [ ] Sheet, dialog, and resume flow each have explicit loading / empty / error UI — no generic fallback.
*   [ ] Widget tests cover the sheet (empty + populated), the duplicate-start dialog, and the resume hydration flow with a mocked repository.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
