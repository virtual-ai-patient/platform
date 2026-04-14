---
layout: default
title: Sprint 06 Action Points
section: sprints
parent: Sprint 06 Overview
---


# Sprint 6 AP

## 1. Sprint Action Points

### AP-001: Produce LLM Experiment Artifact (Jupyter Notebook)
- **Owner:** Aizat
- **What:** Create a Jupyter notebook (or similar) that:
  - Loads a clinical case (from the team’s JSON structure)
  - Sends a series of predefined questions to an LLM (DeepSeek free API, local model, or any accessible model)
  - Records the model’s responses
  - Compares responses against expected answers (from gold standard)
  - Includes commentary on what works, what doesn’t, and why the chosen model/prompt is acceptable.
- **Due:** April 19, 2026
- **Output:** `.ipynb` file committed to `docs/research/` or a separate branch.

### AP-002: Demonstrate a Working Conversation
- **Owner:** Aizat, Ilnar
- **What:** Show a simple interactive conversation (could be CLI script or basic web UI) where a user can ask questions and the LLM responds based on the case context. This does not require full backend integration – a standalone script is acceptable.
- **Due:** April 19, 2026
- **Output:** Screen recording or live demo during next mentor meeting.

### AP-003: Define Evaluation Criteria for LLM Responses
- **Owner:** Alina, Aizat
- **What:** Write a short document (1-2 pages) specifying:
  - What “correct” vs “incorrect” response means for a given case.
  - How the team will measure LLM performance (e.g., accuracy on expected symptoms, handling of out-of-scope questions).
  - A simple scoring rubric (e.g., pass/fail per question).
- **Due:** April 19, 2026
- **Output:** Markdown file in `docs/ai-evaluation.md`.

### AP-004: Finalize Case JSON Schema and Document It
- **Owner:** Ilnar, Alina
- **What:** Based on the mentor’s feedback and research, finalize the JSON schema for clinical cases. Ensure it separates “patient view” (visible to LLM) from “gold standard” (used for evaluation). Add documentation to `docs/case-schema.md`.
- **Due:** April 16, 2026

### AP-005: Implement Chat UI Contract Without Waiting for Backend
- **Owner:** Timur
- **What:** Even though the backend chat endpoints are not ready, implement the frontend chat UI component with **mock data** or a placeholder service. This will demonstrate the UI flow and allow the team to define the required API contract (fields, endpoints).
- **Due:** April 16, 2026

### AP-006: Adopt Pull Request Workflow for All Changes
- **Owner:** All team members
- **What:** For any code change (including documentation, research notebooks), create a branch and open a Pull Request. Do not push directly to `main`. Use PR descriptions to explain what was done and link to related issues.
- **Due:** Immediately (ongoing)

### AP-007: Prepare Russian Language Test
- **Owner:** Aizat
- **What:** After the basic conversation works in English, run the same prompts in Russian. Document any differences in response quality (e.g., hallucinations, refusal to answer). Update the research artifact accordingly.
- **Due:** April 23, 2026

### AP-008: Request API Key (Conditional)
- **Owner:** Alina
- **Trigger:** Once AP-001 and AP-002 are completed and shown to the mentor, the mentor will provide an API key (or proxy endpoint) for production integration.
- **What to prepare:** Link to the notebook, a short summary of findings, and a demo recording.

---

## 2. Critical Priorities (Next Week)

| Priority | Task | Owner |
|:---|:---|:---|
| **P0** | Produce Jupyter notebook with LLM experiments | Aizat |
| **P0** | Show a working conversation (any form) | Aizat, Ilnar |
| **P1** | Finalize case JSON schema | Ilnar, Alina |
| **P1** | Implement chat UI with mock data | Timur |
| **P2** | Define LLM evaluation criteria | Alina, Aizat |
| **P2** | Switch to PR-based workflow | All |

---

## 3. Summary for the Team

> **The mentor’s message is clear:**
> *“I don’t see any working conversational engine yet. You say you have experimented, but without an artifact, it doesn’t count. Show me a notebook, show me a conversation – even with a free model – and I will give you the API key. Also, open Pull Requests so everyone can see who is doing what.”*

**Next mentor meeting expected in one week (April 19).** By then, the team must deliver:
- A Jupyter notebook with LLM experiments.
- A visible conversation demo (script or UI).
- Updated case schema documentation.
- At least one open PR showing active work.
