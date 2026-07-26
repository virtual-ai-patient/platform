# Epic: REST API Backend — Evaluation & Analytics slice

Tasks below cover the **Evaluation** and **Analytics** API categories of
the REST API epic. Scope is intentionally trimmed for MVP: only Flutter
client + FastAPI backend (no bot client), one backend task and one
frontend task per API.

Each file follows the `.github/ISSUE_TEMPLATE/task.yml` schema and can
be pasted into a new GitHub Issue using the **Task** template.

| # | Task | Side | API |
|---|---|---|---|
| 01 | Evaluation API: scoring engine + endpoints | Backend | Evaluation |
| 02 | Evaluation UI: debrief & scores screen | Frontend | Evaluation |
| 03 | Analytics API: aggregation + export endpoints | Backend | Analytics |
| 04 | Analytics UI: dashboard + export trigger | Frontend | Analytics |

Dependencies: 02 depends on 01; 04 depends on 03; 03 depends on 01
(uses evaluation artifacts as input).

All endpoints sit under `/v1` and follow the existing module pattern
(`request.py` / `response.py` / `service.py` / `repository.py` /
`router.py`) used by `backend/sessions/`.
