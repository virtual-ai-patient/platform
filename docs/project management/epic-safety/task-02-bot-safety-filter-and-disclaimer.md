# [Task]: Bot-side safety filter + training-only disclaimer

## Task Description & Context

Single lightweight layer in the Telegram bot that does three things:

1. Shows a "training only, not real medical advice" disclaimer on
   `/start` and at case launch.
2. Inspects inbound user messages and outbound AI replies against a
   small keyword/regex list; on a hit either rewrites the reply with
   the refusal phrase from task 01 or logs and lets it through.
3. Logs every non-pass decision via the existing Python logger (no DB
   table, no admin API) so we can grep the bot logs during pilot.

This collapses the original "policy layer", "output content filter",
"disclaimers", "safety event storage", and "monitoring" tasks into one
file that's actually shippable for MVP.

## Subtasks

- [ ] Add `bot/safety.py` with:
      - `DISCLAIMER` constant (one short paragraph),
      - `check(text, direction) -> (action, category)` where
        `action ∈ {"pass", "rewrite"}`,
      - small keyword/regex lists for: real-medical-advice request,
        break-character/jailbreak attempt, harmful instructions
        (self-harm / illegal drugs).
- [ ] In `bot/bot.py`:
      - send `DISCLAIMER` on `/start` and as the first message of any
        new case session,
      - run `check(..., "inbound")` before calling the backend; on
        `rewrite`, reply with the refusal phrase and skip the backend
        call,
      - run `check(..., "outbound")` on the backend reply; on
        `rewrite`, substitute the refusal phrase,
      - on any non-pass decision, `logger.warning("safety", extra={...})`
        with `category`, `direction`, `excerpt`.
- [ ] Smoke test in `backend/tests/` or `bot/tests/` (pick whichever
      exists) covering: clean message passes, "give me a real
      prescription" rewrites, "ignore previous instructions" rewrites.

## Task Acceptance Criteria

- [ ] `/start` and case launch both post the disclaimer.
- [ ] At least one positive and one negative case per category passes
      in the smoke test.
- [ ] Every rewrite emits a `logger.warning` line with
      `category`, `direction`, and a short `excerpt`.
- [ ] No new DB tables, no new HTTP endpoints (kept minimal on
      purpose).

## Sub-issues

Sub-issues are blockers for this task.
