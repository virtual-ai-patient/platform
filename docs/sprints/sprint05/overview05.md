---
layout: default
title: Sprint 05 Overview
parent: Sprints
has_children: true
nav_order: 1
---

# Meeting Overview

## Mentor Meeting — April 2, 2026

---

## 1. Project Status Summary

### Current Progress
- **Backend:** Authentication endpoints completed, tests written, pull requests merged
- **Frontend:** Authentication UI implemented, other pages in progress
- **Testing:** Test suite growing with unit and integration tests using SQLite as mock database
- **Architecture:** Modular design with service-repository pattern, business logic isolated from database implementation

### Demo Available
- The team can run `docker-compose up` to start the entire stack
- Backend is accessible, frontend shows authentication flows
- Mentor can try the working prototype themselves

---

## 2. Key Decisions Made

### Telegram Bot — Postponed ❌
**Decision:** The team has decided to **pause Telegram bot development** and reallocate those resources to the web frontend.

**Rationale:**
- Having a working web frontend is more critical for demonstrations
- Limited team capacity (5 people across backend, frontend, testing, management)
- Better to have one fully working interface than two half-finished ones

**Action:** Frontend development becomes the priority for user-facing work.

---

## 3. Critical Discussion: AI Context & Diagnosis

### The Problem
The mentor raised a **significant architectural concern** about how the AI patient is being designed.

**Current approach (problematic):**
- Giving the LLM the actual diagnosis in the system prompt
- Letting the LLM "interpret" how the disease presents based on its training data

**Why this is risky:**
1. **LLMs hallucinate** — they may invent symptoms or treatments not in the case (e.g., "drinking salty lemonade" for a disease)
2. **LLMs have no concept of time** — they cannot accurately simulate durations or progression
3. **Real patients don't know their diagnosis** — giving the AI the diagnosis breaks realism
4. **Inconsistent behavior** — different LLM versions or providers may interpret the same disease differently

### The Recommended Approach

| What the AI Should Know | What the AI Should NOT Know |
|:---|:---|
| Patient persona (age, occupation, lifestyle) | The actual medical diagnosis |
| Symptoms from the case description | Which symptoms are "correct" vs "incorrect" |
| How the patient feels (pain, fatigue, etc.) | The gold standard treatment plan |
| Basic patient history (as defined in case) | Any clinical reasoning |

**Principle:** The AI simulates a **patient who doesn't know their own diagnosis**. It only knows what it feels and experiences. The learner (doctor) must figure out the diagnosis through questioning.

---

## 4. Case Structure Requirements

### What Needs to Be Defined

The team must **research and document** what a clinical case contains:

| Component | Description | Who Defines |
|:---|:---|:---|
| **Patient Persona** | Age, gender, occupation, lifestyle | Team + Medical experts |
| **Symptoms** | What the patient feels (pain location, severity, timing) | Team + Medical experts |
| **History of Present Illness** | How symptoms developed over time | Team + Medical experts |
| **Relevant Medical History** | Past conditions, medications, allergies | Team + Medical experts |
| **Gold Standard** | Correct diagnosis, expected findings, treatment plan (hidden from AI) | Team + Medical experts |
| **Evaluation Criteria** | What counts as correct vs incorrect diagnosis | Team + Medical experts |

### Storage Approach
- Cases should be stored as structured data (JSON/YAML)
- The AI receives only the "patient-facing" information (persona + symptoms)
- The gold standard is stored separately for evaluation

---

## 5. AI Evaluation Strategy

### Proposed Workflow (No Money Spent Yet)

1. **Create synthetic cases** manually or with ChatGPT help
2. **Store cases as JSON** with patient-facing information only
3. **Build an evaluation harness** to test LLM responses:
   - Ask predefined questions
   - Check if answers match expected symptoms
   - Measure consistency across sessions
4. **Iterate on prompts** based on evaluation results
5. **Present findings to Denis/Mansur** with evidence
6. **Request API keys only after** proving the approach works

### Why This Approach
- Proves the concept without spending money
- Creates reusable test infrastructure
- Provides data to justify API key requests
- Demonstrates proactive problem-solving to mentors

---

## 6. Team Process Improvements

### What's Working ✅
- Weekly meetings with mentor established
- Team syncs before mentor sessions (e.g., Sunday meeting between Karim and Alina)
- GitHub Issues with sub-issues (User Stories → Tasks)
- Pull requests linked to issues with "Closes #XXX"
- CI/CD with Ruff, MyPy, and pre-commit hooks
- Tests using SQLite as mock database (business logic doesn't know it's being tested)

### What Needs Improvement 🔧
- Need **visible demo** for next presentation (mentors couldn't assess technical progress)
- Need **clickable links** in presentations (mentors won't search)
- Need **case structure documented** before implementing
- Need **eval framework** to test LLM behavior

This is a **fundamental architectural decision** that affects the entire project. Make sure the team understands and implements this correctly.
