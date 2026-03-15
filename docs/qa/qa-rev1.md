---
layout: default
title: QA Revision 1
nav_order: 1
---

# Quality Attributes (QA) — Virtual AI Patient
**Document Version:** 1.0 (Revision 1)
**URL:** https://virtual-ai-patient.github.io/platform/qa/qa-rev1

## 1. Overview
This document defines the technical constraints, performance benchmarks, and security standards for the Virtual AI Patient platform. All implementation Tasks and Epics must satisfy the Acceptance Criteria (AC) derived from these Quality Attribute IDs.

## 2. Performance & Latency (QA-PERF)
* **QA-PERF-01:** Virtual patient chat responses must be generated and delivered in ≤ 3–5 seconds.
* **QA-PERF-02:** Medical test results generation must be completed in ≤ 2 seconds.
* **QA-PERF-03:** Automated evaluation and debriefing generation must be completed in ≤ 5 seconds.
* **QA-PERF-04:** Backend API 95th percentile (p95) latency must be ≤ 500ms.

## 3. Scalability & Availability (QA-SCALE)
* **QA-SCALE-01:** The platform must support concurrent cohorts of ≥ 500 active sessions initially, accommodating partner platform traffic spikes.
* **QA-SCALE-02:** The system architecture must support horizontal scaling for both the API layer and the AI interface module.
* **QA-SCALE-03:** The MVP must maintain an uptime of ≥ 99.5%.
* **QA-SCALE-04:** The system must implement graceful degradation if the external AI provider experiences high latency or failure.

## 4. Reliability & Data Integrity (QA-REL)
* **QA-REL-01:** The platform must guarantee zero loss of session state, learner submissions, scores, or analytics.
* **QA-REL-02:** The backend must implement robust retry mechanisms for all external AI calls.
* **QA-REL-03:** Evaluation scoring must be deterministic and independent of LLM randomness.

## 5. Security & Privacy (QA-SEC)
* **QA-SEC-01:** All data transit must be secured via HTTPS (TLS 1.2+).
* **QA-SEC-02:** The system must enforce Role-Based Access Control (RBAC) separating learners, educators, and admins.
* **QA-SEC-03:** Data at rest must be encrypted, and strict session isolation must be enforced.
* **QA-SEC-04:** No real patient personal data may be used in cases; PII storage must be minimized, with strict handling, deletion, or anonymization of user data.

## 6. AI Safety & Guardrails (QA-SAFE)
* **QA-SAFE-01:** AI responses must be strictly constrained to the simulation context.
* **QA-SAFE-02:** The AI must not provide real-world medical advice outside the case boundaries.
* **QA-SAFE-03:** The system must actively monitor and log unsafe AI outputs.
* **QA-SAFE-04:** Prompt and model versioning must be strictly maintained to ensure consistency.

## 7. Architecture & Observability (QA-ARCH)
* **QA-ARCH-01:** The AI provider adapter must be pluggable to allow swapping models without core redesign.
* **QA-ARCH-02:** The system must be fully containerized with environment-based configurations (dev/stage/prod) and be CI/CD-ready.
* **QA-ARCH-03:** The platform must implement structured logs, distributed traces, and AI latency metrics for debugging and auditing.
* **QA-ARCH-04:** A full trace of learner actions (questions asked, tests ordered, diagnoses submitted) must be captured for exportable analytics.

---

## Changelog
| Date | Revision | Author | Trigger / Source | Changes Made |
| :--- | :--- | :--- | :--- | :--- |
| 03-03-2026 | 1.0 | Karim Abdulkin | Initial Project Setup | Extracted non-functional requirements from `product_description.md` (Section 4) to establish baseline QA metrics and assigned unique IDs. |
