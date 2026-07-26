---
layout: default
title: Tactical Planning — Rev 1 (Historical)
parent: Tactical Planning
grand_parent: Current — Startup Proposal
nav_order: 1
---

# Tactical Planning — Rev 1 (Historical)

> **[HISTORICAL — Pre-pivot, March 2026]**
> This document describes the tactical process used when the project goal was to deliver a product to an industry partner (Third Opinion). It is preserved for reference. The active revision is [tactical-planning-rev2.md](tactical-planning-rev2.md).

---

# Tactical Planning — Virtual AI Patient

## Weekly Iteration Cycle for Our Project

---

## 1. What is Tactical Planning?

Tactical planning is our **short-term, execution-focused process** that translates strategic goals into **concrete weekly tasks**. It answers:

- **What** are we doing this week?
- **Who** is doing it?
- **How** do we incorporate feedback?
- **When** do we adjust course?

For our project, tactical planning operates on a **weekly cycle** centered around Thursday feedback sessions with Denis.

---

## 2. Our Weekly Tactical Rhythm

| Day | Activity | Duration | Purpose |
|:---|:---|:---|:---|
| **Thursday** | Feedback Session with Denis | 30–60 min | Get course corrections, prioritize next steps |
| **Friday** | Sprint Review + Retrospective | 45–60 min | Review completed work, identify improvements |
| **Monday** | Sprint Planning | 30–45 min | Plan tasks based on feedback |
| **Tuesday–Wednesday** | Execution | 2 days | Complete assigned tasks |
| **Thursday** | (repeat) | — | Present progress, get new feedback |

---

## 3. The Weekly Iteration Loop

```text

┌─────────────────────────── ──────────────────────────────┐
│                                                          │
│    [Thursday]                                            │
│    Denis Feedback Session                                │
│    • Demo current work                                   │
│    • Receive feedback on what to change                  │
│    • Get priorities for next presentation                │
│    • Document action items                               │
│            ↓                                             │
│    [Friday]                                              │
│    Sprint Review + Retrospective                         │
│    • Review what was completed this week                 │
│    • Document action items                               │
│            ↓                                             │
│    [Monday]                                              │
│    Sprint Planning                                       │
│    • Create Issues from Denis's feedback                 │
│    • Prioritize tasks for the week                       │
│    • Assign owners                                       │
│    • Set acceptance criteria                             │
│            ↓                                             │
│    [Tuesday–Wednesday]                                   │
│    Execution                                             │
│    • Work on assigned tasks                              │
│    • Daily standups                                      │
│    • Update GitHub Issues                                │
│            ↓                                             │
│    [Thursday] (repeat)                                   │
│                                                          │
└─────────────────────────── ──────────────────────────────┘
```

---

## 4. Detailed Breakdown of Each Phase

### 4.1 Thursday — Feedback Session with Denis

**When:** Every Thursday

**Who Attends:** Entire team

**Agenda:**

| Time | Activity |
|:---|:---|
| 5 min | Quick recap of what we did this week |
| 20 min | Demo current work (UI, functionality, progress) |
| 20 min | Denis provides feedback |
| 10 min | Q&A and clarification |
| 5 min | Document action items |

**Types of Feedback Denis Might Give:**

| Feedback Type | Example | How We Capture |
|:---|:---|:---|
| **Change to existing work** | "The chat UI needs emotion indicators" | Create GitHub Issue |
| **New priority** | "Focus on evaluation engine next" | Reprioritize backlog |
| **Course correction** | "Don't spend more time on X, switch to Y" | Update sprint plan |
| **Presentation prep** | "For the next demo, show this feature" | Create preparation task |

**Output:** List of action items documented in GitHub Issues or team notes.

---

### 4.2 Friday — Sprint Review

**When:** Every Friday, after Thursday's feedback

#### Sprint Review (20 min)

| Activity | Description |
|:---|:---|
| **Review completed work** | Go through Issues closed this week |
| **Demo anything not seen Thursday** | Show any new functionality |
| **Check against goals** | Did we achieve what we planned Monday? |
| **Document completed** | Ensure all done Issues are closed |

**Output:**
- Notes saved to `/docs/sprints/`
- 1-2 action items for next week

---

### 4.3 Monday — Sprint Planning

**When:** Every Monday morning

**Inputs:**
- Denis's feedback from Thursday
- Action items from Friday
- Product backlog (prioritized)
- Team capacity

**Planning Process:**

| Step | Activity | Tool |
|:---|:---|:---|
| 1 | Review Denis's feedback and create Issues | GitHub Issues |
| 2 | Prioritize tasks for the week | Labels: `priority: *` |
| 3 | Break down complex tasks | Issue checklists |
| 4 | Estimate effort (optional) | `size: *` labels |
| 5 | Assign owners | GitHub Assignees |
| 6 | Move to Sprint Backlog | GitHub Project board |
| 7 | Set acceptance criteria | Issue description |

**Output:** Sprint backlog ready with 3-7 Issues for the week.

---

### 4.4 Tuesday–Wednesday — Execution

**When:** Tuesday and Wednesday

**Who:** All team members working on assigned tasks

#### Daily Standup (15 min each day)

Each person answers:

| Question | How We Track |
|:---|:---|
| What did I do yesterday? | Link to Issues/PRs |
| What will I do today? | Assign yourself to Issues |
| What blockers do I have? | Add `blocked` label + comment |

**During Execution:**

| Activity | Tool |
|:---|:---|
| Update issue status | Move across project board |
| Create PRs | Link to Issues (`Closes #123`) |
| Request reviews | GitHub Reviewers |
| Fix bugs | Create bug Issues |

---

## 5. GitHub Setup for Tactical Planning

### 5.1 Project Board: "Sprint Backlog"

| Column | Description | Automation |
|:---|:---|:---|
| **To Do** | Tasks for this week, not started | Issues added during Sprint Planning |
| **In Progress** | Being worked on now | Moved manually when assigned |
| **Review** | PR submitted, awaiting review | Auto-move when PR opened |
| **Done** | Completed and closed | Auto-move when Issue closed |

### 5.2 Labels for Tactical Planning

| Category | Labels |
|:---|:---|
| **Priority** | `priority: critical`, `priority: high`, `priority: medium`, `priority: low` |
| **Status** | `status: blocked`, `status: in-progress`, `status: review-needed` |
| **Size** | `size: small`, `size: medium`, `size: large` |
| **Type** | `feature`, `bug`, `documentation`, `feedback` |

---

## 6. Success Metrics for Tactical Planning

| Metric | Target | How to Measure |
|:---|:---|:---|
| **Feedback incorporation** | 100% of Denis's actionable feedback appears in next sprint | Track feedback Issues |
| **Sprint completion rate** | ≥80% of planned tasks completed | Count closed vs planned |
| **PR review time** | <24 hours | GitHub Insights |
| **Blockers resolved** | <2 days | Time from `blocked` to resolved |

---

*Document Version: 1.0 — March 15, 2026*
