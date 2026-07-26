---
layout: default
title: QA Revision 3
parent: QA
grand_parent: Current — Startup Proposal
nav_order: 3
---

# Quality Attributes (QA) — Virtual AI Patient
**Document Version:** 3.0 (Revision 3)
**URL:** [Here](https://virtual-ai-patient.github.io/platform/qa/qa-rev3)

> **[RETROSPECTIVE — Written July 2026]** This revision was written as part of the startup proposal preparation. It describes the quality attributes as they *should have been* defined at the time of the pivot in March 2026. In practice these constraints were not formally documented from day one of the pivot. See [About the Pivot](../about-the-pivot.md).

## 1. Overview

This revision reflects the project pivot from delivering a production product to an industry partner to producing a **validated startup proposal** backed by a working prototype. The change in goal narrows what "quality" means: we are no longer building for 300+ concurrent hospital users; we are building for expert review, hypothesis testing, and investor pitch.

Requirements that only make sense at production scale (QA-SCALE, heavy security stack) are suspended. Requirements that ensure the prototype is reproducible, explainable, and independently verifiable are promoted.

## 2. Performance & Latency (QA-PERF)

* **QA-PERF-01:** Virtual patient chat responses must be delivered in ≤ 2 seconds to maintain simulation immersion during live demonstrations and expert evaluation sessions.
* **QA-PERF-02:** Medical test results must be returned in ≤ 2 seconds.
* **QA-PERF-03:** Debrief generation must complete in ≤ 5 seconds.

*QA-PERF-04 (p95 API latency) suspended — relevant only under load; prototype is single-session.*

## 3. Reliability & Data Integrity (QA-REL)

* **QA-REL-01:** Zero loss of session state, learner submissions, or scoring data within a session.

*QA-REL-02 (retry mechanisms) and QA-SCALE suspended — prototype targets ≤ 10 simultaneous users.*

## 4. AI Safety & Guardrails (QA-SAFE)

* **QA-SAFE-01:** Prompt injection protection — input validation must prevent the user from escaping the simulation context or extracting the system prompt.
* **QA-SAFE-02:** AI responses must not provide real-world medical advice; all output must be grounded in case data.
* **QA-SAFE-03:** Unsafe inputs and outputs must be logged for review.

## 5. Architecture & Observability (QA-ARCH)

* **QA-ARCH-01:** The AI adapter must be pluggable — swapping the LLM provider must require no changes outside the adapter layer.
* **QA-ARCH-02:** All learner actions (messages sent, tests ordered, submissions made) must be captured in structured logs, exportable for analytics.

## 6. Reproducibility (QA-REPRO)

*New in Rev 3. Expert reviewers and team members must be able to run the prototype from zero prior state.*

* **QA-REPRO-01:** `docker compose up` must bring up the full stack (backend, database, mock LLM) in one command with no manual configuration steps.
* **QA-REPRO-02:** A seed script must populate at least one complete case so the prototype can be demonstrated immediately after startup.
* **QA-REPRO-03:** A mock LLM must be available as a drop-in so the prototype runs without an external API key.

## 7. Documentation (QA-DOC)

*New in Rev 3. Reviewers and investors must be able to understand design decisions without asking the team.*

* **QA-DOC-01:** The repository README must include a quickstart section that gets a reviewer from `git clone` to a running prototype in under 10 minutes.
* **QA-DOC-02:** Each significant architectural decision must be recorded as an Architecture Decision Record (ADR).

---

## Changelog

| Date | Revision | Author | Trigger / Source | Changes Made |
| :--- | :--- | :--- | :--- | :--- |
| 10-03-2026 | 3.0 | Karim Abdulkin | Project pivot — industry partner engagement ended; new goal: startup proposal | Suspended QA-SCALE and heavy security stack. Slimmed QA-PERF to 3 criteria. Added QA-REPRO (docker, mock LLM, seed) and QA-DOC (README quickstart, ADRs). |
| 15-03-2026 | 2.0 | Karim Abdulkin | Sprint 03 Overview | Reduced chat latency; anchored scalability to hospital/university use cases; risk/mitigation security matrix. |
| 03-03-2026 | 1.0 | Karim Abdulkin | Initial project setup | Extracted from `product_description.md`. |
