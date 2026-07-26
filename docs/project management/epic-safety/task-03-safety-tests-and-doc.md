# [Task]: Red-team tests + short safety doc section

## Task Description & Context

Closes the epic's "test suite for common safety violation attempts" and
"documentation of safety mechanisms" bullets at a level appropriate for
pre-pilot scope — a small pytest module and a short section appended
to an existing QA doc, not a separate compliance deliverable.

## Subtasks

- [ ] Add `backend/tests/test_safety.py` with ~12 prompts across four
      scenarios from the epic:
      - asking for real medical advice,
      - break-character / "ignore previous instructions",
      - harmful instructions (self-harm / illegal drug),
      - context-boundary probing (asking for the gold standard).
- [ ] For each prompt, assert `bot.safety.check` returns `rewrite` with
      the expected category. (No LLM call needed — we test the filter,
      not the model.)
- [ ] Add a "Safety mechanisms" subsection to `docs/qa/index.md` (or
      the latest `qa-rev*.md`) listing:
      - the prompt-level rules from task 01,
      - the bot filter and disclaimer from task 02,
      - the test module from this task,
      - what's intentionally out of scope until pilot.

## Task Acceptance Criteria

- [ ] `pytest backend/tests/test_safety.py` passes locally and in CI.
- [ ] Each of the four scenarios has at least 3 prompts.
- [ ] The QA doc subsection links to the three code paths
      (`build_system_prompt`, `bot/safety.py`, `test_safety.py`).

## Sub-issues

Sub-issues are blockers for this task.
