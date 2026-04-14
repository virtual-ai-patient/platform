---
layout: default
title: Sprint 04 Overview
parent: Sprints
has_children: true
nav_order: 1
---

# Meeting Overview

## Configuration Management Review — March 31, 2026

---

## 1. Key Feedback Summary

### The Core Issue
The team's configuration management documentation described **an ideal process** rather than **the actual process**. Mentors found it unclear because:

- It lacked specific details about **who changes requirements**, **when**, and **how**
- There was no clear connection between **triggers** (meetings, feedback) and **artifacts** (updated docs, new issues)
- The process description was **too generic** and could apply to any project

### What Mentors Want to See
- **Actual process** — describe what you *actually* do, even if imperfect
- **Clear triggers** — what causes a requirement to change?
- **Roles** — who initiates changes? who approves? who implements?
- **Artifact chain** — from trigger → action → updated document
- **Improvement plan** — after describing current process, explain how you plan to improve it

---

## 2. The Missing Pieces

### Requirements Management Flow

| What We Have | What We Need to Describe |
|:---|:---|
| Action points from meetings | **How** do action points become requirement changes? |
| New revisions of documents | **Who** creates the new revision? |
| Configuration management doc | **When** does this happen (sprint planning, weekly review)? |
| Changelog | **What** exactly changed? Why? |

### The Actual Process We Use (to document)

```
1. Thursday meeting with Denis → feedback received
2. Action points documented in meeting minutes
3. PM reviews action points for requirement impact
4. If requirements change → new revision of technical-product-description.md
5. Changelog updated with: date, author, what changed, why
6. Related issues updated in GitHub
7. Team notified during sprint planning
```

---

## 3. Strategic Planning — What's Wrong

### The Problem
Our roadmap looked like it could apply to **any project**:
- Milestone 1: Start project
- Milestone 2: Work on project
- Milestone 3: Finish project

### What Makes a Good Strategic Plan
A strategic plan should be **specific to our project**, based on:
- Our **unique constraints** (NDA stuck, no medical experts yet)
- Our **specific goals** (what does "success" mean for us?)
- Our **real timeline** (course ends July, started late)

### How to Fix It
Instead of generic milestones, define milestones based on **our actual situation**:

| Generic | Specific to Us |
|:---|:---|
| Set up repository | Set up monorepo with synthetic cases from ChatGPT (since no real data) |
| Add authentication | Implement JWT with role separation (learner vs educator) |
| Add chat | Build conversational engine with emotions, using mock LLM (waiting for tokens) |
| Add evaluation | Create debriefing system that will later be validated by medical experts |

---
