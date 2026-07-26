---
layout: default
title: QA Revision 4
parent: QA
grand_parent: Current — Startup Proposal
nav_order: 4
---

# Quality Attributes (QA) — Virtual AI Patient
**Document Version:** 4.0 (Revision 4)
**URL:** [Here](https://virtual-ai-patient.github.io/platform/qa/qa-rev4)

> **[RETROSPECTIVE — Written July 2026]** This revision was written to capture hypothesis-validation exit criteria after expert sessions P-01 and P-02. It describes the quality attributes as they *should have been* formalised upon receiving that evidence. See [About the Pivot](../about-the-pivot.md).

## 1. Overview

This revision adds a **Hypothesis Validation** group (QA-VAL) following expert sessions P-01 and P-02 (2026-07-22). Those sessions confirmed the three hypotheses are well-formed and testable, and surfaced two specific failure modes (missed escalation, confirmation bias) that the debrief layer must detect. QA-VAL makes these validation criteria first-class quality attributes so that each prototype iteration has a clear, measurable exit condition.

QA-PERF is trimmed to PERF-01 only — the single latency constraint that directly affects expert session quality. The rest of Rev 3 (QA-REPRO, QA-DOC, QA-ARCH, QA-SAFE, QA-REL) is carried forward unchanged.

**Traceability:** [hypotheses.md](../proposal/hypotheses.md) · [user-insights.md](../proposal/user-insights.md) (P-01, P-02)

## 2. Hypothesis Validation (QA-VAL)

*Each criterion states what must be true for the linked hypothesis to be considered validated.*

| ID | Criterion | Measurement | Linked hypothesis | Traceable to |
| :--- | :--- | :--- | :--- | :--- |
| **QA-VAL-01** | H1 rubric mean score ≥ 4 / 5 across all five patient-role dimensions (lying, forgetting, hesitation, emotional tone, health literacy) in P1 evaluation session | Structured rubric filled by ≥ 2 independent evaluators | H1 | P-01, P-02 |
| **QA-VAL-02** | ≥ 3 corridor-test participants spontaneously change investigation strategy (order fewer or cheaper tests) after experiencing case cost constraints in P2 | Observed during session; noted in session log | H2 | P-02 |
| **QA-VAL-03** | ≥ 5 structured P3 sessions produce positive "game feel" feedback without coaching; session notes are retained | Post-session interview; retained as L2 artifacts | H3 | P-01, P-02 |
| **QA-VAL-04** | Debrief output for a case with a missed-escalation or confirmation-bias error must name the pattern and link it to a specific case event | Manual review against two reference cases | H3 | P-01 |
| **QA-VAL-05** | Every factual claim in the final proposal deck must link to ≥ 1 entry in [user-insights.md](../proposal/user-insights.md) | Traceability review before pitch | H1, H2, H3 | P-01, P-02 |

## 3. Performance & Latency (QA-PERF)

* **QA-PERF-01:** Virtual patient chat responses must be delivered in ≤ 2 seconds to preserve simulation immersion during expert evaluation sessions.

*QA-PERF-02 and QA-PERF-03 suspended — investigation results and debrief timing are not blocking for expert sessions at prototype scale.*

## 4. Reliability & Data Integrity (QA-REL)

* **QA-REL-01:** Zero loss of session state, learner submissions, or scoring data within a session.

## 5. AI Safety & Guardrails (QA-SAFE)

* **QA-SAFE-01:** Prompt injection protection — input validation must prevent escape from the simulation context or extraction of the system prompt.
* **QA-SAFE-02:** AI responses must not provide real-world medical advice; all output must be grounded in case data.
* **QA-SAFE-03:** Unsafe inputs and outputs must be logged for review.

## 6. Architecture & Observability (QA-ARCH)

* **QA-ARCH-01:** The AI adapter must be pluggable — swapping the LLM provider must require no changes outside the adapter layer.
* **QA-ARCH-02:** All learner actions must be captured in structured logs, exportable for analytics.

## 7. Reproducibility (QA-REPRO)

* **QA-REPRO-01:** `docker compose up` must bring up the full stack in one command with no manual configuration steps.
* **QA-REPRO-02:** A seed script must populate at least one complete case so the prototype can be demonstrated immediately after startup.
* **QA-REPRO-03:** A mock LLM must be available as a drop-in so the prototype runs without an external API key.

## 8. Documentation (QA-DOC)

* **QA-DOC-01:** The README must include a quickstart section that gets a reviewer from `git clone` to a running prototype in under 10 minutes.
* **QA-DOC-02:** Each significant architectural decision must be recorded as an ADR.

---

## Changelog

| Date | Revision | Author | Trigger / Source | Changes Made |
| :--- | :--- | :--- | :--- | :--- |
| 24-07-2026 | 4.0 | Karim Abdulkin | Expert sessions [P-01](../proposal/user-insights.md#2026-07-22--p-01) and [P-02](../proposal/user-insights.md#2026-07-22--p-02) (2026-07-22) | Added QA-VAL group: 5 hypothesis-validation criteria (VAL-01–VAL-05) traceable to P-01 and P-02. Slimmed QA-PERF to PERF-01 only. QA-REPRO, QA-DOC, QA-ARCH, QA-SAFE, QA-REL carried forward from Rev 3. |
| 10-03-2026 | 3.0 | Karim Abdulkin | Project pivot | Suspended QA-SCALE. Added QA-REPRO, QA-DOC. |
| 15-03-2026 | 2.0 | Karim Abdulkin | Sprint 03 Overview | Reduced chat latency; scalability anchors; security matrix. |
| 03-03-2026 | 1.0 | Karim Abdulkin | Initial project setup | Extracted from `product_description.md`. |
