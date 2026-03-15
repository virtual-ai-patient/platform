---
layout: default
title: QA Revision 2
parent: QA
nav_order: 2
---

# Quality Attributes (QA) — Virtual AI Patient
**Document Version:** 2.0 (Revision 2)
**URL:** https://virtual-ai-patient.github.io/platform/qa/qa-rev2

## 1. Overview
This document defines the technical constraints and performance benchmarks for the platform. Revision 2 introduces "Real-World Context" anchors for scalability and availability, and a threat-focused security model.

## 2. Performance & Latency (QA-PERF)
* **QA-PERF-01:** **[UPDATED]** Virtual patient chat responses must be delivered in **≤ 1–2 seconds**. This "Instantaneous" threshold is required to maintain the immersion of a real human conversation.
* **QA-PER-02:** Medical test results generation must be completed in ≤ 2 seconds.
* **QA-PERF-03:** Automated evaluation and debriefing generation must be completed in ≤ 5 seconds.
* **QA-PERF-04:** Backend API 95th percentile (p95) latency must be ≤ 500ms.

## 3. Scalability & Availability (QA-SCALE)
* **QA-SCALE-01:** **[UPDATED]** The platform must handle concurrent loads based on real-world anchors:
* **Hospital Use Case:** 50–200 concurrent users during peak hospital training hours.
* **University Use Case:** Support for a full medical school cohort (e.g., 300+ students) during synchronous exam windows.
* **QA-SCALE-02:** Load testing (via Locust) must simulate these specific scenarios rather than arbitrary traffic.
* **QA-SCALE-03:** **[UPDATED]** **Working Hours Availability:** The system must maintain **≥ 99.5% uptime during Mon–Fri, 09:00 – 21:00**. 
* **QA-SCALE-04:** Maintenance and updates are restricted to weekend windows to avoid disrupting clinical training schedules.

## 4. Reliability & Data Integrity (QA-REL)
* **QA-REL-01:** Zero loss of session state, learner submissions, or scoring data.
* **QA-REL-02:** Deterministic evaluation: Scoring must remain consistent regardless of LLM temperature or randomness.

## 5. Security & Privacy (QA-SEC)
*Requirements in this section are structured by **Risk → Mitigation**.*

| ID | Risk Scenario | Mitigation Strategy |
| :--- | :--- | :--- |
| **QA-SEC-01** | **Case IP Leakage:** Theft of valuable clinical scenarios. | Strict RBAC for authoring tools; Case data encrypted at rest and stored in isolated libraries. |
| **QA-SEC-02** | **Conversation Privacy:** Leakage of intern diagnostic reasoning logs. | Mandatory anonymization of chat logs for analytics; Strict TTL (Time-to-Live) and deletion policies for raw logs. |
| **QA-SEC-03** | **Unauthorized Access:** Students modifying scores or accessing educator views. | Enforced RBAC (Learner vs. Educator vs. Admin) with regular permission audits. |
| **QA-SEC-04** | **Data in Transit:** Interception of session data. | Mandatory HTTPS (TLS 1.2+). |

## 6. AI Safety & Guardrails (QA-SAFE)
* **QA-SAFE-01:** **[UPDATED]** **Prompt Injection Protection:** The system must implement robust input validation to prevent users from forcing the LLM to leave the simulation context or reveal system prompts.
* **QA-SAFE-02:** AI must not provide real-world medical advice; responses are strictly bound to the case data.
* **QA-SAFE-03:** Active logging and monitoring for unsafe inputs/outputs to trigger immediate administrative review.

## 7. Architecture & Observability (QA-ARCH)
* **QA-ARCH-01:** Pluggable AI adapters to prevent vendor lock-in and allow for model upgrades (e.g., GPT-4 to GPT-5 or local LLMs).
* **QA-ARCH-02:** Structured logging of all learner actions for exportable analytics and medical auditing.

---

## Changelog

| Date | Revision | Author | Trigger / Source | Changes Made |
| :--- | :--- | :--- | :--- | :--- |
| 15-03-2026 | 2.0 | Karim Abdulkin | [Sprint 03 Overview](/sprints/sprint03/Meeting-Summary) | 1. Reduced chat latency target to 1-2s for "Human Feel".<br>2. Anchored scalability to Hospital/University use cases.<br>3. Shifted to "Working Hours" availability (99.5% Mon-Fri).<br>4. Redesigned Security section using a Risk/Mitigation matrix. |
| 12-03-2026 | 1.0 | Karim Abdulkin | Initial Baseline | Extracted from `product_description.md`. |
