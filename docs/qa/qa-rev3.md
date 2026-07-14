---
layout: default
title: QA Revision 3
parent: QA
nav_order: 3
---

# Quality Attributes (QA) — Virtual AI Patient
**Document Version:** 3.0 (Revision 3)
**URL:** [Here](https://virtual-ai-patient.github.io/platform/qa/qa-rev3)

## 1. Overview
Revision 3 re-baselines the quality attributes against the project's new goal:
build a **documented working prototype** and hand it over to Innopolis
University so they can explore integration paths with medical
institutions. There is no external customer and no clinical deployment.
Requirements that made sense under a commercial
target are dropped in favour of two new
categories that reflect what actually matters for a handoff:
**Reproducibility (QA-REPRO)** and **Documentation (QA-DOC)**.

## 2. Performance & Latency (QA-PERF)
* **QA-PERF-01:** Virtual patient chat responses must be delivered in **≤ 2 seconds** during a demo run. This preserves the "human-feel" of the conversation.
* **QA-PERF-02:** Medical test results generation must be completed in ≤ 2 seconds.
* **QA-PERF-03:** Automated evaluation and debriefing generation must be completed in ≤ 5 seconds.

## 3. Reliability & Data Integrity (QA-REL)
* **QA-REL-01:** A learner's session survives backend or client restarts within a demo run — the resume flow rehydrates chat, ordered tests, and current conclusions from the server-side action log.
* **QA-REL-02:** Deterministic evaluation: scoring calls run at `temperature=0` against a versioned rubric prompt, so re-running the judge over the same transcript yields the same result.

## 4. Security & Privacy (QA-SEC)
Scope is now "prototype hygiene", not compliance.

| ID | Requirement |
| :--- | :--- |
| **QA-SEC-01** | Authentication with role-based access (`learner`, `educator`, `admin`) is present so that UI reviewers can see the RBAC concept demonstrated end-to-end. |
| **QA-SEC-02** | No secrets in the repository. LLM API keys, database URLs, and any provider credentials are read from environment variables (`.env` locally, injected at deploy time otherwise). |

*Dropped from rev2:* Case IP protection, log anonymization for analytics, and the TLS 1.2+ mandate. These belong to the commercial-deployment scope and are explicitly out of scope for the prototype.

## 5. AI Safety & Guardrails (QA-SAFE)
* **QA-SAFE-01:** The AI patient must not emit real-world medical advice — responses are grounded to the case data and constrained by the system prompt.
* **QA-SAFE-02:** Basic prompt-injection resistance: the model must not reveal the system prompt, break character, or leave the simulation context when a learner attempts to jailbreak it.

*Dropped from rev2:* active monitoring and administrative review of unsafe events — there is no ops team behind the prototype.

## 6. Reproducibility (QA-REPRO) *(new)*
This category replaces the rev2 Scalability & Availability section. What matters for a handoff is that any reviewer at UI can bring the prototype up on their own laptop.

* **QA-REPRO-01:** `docker compose up` from a fresh clone brings up the full stack (backend + Postgres + Flutter web build) and lands on a working demo page.
* **QA-REPRO-02:** A **Mock LLM provider** is available so the demo runs end-to-end without a paid API key. Switching to a real provider is a single environment variable.
* **QA-REPRO-03:** A **seed script** populates the case catalog with 3–5 demo cases on first startup so reviewers see meaningful content immediately.
* **QA-REPRO-04:** The prototype is expected to serve **1–5 concurrent demo sessions** on a single machine. Load testing and horizontal scaling are explicitly out of scope.

## 7. Documentation Handoff (QA-DOC) *(new)*
Documentation is now a first-class deliverable — UI receives the repository and the docs together and should not need to talk to the team to make sense of either.

* **QA-DOC-01:** The root `README.md` gets a reviewer from a fresh clone to a running demo in **≤ 10 minutes**, using the mock LLM path.
* **QA-DOC-02:** Every backend module (`backend/<name>/`) has a short purpose statement — either in the package `__init__.py` docstring or in `docs/modules/`.
* **QA-DOC-03:** `docs/architecture/` contains the current system diagrams and a short Architecture Decision Record (ADR-style note) for each significant choice: Flutter for the client, FastAPI for the backend, the pluggable AI-provider abstraction, and single-node Postgres for storage.
* **QA-DOC-04:** An explicit **"What UI receives"** section in `docs/architecture/system-architecture.md` names what is delivered, what is deliberately out of scope, and the open questions that would need to be answered before any real integration.

## 8. Architecture & Observability (QA-ARCH)
* **QA-ARCH-01:** Pluggable AI adapters — all LLM interactions go through a single `AIProvider` interface so UI (or whoever inherits the code) can swap the model, including for a locally hosted one, without touching the domain logic.
* **QA-ARCH-02:** Structured logging of learner actions to `action_logs` — traceable enough for a reviewer to replay a demo session end to end. This replaces the rev2 "medical auditing" framing.

---

## Changelog

| Date | Revision | Author | Trigger / Source | Changes Made |
| :--- | :--- | :--- | :--- | :--- |
| 14-07-2026 | 3.0 | Karim Abdulkin | Project goal change: customer engagement ended; new goal is a documented prototype handed to Innopolis University. | 1. Removed Scalability & Availability (QA-SCALE) — no live users, no SLA. 2. Collapsed Security to prototype hygiene; dropped case-IP, log anonymization, TLS mandate. 3. Trimmed AI Safety to two demo-relevant requirements. 4. Added QA-REPRO (docker compose, mock LLM, seed data) as the new "runs anywhere" category. 5. Added QA-DOC as a first-class handoff category. 6. Reframed QA-ARCH-02 from "medical auditing" to "traceable demo runs". |
| 15-03-2026 | 2.0 | Karim Abdulkin | [Sprint 03 Overview](/sprints/sprint03/Meeting-Summary) | 1. Reduced chat latency target to 1-2s for "Human Feel". 2. Anchored scalability to Hospital/University use cases. 3. Shifted to "Working Hours" availability (99.5% Mon-Fri). 4. Redesigned Security section using a Risk/Mitigation matrix. |
| 12-03-2026 | 1.0 | Karim Abdulkin | Initial Baseline | Extracted from `product_description.md`. |
