### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

This enabler turns the evaluation artifact into the educational payoff of the simulation: a Flutter screen that shows the learner their score and, for every deduction, what was expected, what they did, and how to correct it. Without it, the backend scoring engine has no consumer.

*   **[QA-PERF-03 (Debriefing Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** The debrief view must be perceived as instantaneous after `finish_session` returns — UI shows skeleton then content within the 5s envelope.
*   **[QA-REL-01 (Data Integrity)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#4-reliability--data-integrity-qa-rel):** No learner submission or finding may be silently dropped by the client; every field returned by the backend is rendered.
*   **[QA-SEC-03 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#5-security--privacy-qa-sec):** Client must surface 403 / 409 explicitly rather than fall back to "something went wrong".

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **OpenAPI client:** Regenerate via `frontend/openapi/openapi.bash` after the backend enabler lands so typed `ScoreSummary`, `Finding`, and `Debrief` models are available.
2.  **Repository:** `frontend/lib/domains/evaluation/evaluation_repository.dart` wraps `GET /v1/sessions/{id}/scores` and `GET /v1/sessions/{id}/debrief`.
3.  **Presentation:** `frontend/lib/features/evaluation/presentation/debrief_screen.dart` with three sections:
    *   **Scores header** — total + four sub-scores.
    *   **Findings list** — grouped by category, sorted high-severity first, each row showing `expected` / `actual` / `why_matters` / `how_to_correct`.
    *   **Reference solution** — collapsible section.
4.  **Navigation:** "Finish case" CTA and tapping a finished session in the cases list both open the debrief screen.
5.  **Quality Compliance:** Use **Flutter / Dart strong mode** with `flutter analyze` clean; explicit UI for every state (loading, 200, 403, 404, 409 not-finished).

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] Debrief screen renders against a real backend in dev with no console errors on web and mobile targets.
*   [ ] All four error states (loading, 403, 404, 409 not-finished) have explicit UI — no generic fallback.
*   [ ] Findings are grouped by category and sorted with high-severity first.
*   [ ] Widget tests in `frontend/test/features/evaluation/` cover loading, success, empty findings, 409, and 403 states and pass.
*   [ ] Navigation from "Finish case" and from the cases list both reach the debrief screen.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
