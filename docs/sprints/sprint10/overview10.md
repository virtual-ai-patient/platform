---
layout: default
title: Sprint 10 Overview
parent: Sprints
has_children: true
nav_order: 1
---

# Meeting Overview

## Mentor Meeting — June 23, 2026

### 1. Summary

The meeting covered three main topics: technical progress on session persistence, feedback from the medical expert, and preparation for the final presentation.

**Technical Progress:**
- **Session persistence** is fully implemented on both frontend and backend. Users can now interrupt and resume sessions at any point (history, test selections, partial diagnosis entries are all preserved).
- **Communication evaluation** (LLM assessment of doctor-patient dialogue) is being implemented by Timur — the frontend UI is ready, but the backend integration is still pending.

**Expert Feedback (from Alexander):**
The expert provided valuable insights:
- **Variability in tests:** The current system rigidly associates specific tests with cases. In reality, doctors may order tests that weren't pre-defined. The expert suggested making the test catalog more flexible and not giving hints to students.
- **Cost as a metric:** Adding a "price" parameter to each test could make the simulation more realistic, as ordering expensive tests unnecessarily would be penalized. This aligns with real-world constraints (e.g., insurance budgets in public healthcare).
- **Realism vs. complexity:** The expert noted that increasing variability and realism would significantly increase system complexity. The team needs to decide whether this is desirable for an academic project.

**Presentation Preparation:**
- The final presentation is scheduled for **June 30**.
- The team agreed to focus on **new information** (expert feedback, session persistence, communication evaluation) rather than re-presenting what was already shown in previous presentations.
- **Live demo** is a priority — but the team should prepare a recorded video as a backup in case of technical issues.
- **Practice Areas** must be covered in the presentation (mentors will grade based on them).

**Key Decisions:**
- Session persistence is complete ✅
- Communication evaluation UI is ready (backend integration pending)
- Expert meeting format will be online (Alina to coordinate timing)
- Presentation strategy: focus on new content, include live demo (with video backup), rehearse timing to avoid past issues
- Expert questions need to be reframed to focus on understanding the current system (how doctors are trained, what problems they face) rather than asking the expert to design the product for us.
