# Epic: AI Safety & Guardrails — Minimum viable breakdown

No external customer yet, so this slice covers only what's needed to keep
the AI patient in-character and prevent obvious unsafe output. Heavy
machinery (dedicated monitoring service, dashboards, audit DB tables,
compliance review process) is intentionally out of scope until a partner
or pilot demands it.

Each task file follows the `.github/ISSUE_TEMPLATE/task.yml` schema and
can be pasted into a new GitHub Issue using the **Task** template.

| # | Task | What it covers from the epic |
|---|---|---|
| 01 | Prompt guardrails + refusal template | Prompt-level constraints, role-lock, no-real-advice rule |
| 02 | Bot-side safety filter + disclaimers | Policy/output filtering, training-only disclaimers, simple stdout logging of violations |
| 03 | Red-team tests + short safety doc | Test suite for common violations, brief compliance section in existing docs |

Explicitly deferred until there's a pilot/customer ask:
- dedicated `safety_events` DB table and admin API,
- monitoring service, dashboards, paging alerts,
- versioned disclaimer registry and per-session acknowledgement records,
- separate compliance document with sign-off workflow.

Depends on EPIC-03 (Conversational Virtual Patient Engine).
