---
layout: default
title: Sprint 07 Action Points
section: sprints
parent: Sprint 07 Overview
---

# Sprint 7 AP

## Action Points

### AP-001: Create GitHub Issues for LLM Integration
- **Owner:** PM
- **What:** Break down the work into at least two issues:
  - Backend: endpoint to call LLM with case context (Ilnar)
  - Frontend: connect chat UI to backend (Timur)
- **Output:** Issues with clear acceptance criteria, assigned owners, and labels (`EPIC-03`, `priority: critical`).

### AP-002: Integrate LLM into Backend (Basic Chat)
- **Owner:** Ilnar (backend), Aizat (LLM research support)
- **What:** Implement the backend service that:
  - Loads the case context (patient persona, symptoms, history)
  - Sends the context + user message to the chosen LLM (via OpenRouter or a free alternative)
  - Returns the LLM response to the frontend.
- **Due:** April 23, 2026 (next mentor meeting)
- **Output:** Working chat end‑to‑end (backend + frontend) that can be demonstrated.

### AP-003: Update Frontend to Use Real LLM Responses
- **Owner:** Timur
- **What:** Replace the current placeholder chat with actual API calls to the new backend endpoint. Ensure proper loading states and error handling.
- **Due:** April 23, 2026
- **Output:** The frontend chat displays meaningful responses from the LLM.

### AP-004: Create a Task Board (Visibility Dashboard)
- **Owner:** Alina
- **What:** Set up a GitHub Project board (or similar) that clearly shows:
  - Who is working on what task
  - Status of each task (To Do, In Progress, Review, Done)
  - Link to related issues and PRs.
- **Due:** April 23, 2026
- **Output:** A link to the board shared with the mentor.

### AP-005: Start Drafting the Final Presentation
- **Owner:** Alina & Karim
- **What:** Create a presentation skeleton that covers all **Practice Areas** (as recommended by the mentor). Include slides for:
  - Project overview
  - Research (LLM comparison)
  - Architecture and integration
  - Demo (working chat + case library)
  - Next steps and lessons learned
- **Due:** April 23, 2026 (first draft ready for review)
- **Output:** A draft presentation shared with the mentor for feedback.

### AP-006: (Optional) Explore Free LLM API Options
- **Owner:** Aizat
- **What:** Investigate free‑tier alternatives (e.g., Cohere, Groq, or other services offering 1k+ free requests/day) in case the mentor’s key is delayed. Document the best option.
- **Due:** April 23, 2026
- **Output:** Short note in the team channel with recommendation.

### AP-007: Log Conversations for Future Analysis
- **Owner:** Ilnar
- **What:** Ensure every chat message (user prompt + LLM response) is stored in the database, linked to the session. This will later enable offline evaluation and guardrail development.
- **Due:** April 23, 2026 (can be done in parallel with AP-002)
- **Output:** Database schema extension + logging code.

### AP-008: Prepare for Doctor Meeting (Post‑LLM)
- **Owner:** Team
- **What:** After LLM is integrated, prepare a short questionnaire and a set of example dialogues to show to real doctors (via Mansur’s contacts). Focus on medical accuracy and realism of the patient’s answers.
- **Due:** May 5, 2026 (tentative, depending on LLM integration success)
- **Output:** A document with questions and a demo plan.

### The mentor emphasised that even if not all features are ready, a working chat + case library + clear process documentation will make a strong impression
---
