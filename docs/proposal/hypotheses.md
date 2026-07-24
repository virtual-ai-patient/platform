---
title: Hypotheses
parent: Proposal
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

## Hypotheses

### H1 — Patient Role

| | |
|:---|:---|
| **Statement** | An LLM can convincingly simulate lying, forgetting, and emotional states in a clinical conversation. |
| **Iteration** | P1 |
| **Owner** | Aizat |
| **Validation method** | Domain expert rates believability ≥ 4/5 on each of five rubric dimensions: (1) lying / deliberate concealment, (2) forgetting / partial recall, (3) hesitation and delayed disclosure, (4) emotional tone, (5) health-literacy variation. |
| **Rubric grounded in** | [user-insights.md — P-01](user-insights.md#2026-07-22--p-01), [P-02](user-insights.md#2026-07-22--p-02) |
| **Status** | `open` |
| **Evidence** | — |

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
| March 2026 | Karim Abdulkin | Document created; H1, H2, H3 opened. Validation methods grounded in expert sessions P-01 and P-02. |
