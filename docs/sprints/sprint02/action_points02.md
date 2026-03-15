---
layout: default
title: Sprint 02 Action Points
section: sprints
parent: Sprint 02
---

# Action Points

* **ID:** AP-0001
* **Action:** Clarify the existence and responsibilities of the "Reviewer" (attending physician) role with the customer (Ilya). Determine if this is a separate role from "Admin" and what their specific permissions and dashboard needs are (e.g., viewing intern reports, assigning cases).
* **Owner:** Product Manager (Alina)
* **Downstream Impact:** FastAPI (RBAC), Flutter (Educator/Reviewer UI), Database (User roles schema)
* **Requirement Reference:** **QA-SEC-02** (The system must enforce Role-Based Access Control (RBAC) separating learners, educators, and admins.)

---

* **ID:** AP-0002
* **Action:** Research and document real-world medical data terminology and structure (e.g., how patient visits, medical history, and test orders are recorded in a hospital). Apply this Domain-Driven Design knowledge to rename and refine the current database schema entities to match medical practice.
* **Owner:** Backend Developer (Ilnar)
* **Downstream Impact:** FastAPI (Data models), Database (Schema design), Documentation (Data dictionary)
* **Requirement Reference:** **QA-ARCH-04** (A full trace of learner actions... must be captured for exportable analytics.) - A correct domain model is the foundation for accurate analytics.

---

* **ID:** AP-0003
* **Action:** Redesign the main workspace UI mockup to integrate the chat, lab test ordering, and test results viewing into a cohesive layout (e.g., using a tabbed interface or a panel system). Prepare this updated design to present to the customer for feedback.
* **Owner:** Frontend Developer (Timur)
* **Downstream Impact:** Flutter (Main case session UI)
* **Requirement Reference:** **QA-PERF-01**, **QA-PERF-02** (UI design must not impede the system's ability to meet the 2-5 second response time targets for chats and test results.)

---

* **ID:** AP-0004
* **Action:** Begin development of a functional end-to-end prototype. This prototype should include a basic case, a simple chat interface, and the ability to select a lab test and receive a predefined result. Use synthetic data (e.g., from ChatGPT) to populate the case.
* **Owner:** Backend Developer, Frontend Developer, Bot Developer
* **Downstream Impact:** FastAPI, Flutter, Bot, AI (initial prompt setup)
* **Requirement Reference:** **QA-SAFE-04** (Prompt and model versioning must be strictly maintained to ensure consistency.) - Applies even to synthetic test prompts.

---

* **ID:** AP-0005
* **Action:** Create a detailed project roadmap extending to August 2026. The roadmap must incorporate key academic deadlines (exams, holidays) and define major milestones (e.g., prototype completion, feature freeze, testing phase).
* **Owner:** Product Manager (Alina)
* **Downstream Impact:** Project Management (Documentation)
* **Requirement Reference:** **QA-SCALE-03** (The MVP must maintain an uptime of ≥ 99.5%.) and **QA-ARCH-02** (The system must be fully containerized... and be CI/CD-ready.) - The roadmap must allocate time for the infrastructure work needed to meet these.
