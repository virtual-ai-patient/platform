---
layout: default
title: Sprint 06 Overview
parent: Sprints
has_children: true
nav_order: 1
---

# Meeting Overview

## Mentor Meeting — April 17, 2026

---

### 1. Summary

The team demonstrated two major achievements:

1. **LLM Research (Aizat)** – A systematic comparison of three models (GPT‑4, two open‑source models with 70B and 8B parameters) using a structured prompt and a predefined dialogue. The research was documented in a Jupyter notebook. All models performed well; the main difference was cost per dialogue. The mentor was satisfied with the research artifact.

2. **Frontend + Backend Integration (Ilnar & Timur)** – A working demo running via `docker-compose` showing:
   - Case library with 5 pre‑loaded cases
   - User login (learner role)
   - Case start screen with meta‑information
   - Chat UI (ready but not yet connected to LLM)
   - Patient summary and notes stubs (partially implemented)

The mentor acknowledged visible progress.

**Next priorities:**
- Connect the LLM to the backend so the chat actually works.
- Split the “conversational engine” tasks into basic chat (for MVP) and advanced features (emotion, tone, guardrails) – the latter can be postponed.
- Create explicit GitHub issues for LLM integration and assign owners.
- Start preparing the final presentation (due May 12, ~3 weeks left).
- Consider meeting with real doctors after LLM is integrated, to collect feedback for future iterations.

The mentor also reminded the team to use Pull Requests for visibility and to create a task board (“etazhny bort”) to track who is doing what.

---

### 2. Key Decisions

| Decision | Rationale |
|:---|:---|
| **Prioritise basic LLM integration** – get a working chat by next week. | MVP needs a demonstrable conversation; emotions and tone can come later. |
| **Postpone real‑time guardrails** – only log conversations for offline analysis. | Reduces complexity for the MVP; logs can be analysed later to improve prompts. |
| **Do not meet doctors before LLM is integrated** – first get a working prototype, then collect medical feedback. | The team will have something concrete to show and discuss. |
| **Start presentation early** – allocate time for iterative improvements. | Only 3 weeks remain until the final presentation (May 12). |

---
