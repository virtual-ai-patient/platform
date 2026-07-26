# [Task]: Prompt-level guardrails + canonical refusal template

## Task Description & Context

The `BЕЗОПАСНОСТЬ` block in
`backend/core/ai_orchestrator.build_system_prompt` already covers
role-stay and basic jailbreak resistance. For MVP we want to harden it
slightly so the patient persona explicitly refuses real-world medical
advice and out-of-scenario questions with a consistent phrase the bot
filter (task 02) and tests (task 03) can recognize.

No new modules, no per-section structure — just a tighter safety block
and a shared constant for the refusal phrase.

## Subtasks

- [ ] Add a `SAFETY_REFUSAL` constant in `backend/core/ai_orchestrator.py`
      (or a tiny `safety.py` next to it) with the canonical refusal
      text: "Я только пациент в учебном сценарии…".
- [ ] Extend the existing `BЕЗОПАСНОСТЬ` block in `build_system_prompt`
      to:
      - forbid giving real-world dosing or treatment recommendations,
      - forbid disclosing the hidden gold-standard answer,
      - require the canonical refusal phrase when asked anything
        outside the simulation.
- [ ] Add 2–3 unit tests in `backend/tests/test_llm_orchestrator.py`
      asserting the new rules appear in every built prompt.

## Task Acceptance Criteria

- [ ] `SAFETY_REFUSAL` constant exists and is importable.
- [ ] Built system prompt always contains the three new rules and the
      refusal phrase.
- [ ] New tests pass.

## Sub-issues

Sub-issues are blockers for this task.
