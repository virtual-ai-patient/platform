# Feature: Persistent sessions (resume after disconnect)

Sessions are already persisted server-side (`case_sessions` + `action_logs`)
and have an `active|completed|abandoned` lifecycle, but the resume path
is not exposed: `POST /sessions/start` always creates a fresh session,
no endpoint lists the user's active sessions, and the Flutter client
loses chat state on logout, app kill, or network drop.

This feature closes the gap so a learner can sign back in (or reopen the
app after a power cut) and pick up exactly where they left off.

| # | Task | Side |
|---|---|---|
| 01 | Active-sessions list + session-state rehydration API | Backend |
| 02 | "You have unfinished sessions" UI + resume flow | Frontend |

Dependency: 02 depends on 01.
