Parent epic: [#13 — Analytics and Observability](https://github.com/virtual-ai-patient/platform/issues/13).

### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

Even with the backend export endpoints in place, an educator or researcher cannot get data out of the system without a UI trigger — copying `curl` commands is not an option for a corridor-test demo. This enabler adds an **Export** action on the analytics screen and on the per-session view so a reviewer can download a CSV or JSON file in one click. It closes the frontend half of the epic #13 export gap.

*   **[QA-SEC-01 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#4-security--privacy-qa-sec):** The Export button is shown only for scopes the current role can actually export — learners see it on their own session; educators/admins see it on cohort scope. No 403 dead-end from the UI.
*   **[QA-REPRO-04 (Demo-sized datasets)](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#6-reproducibility-qa-repro-new):** Downloads are triggered from the browser and streamed straight into a file — no intermediate in-memory buffer on the client, which keeps the demo build tolerant of small download sizes without extra tuning.
*   **[QA-DOC-01 (Reviewer quickstart)](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#7-documentation-handoff-qa-doc-new):** The UI element is discoverable within one click of the analytics page — a reviewer following the README quickstart can trigger an export without extra guidance.

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **OpenAPI client:** Regenerate via `frontend/openapi/openapi.bash` after task-01 lands so the export endpoints are typed.
2.  **Repository:** `frontend/lib/domains/analytics/export_repository.dart` wraps the three export endpoints and returns a stream of bytes (not a fully-loaded body).
3.  **UI surfaces:**
    *   **Analytics screen (educator/admin):** An **Export** dropdown with entries: *Sessions (CSV)*, *Sessions (JSON)*, *Actions — this cohort (CSV)*, *Actions — this cohort (JSON)*. Cohort selection reuses the existing analytics filter state (`since`, `until`, `cohort_id`).
    *   **Session debrief screen (learner + educator + admin):** An **Export actions** button next to the debrief header with CSV / JSON options for the current session only.
4.  **Download trigger (Flutter web):** Use a Blob URL created from the streamed response body — the browser handles the actual file save. Show a loading spinner during the fetch and an explicit error surface if the response is 4xx/5xx.
5.  **Role gating:** Hide the cohort exports for learners; show only the own-session export. Backend still enforces authorisation; the UI just avoids offering unreachable actions.
6.  **Quality compliance:** **Flutter / Dart strong mode** with `flutter analyze` clean; explicit UI for loading / success / 403 / network-error states; widget tests in `frontend/test/features/analytics/` cover the button visibility per role and the trigger flow with a mocked repository.

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] Export dropdown is visible on the analytics screen for educator + admin, and hidden for learners.
*   [ ] Export button is visible on the debrief screen for the session's owner, educator, and admin.
*   [ ] Clicking any export entry triggers a browser download of a file with the correct extension (`.csv` or `.json`) and a filename that includes the scope and the time window.
*   [ ] 403 responses render as an explicit error toast, not a silent failure.
*   [ ] Widget tests cover role-based visibility (learner / educator / admin) and the download-trigger success + error flows.
*   [ ] Epic #13's Definition-of-Done line **"Export feature working"** can be checked off once task-01 (backend) and this task both land.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
