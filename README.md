# Virtual AI Patient — Monorepo

Welcome to the central repository for the **Virtual AI Patient** platform. This project is a high-fidelity medical simulation environment designed to bridge the gap between theoretical medical knowledge and clinical practice.

## Documentation & Traceability

Our source of truth, including **Quality Attributes (QA)**, **Architecture**, and **Meeting Retrospectives**, is hosted via GitHub Pages:

👉 **[View Official Project Documentation](https://virtual-ai-patient.github.io/platform)**

All changes to this repository must follow the [Configuration Management Policy](https://www.google.com/search?q=https://virtual-ai-patient.github.io/platform/cm/configuration-management) to ensure full traceability from code commits back to client requirements.

---

## Project Overview

**Virtual AI Patient** is a training platform where learners (medical students and junior doctors) navigate a full clinical workflow in a safe, risk-free environment.

### The Context

Medical education often lacks "safe-to-fail" interactive environments. Real-life clinical rotations are limited, and practicing on actual patients is high-risk. Our platform provides a dynamic alternative that mimics real-world diagnostic pressure.

### Problems We Solve

* **Knowledge Gap:** Transitions students from rote memorization to active diagnostic reasoning.
* **Subjective Feedback:** Provides an automated, deterministic evaluation against a medical "Gold Standard."
* **Resource Constraints:** Offers access to diverse clinical cases without needing standardized patient actors.

---

## Monorepo Structure

We use a monorepo approach to ensure atomic changes across the entire stack.

* `backend/` — **FastAPI** service handling session state, medical logic, and AI orchestration.
* `bot/` — **Telegram-bot** interface for mobile-first clinical simulations.
* `frontend/` — **Flutter** web client for an immersive, rich UI experience.
* `docs/` — **Jekyll**-based documentation, requirements, and sprint history.
* `data/` — Clinical case libraries and nosology schemas.


## Team Roles & Responsibilities

| Name | Role | Primary Focus & Artifact Ownership |
| --- | --- | --- |
| **Alina** | **Project Manager** | Sprint management, client liaison, and documentation hierarchy (`/docs/sprints`, `product_description.md`). |
| **Karim** | **Quality Assurance** | Quality Attributes revisions, traceability auditing, and acceptance criteria validation (`/docs/qa/qa-revN.md`). |
| **Ilnar** | **Backend Developer** | FastAPI services, AI orchestration, scoring logic, and database schemas (`/backend`, `/data`). |
| **Timur** | **Frontend Developer** | Flutter web client implementation, UI/UX consistency, and frontend-backend integration (`/frontend`). |
| **Aizat** | **Telegram Bot Dev** | Bot logic, Telegram API integration, and mobile-first simulation flow (`/bot`). |
