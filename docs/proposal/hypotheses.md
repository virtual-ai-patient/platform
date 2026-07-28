---
layout: default
title: Hypotheses
parent: Proposal
grand_parent: Current — Startup Proposal
nav_order: 2
---

# Hypotheses

This is the **living hypothesis tracker** for the Virtual AI Patient startup
proposal. It is the L3 artifact defined by
[Configuration Management](../cm/configuration-management-rev2.md).

Every proposal claim must trace back to a hypothesis here, and every hypothesis
must trace back to evidence in
[User Insights](user-insights.md) (L2).

---

## How to read this table

| Field | Meaning |
|:---|:---|
| **ID** | H1 / H2 / H3 — stable identifier used in issues and user-insight entries |
| **Statement** | The falsifiable claim we are testing |
| **Iteration** | Which prototype iteration owns this hypothesis |
| **Owner** | Who is responsible for producing the evidence |
| **Validation method** | The specific, checkable test — not a general intention |
| **Status** | `open` · `confirmed` · `refuted` |
| **Evidence** | Link to the L2 entry that closes the hypothesis |

---

## H1 · H2 · H3

### H1 — Patient Role

| | |
|:---|:---|
| **Statement** | An LLM can convincingly simulate lying, forgetting, and emotional states in a clinical conversation. |
| **Iteration** | P1 |
| **Owner** | Aizat |
| **Validation method** | Domain expert rates believability ≥ 4/5 on each of five rubric dimensions: (1) lying / deliberate concealment, (2) forgetting / partial recall, (3) hesitation and delayed disclosure, (4) emotional tone, (5) health-literacy variation. |
| **Rubric grounded in** | [user-insights.md — P-01](user-insights.md#2026-07-22--p-01), [P-02](user-insights.md#2026-07-22--p-02) |
| **Status** | `open — automated baseline complete, expert session pending` |
| **Evidence** | — |

#### Preliminary findings by dimension

Automated multi-model harness: 3 models (Claude Sonnet 4.6, Qwen 2.5 72B, Ministral 8B), 25-turn scripted dialogues, 2 Russian-language clinical cases.
Full methodology and raw results: [patient-role-research.md](patient-role-research.md).

| Dimension | Automated result | Confidence | What remains |
| :--- | :--- | :--- | :--- |
| **1. Lying / deliberate concealment** | Concealment prompt works: zero forbidden-token failures across all models at t=0.3. Persona-consistent deflection style displaces assistant-register "Я не врач" responses. | Preliminary — keyword checks only | Expert rates believability of concealment in stored transcripts |
| **2. Forgetting / partial recall** | Closed-world instruction with explicit negative inventory works: patient answers "не знаю / не помню" for out-of-scope facts in all tested runs. | Preliminary — keyword checks only | Expert rates plausibility of forgetting behaviour |
| **3. Emotional tone** | No register-switch or meta-commentary failures on tone probes in case-1 runs. Tone stability is an impression from transcript reading, not a scored result. | Weak — no direct rubric check exists yet | Expert rates emotional plausibility; direct tone rubric check needed |
| **4. Hesitation and delayed disclosure** | **Not tested.** No prompt variant instructs hesitation; harness has no hesitation check. Hedged phrasings observed are from case facts, not a hesitation strategy. | None | Prompt pattern + harness check to be designed before expert session |
| **5. Health-literacy variation** | **Not tested.** Out of scope for the automated harness. | None | Prompt pattern + harness check to be designed before expert session |

**To close H1:** dimensions 4 and 5 need a prompt strategy and an automated check before the expert session; then a domain expert rates all five dimensions on stored transcripts using the Likert rubric in [ai-patient-experimental-verification.md](../research/ai-patient-experimental-verification.md), section "Оценка ответов". All five must reach ≥ 4/5.

---

### H2 — Case System

| | |
|:---|:---|
| **Statement** | A constrained investigation budget changes how learners reason through a clinical case. |
| **Iteration** | P2 |
| **Owner** | Ilnar + Timur |
| **Validation method** | Corridor test: ≥ 3 participants complete a P2 case without assistance from the team. Observers record where (if anywhere) participants run out of budget, skip tests, or change their diagnostic strategy. |
| **Rubric grounded in** | [user-insights.md — P-02](user-insights.md#2026-07-22--p-02) (investigation prices, test-to-case compatibility, constraints) |
| **Status** | `open` |
| **Evidence** | — |

---

### H3 — Full Loop

| | |
|:---|:---|
| **Statement** | The complete flow (conversation → investigations → diagnosis → debrief) feels like a game, not a form, and the debrief surfaces the two critical clinical reasoning errors identified by domain experts. |
| **Iteration** | P3 |
| **Owner** | All |
| **Validation method** | User feedback session with ≥ 5 participants using a structured protocol (not open-ended "did you like it"). Two debrief-specific checks: (a) the debrief flags **missed escalation** of a critical presentation when the learner failed to act on it; (b) the debrief flags **confirmation bias** when the learner forced evidence to fit an early hypothesis. Majority of participants describe the experience as engaging rather than form-filling. |
| **Rubric grounded in** | [user-insights.md — P-01](user-insights.md#2026-07-22--p-01) (missed escalation, confirmation bias), [P-02](user-insights.md#2026-07-22--p-02) (game feel, House MD reference) |
| **Status** | `open` |
| **Evidence** | — |

---

## How to close a hypothesis

**Decision-makers:** Karim + hypothesis owner.

**Required to confirm:**
- Validation method executed exactly as described above (no shortcuts).
- Evidence recorded as a new entry in `docs/proposal/user-insights.md`.
- Rating or finding meets the stated threshold.

**Required to refute:**
- Evidence recorded as a new entry in `docs/proposal/user-insights.md`.
- Status updated to `refuted` + evidence link filled.
- Retrospective GitHub Issue opened: what the finding means, whether a revised hypothesis is warranted.

A hypothesis is **never silently dropped** — refutation is recorded just like confirmation.

**Timing:** Hypothesis closure happens at the Thursday mentor session following the validation run, not before evidence is written up.

---

## Changelog

| Date | Author | Change |
|:---|:---|:---|
| 26-07-2026 | Karim Abdulkin | Expanded H1 with per-dimension preliminary findings table: dimensions 1–3 have automated baseline, dimensions 4–5 untested. Documented what remains for expert session closure. |
| March 2026 | Karim Abdulkin | Document created; H1, H2, H3 opened. Validation methods grounded in expert sessions P-01 and P-02. |
