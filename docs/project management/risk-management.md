---
layout: default
title: Risk Management
parent: Strategic Planning
grand_parent: Current — Startup Proposal
nav_order: 4
---

# Risk Management

## Context

This document formalises the key risks relevant to the project’s **post-pivot goal**: validating a startup proposal for an AI‑driven medical training simulator. It aligns with the updated project direction, the mentor feedback on risk maturity, and the requirement to maintain a living risk log.

All risks are documented using the **condition → consequence** format, with assigned owners, likelihood, impact, and concrete mitigation strategies.

---

## Risk Log

### Project / Process Risks

#### R01 — Loss of Customer (Materialised)
- **Condition:** The external customer (Third Opinion) became unresponsive and stopped providing feedback or direction.
- **Consequence:** The project lost its requirements anchor, leading to uncertainty and risk of scope drift.
- **Likelihood:** High (materialised)
- **Impact:** High
- **Owner:** Alina (PM)
- **Status:** Closed (mitigated)
- **Mitigation:** The team pivoted to a “startup proposal” approach, redefining the goal independently and validating it with a medical expert and student interviews.
- **Last Updated:** 2026-07-28

---

#### R02 — Unclear Project Goal / No Customer
- **Condition:** With no external customer, the project lacks a clearly defined goal that can justify decisions and satisfy course requirements.
- **Consequence:** Risk of scope drift, low team motivation, and difficulty in defending the project during assessments.
- **Likelihood:** High
- **Impact:** High
- **Owner:** Alina (PM), Denis (mentor)
- **Status:** Mitigated
- **Mitigation:** A new goal was defined: *“Create an iterative prototype that validates key hypotheses for a startup proposal.”* The goal is explicitly linked to the seven Practice Areas.
- **Last Updated:** 2026-07-28

---

#### R03 — Team Member Drops the Course
- **Condition:** A team member becomes unavailable (drops the course, illness, personal reasons) before the project is completed.
- **Consequence:** Loss of capacity; delays; increased workload for remaining members; potential failure to complete a hypothesis iteration.
- **Likelihood:** Medium
- **Impact:** High
- **Owner:** Alina (PM), All team members
- **Status:** Active
- **Mitigation:** Cross‑training on key roles; assigning backup owners for critical tasks; regular check‑ins to identify early signs of struggle.
- **Contingency:** Reduce project scope; reassign tasks; prioritise MVP features.
- **Last Updated:** 2026-07-28

---

#### R04 — Estimates Are Inaccurate
- **Condition:** Task estimates are consistently too optimistic; work takes longer than planned, especially when participant availability is uncertain.
- **Consequence:** Delayed delivery; inability to complete planned features; rushed work before the final presentation.
- **Likelihood:** Medium
- **Impact:** Medium
- **Owner:** Ilnar (Backend Developer)
- **Status:** Active
- **Mitigation:** Track actual vs. estimated time per task; adjust future estimates based on historical data; prioritise MVP features.
- **Contingency:** Cut non‑essential features; reduce scope for the final prototype.
- **Last Updated:** 2026-07-28

---

### LLM / Technical Risks

#### R05 — LLM Hallucinates Clinical Facts
- **Condition:** The LLM invents symptoms, findings, or diagnoses that contradict the gold‑standard case.
- **Consequence:** Students receive incorrect medical information, undermining the clinical training value of the simulation.
- **Likelihood:** High
- **Impact:** High
- **Owner:** Aizat (Backend Developer)
- **Status:** Active
- **Mitigation:** Case‑grounded prompts on every turn; diagnosis hidden until debrief; validation hooks on test results.
- **Contingency:** Retrieval over case JSON per turn; lower temperature; flagged sessions escalated to human review.
- **Trade‑off:** Fallback adds latency and infrastructure complexity — but better fidelity is worth it for safety‑critical content.
- **Last Updated:** 2026-07-28

---

#### R06 — LLM Provider Outage or Cost Spike
- **Condition:** The LLM provider experiences downtime or significantly increases its pricing.
- **Consequence:** All simulations are blocked mid‑session; project budget may be exceeded.
- **Likelihood:** Medium
- **Impact:** Medium
- **Owner:** Ilnar (Backend Developer)
- **Status:** Active
- **Mitigation:** Provider‑agnostic adapter; mock LLM mode keeps classroom demos running without external calls.
- **Contingency:** Secondary vendor on the same OpenAI‑compatible surface; cached responses per case node for drill mode.
- **Trade‑off:** Secondary vendor doubles integration testing; cached responses reduce pedagogical richness.
- **Last Updated:** 2026-07-28

---

#### R07 — LLM Leaks the Diagnosis
- **Condition:** The LLM accidentally reveals the correct diagnosis to the student before the debrief phase.
- **Consequence:** The simulation becomes invalid — the student no longer needs to think critically, and the H1 rubric session is compromised.
- **Likelihood:** Medium
- **Impact:** High
- **Owner:** Aizat (Backend Developer)
- **Status:** Active
- **Mitigation:** System prompt strictly forbids diagnosis disclosure; diagnosis stored separately in the gold standard and not passed to the LLM during conversation.
- **Contingency:** Post‑hoc analysis of logs to detect leaks; manual review of flagged sessions.
- **Last Updated:** 2026-07-28

---

## Traceability to Practice Areas

| Practice Area | Related Risks |
| :--- | :--- |
| Context & Requirements | R01, R02, R07 |
| Planning | R04, R07, R10 |
| Risk Management | All |
| Quality Assurance | R05, R07 |
| Stakeholder Communication | R08, R09 |
| Team & People | R03, R08 |

---

## Change Log

| Date | Version | Author | Changes Made |
| :--- | :--- | :--- | :--- |
| 2026-07-28 | 1.0 | Alina | Initial version after project pivot. Risks reformatted to condition → consequence with owners, likelihood, impact, and mitigation. |

---
