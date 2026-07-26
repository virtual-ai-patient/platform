### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

Without a frontend surface, the communication evaluation never reaches the learner. This enabler adds a dedicated panel to the existing debrief screen that shows the total communication score, a per-criterion breakdown (open-ended questions, empathy, structured history, closing the loop, no leading questions), and the quoted excerpt the judge used for each rationale — so the learner can see exactly what they said.

*   **[QA-PERF-03 (Debriefing Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** Panel must render skeletons immediately and replace them with real content once the 5s judge envelope resolves.
*   **[QA-REL-01 (Data Integrity)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#4-reliability--data-integrity-qa-rel):** Every criterion + rationale + quote returned by the backend is displayed; nothing silently dropped by the client.
*   **[QA-SAFE-02 (No Real Medical Advice)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#6-ai-safety--guardrails-qa-safe):** Panel renders the judge output as feedback on the learner's style, never as actionable clinical advice — surface as "communication coaching".

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **OpenAPI client:** Regenerate via `frontend/openapi/openapi.bash` after the backend enabler lands so `CommunicationEvaluation` and `CommunicationCriterion` models are available.
2.  **Repository:** `frontend/lib/domains/evaluation/communication_repository.dart` wraps `POST` (trigger) and `GET` (fetch) endpoints.
3.  **Presentation:** Add a `CommunicationPanel` widget to `frontend/lib/features/evaluation/presentation/debrief_screen.dart`:
    *   Header: total communication score with a coloured pill.
    *   Body: a list of criterion rows, each with score (0–5), rationale, and the verbatim quote in a quote block.
    *   Empty state: "Communication scoring not available for this session" if the `GET` returns 404.
4.  **Trigger logic:** On entering the debrief screen, the client `GET`s the evaluation. If it returns 404, the client `POST`s once to trigger and re-fetches. Subsequent visits skip the `POST`.
5.  **Quality Compliance:** **Flutter / Dart strong mode** with `flutter analyze` clean; explicit UI for loading / 200 / 404-not-yet-scored / 403 / 502-bad-judge-output states.

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] `CommunicationPanel` renders inside the debrief screen against a real backend in dev with no console errors on web and mobile.
*   [ ] Trigger-on-404 flow runs exactly once per session per app launch (verified by a flow test).
*   [ ] Each criterion row shows score, rationale, and the verbatim quote.
*   [ ] All five error/empty states (loading, 200, 404, 403, 502) have explicit UI — no generic fallback.
*   [ ] Widget tests in `frontend/test/features/evaluation/` cover loading, success, 404 (with trigger), and 403 states and pass.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
