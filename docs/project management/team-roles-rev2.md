---
layout: default
title: Team Roles — Post-pivot
parent: Strategic Planning
grand_parent: Current — Startup Proposal
nav_order: 3
---

# Team Roles — Post-pivot Plan

This document describes what each team member owns under the hypothesis-driven
plan and why that work is non-trivial. It maps to the three prototype
iterations in [strategic-planning-rev2.md](strategic-planning-rev2.md).

---

## Aizat — LLM Patient Role (H1 owner)

**What:** Design and validate the prompt architecture that makes the LLM
behave as a believable patient — lying about the diagnosis, forgetting
low-salience facts, expressing emotional states, hesitating under pressure.
Build the automated evaluation harness (scripted dialogues, pass/fail checks).
Recruit stored transcripts for the expert rubric session.

**Why it is hard:** Prompt engineering for roleplay is not a solved problem.
The same instruction that stops the model from naming the diagnosis also risks
making it evasive in ways that break immersion. Temperature, context length,
and the structure of the closed-world fact block interact in non-obvious ways
across models. Automated keyword checks over-trigger (catching benign phrases)
and under-trigger (missing fluent but wrong outputs) — so the harness itself
requires calibration. Hesitation and health-literacy variation have no
established prompt patterns yet and need to be designed from scratch before
the expert session.

**Why it matters:** H1 is the proposal's central claim. If an expert rates
the patient role below 4/5 on any rubric dimension, the core differentiator
argument fails. Everything else depends on this being compelling first.

---

## Ilnar — Backend and Case System (H2 owner, backend lead)

**What:** Build and maintain the FastAPI backend, session state machine, and
PostgreSQL schema. For H2: implement the investigation catalog with prices,
test–case compatibility rules, and a per-session budget counter. Own
`docker compose up` reproducibility (QA-REPRO): one command must bring up
the full stack with a seeded case.

**Why it is hard:** The session state machine must track what the patient has
already disclosed, what the learner has already ordered, and the current
budget — all consistently across a multi-turn dialogue. Race conditions and
state drift produce subtle bugs that only surface mid-session during an expert
demo. The budget system must be flexible enough to encode case-specific rules
(some tests are irrelevant for a given case and should either be blocked or
marked free) without becoming a bespoke configuration language. Reproducible
local deployment sounds simple but involves coordinating migrations, seed
scripts, and mock LLM injection across three containers.

**Why it matters:** H2 cannot be tested without a working budget system.
QA-REPRO is a prerequisite for every expert session and corridor test — if
the stack does not come up cleanly in under five minutes, the session is lost.

---

## Timur — Frontend and UX (H3 co-owner)

**What:** Build and iterate the Flutter web interface: chat view, investigation
ordering panel with budget display, diagnosis/treatment submission forms, and
the debrief screen. Polish the flow so that moving from conversation to
investigations to debrief feels continuous, not form-like.

**Why it is hard:** "Game feel" (H3) is a qualitative property that emerges
from dozens of small decisions — transition animations, information density,
how the budget counter updates, how the debrief reveals findings progressively.
There is no checklist for it. The frontend must also handle the async nature
of LLM responses (streaming or polling) without making the patient feel
unresponsive, which directly affects H1 believability. Every corridor test
surfaces a new friction point; the iteration cycle is tight.

**Why it matters:** H3 is validated through user sessions, and every session
is the only chance to catch friction before the next iteration. A clunky UI
causes participants to describe the experience as a form even if the LLM
behaves correctly — making it impossible to attribute a failed H3 session
to the concept rather than the interface.

---

## Alina — Proposal and User Research (PM)

**What:** Write and maintain the proposal documents. Recruit participants
for expert sessions and corridor tests. Facilitate sessions or coordinate
facilitators. Record L2 artifacts in `user-insights.md` within 24 hours of
each session. Track hypothesis status and drive the Monday planning meeting.
Own the pitch narrative and slide deck.

**Why it is hard:** Recruiting domain experts and willing students on a
student timeline is genuinely difficult — people cancel, respond slowly, and
require scheduling coordination. The L2 artifact must be written while
memories are fresh and must anonymise the participant correctly; a badly
recorded session cannot be used as evidence. The pitch narrative must connect
technical findings (rubric scores, corridor-test observations) to a claim that
would be credible to an investor or institutional buyer — two audiences with
very different priors.

**Why it matters:** Without participants there are no sessions, and without
sessions no hypothesis closes. Without a coherent narrative the technical
evidence does not translate into a proposal. Alina is the bottleneck between
"we have findings" and "we have a claim we can pitch."

---

## Karim — QA and Validation (hypothesis-closure lead)

**What:** Design the rubric and session protocols for each hypothesis.
Facilitate expert rubric sessions (H1) and corridor tests (H2). Run
structured feedback sessions for H3. Record results, decide go/no-go at
Thursday mentor sessions with the hypothesis owner. Own the markdownlint and
CI pipeline health. Write QA revisions when constraints change.

**Why it is hard:** Designing a rubric that is specific enough to produce a
go/no-go verdict but general enough to survive changes to the prototype is a
balancing act. Facilitating a session without coaching the participant
(which would invalidate the result) requires discipline. The go/no-go decision
at Thursday session must weigh incomplete evidence honestly — declaring H1
validated on three expert opinions when one dimension is untested is a
traceability failure, not a success. CI health is a background task that
becomes urgent precisely when the team is busy with sessions.

**Why it matters:** If validation is done sloppily, the proposal's evidence
base does not hold up to scrutiny. A single "we tested it with friends"
comment from a reviewer can sink the credibility of all three hypotheses. The
rigor of the validation process is part of what the proposal is selling.
