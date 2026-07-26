### <h2> Justification / Business Value <a id="justification-business-value" href="#justification-business-value">🔗</a> </h2>

This enabler turns the analytics endpoints into a usable view: a role-aware Flutter dashboard that lets a learner see their own progress and an educator/admin inspect a cohort and trigger an export. Without it, the analytics backend has no consumer in the platform itself.

*   **[QA-PERF-04 (API Latency)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#2-performance--latency-qa-perf):** Dashboard must feel responsive — loading skeletons appear immediately while the p95 ≤ 500ms backend call resolves.
*   **[QA-SEC-03 (RBAC)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#5-security--privacy-qa-sec):** Layout is chosen from the user role returned by `/me`; client never assumes elevated scope.
*   **[QA-ARCH-02 (Action Trace)](https://virtual-ai-patient.github.io/platform/qa/qa-rev2.html#7-architecture--observability-qa-arch):** Export trigger surfaces the structured action-trace data to educators in a portable format.

### <h2> Proposed Technical Implementation <a id="proposed-technical-implementation" href="#proposed-technical-implementation">🔗</a> </h2>

1.  **OpenAPI client:** Regenerate via `frontend/openapi/openapi.bash` after the backend analytics enabler lands.
2.  **Repository:** `frontend/lib/domains/analytics/analytics_repository.dart` wraps `/v1/analytics/me`, `/v1/analytics/cohorts/{id}`, and the export endpoint.
3.  **Presentation:**
    *   `frontend/lib/features/analytics/presentation/dashboard_screen.dart` — role-aware layout (learner vs educator/admin), driven by the role from `/me`.
    *   Widgets: `ScoreTrendChart`, `SubScoreBreakdown` reused across both modes.
    *   `ExportButton` opens a dialog (scope, date range, format) and triggers download — web: blob download; mobile: share sheet.
4.  **State handling:** Explicit UI for loading / empty / 403 / error states; the export button is disabled while a previous export is in flight.
5.  **Quality Compliance:** **Flutter / Dart strong mode** with `flutter analyze` clean; widget tests cover the two chart widgets and a flow test exercises the export dialog with a mocked repository.

### <h2> Acceptance Criteria (AC) <a id="acceptance-criteria-ac" href="#acceptance-criteria-ac">🔗</a> </h2>

*   [ ] Dashboard renders against a real backend in dev for learner and educator/admin roles with no console errors.
*   [ ] Empty date ranges render explicit placeholder states for every widget.
*   [ ] Export produces a valid CSV file on web and mobile (verified manually + flow test).
*   [ ] Widget tests cover `ScoreTrendChart`, `SubScoreBreakdown`, and the export dialog flow and pass.
*   [ ] 403 from a cohort endpoint surfaces an explicit "You don't have access to this cohort" message rather than a generic fallback.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are type `Task` issues that must be resolved to resolve this issue.
