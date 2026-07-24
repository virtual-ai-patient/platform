# Strategic Planning — Revision 2 (post-pivot: startup proposal)

---

## 1. What is Strategic Planning?

Strategic planning defines our **vision, major phases, and success criteria** over the project timeline. It answers:

- **What** are we delivering by August 2026?
- **When** does each phase close?
- **How** do we know a phase is done?
- **Who** is responsible for each deliverable?

---

## 2. Context and Goal

In early 2026 the team's engagement with the original industry partner (Third Opinion) did not progress to a signed agreement. With the course's remaining timeline in view, the team and course coordinator agreed on a new goal:

> **Deliver a startup proposal for an AI-powered clinical training simulator, backed by a validated prototype.**

The proposal must demonstrate three things a future investor or institutional partner would need to see:

1. The **LLM patient role** is the core differentiator — believable lying, forgetting, emotional states, and hesitation.
2. A **structured case system** with constrained resources (test budget, test–case compatibility) changes how learners reason.
3. The combined experience feels like a **game**, not a form.

We are not producing a business model or financial projections — that requires market data we do not have. We are producing a **product and technical validation** with evidence from real users and a domain expert.

*Scope boundary:* Business model, go-to-market strategy, and funding ask are explicitly out of scope for this SE course project.

---

## 3. Three-Phase Plan

```text
March          April–May        June–July       August
└──────┬────────┴────────┬────────┴────────┬──────┴──────┐
  Discovery          Prototype            Proposal     Pitch
                   Iterations         Finalisation
                  P1 → P2 → P3
```

### Phase 0 — Discovery (March 2026)

**Goal:** Understand the problem space well enough to form falsifiable hypotheses.

**Exit criteria (all must be met):**
- Domain expert session conducted; findings written up in `docs/proposal/user-insights.md`.
- Value Proposition Canvas drafted.
- Three hypotheses formalised in `docs/proposal/hypotheses.md` with owner, validation method, and status = *open*.
- Seed case library with ≥ 3 demo cases available in the repo.

**Owners:** Alina (user research, VPC), Aizat (domain research, patient-role framing).

---

### Phase 1 — Prototype Iterations: P1 / P2 / P3 (April – July 2026)

Each iteration runs 2–4 weeks. It closes when its hypothesis is explicitly confirmed or refuted by evidence — not when code is merged.

#### P1 — Patient Role (April 2026)

| | |
|---|---|
| **Hypothesis** | An LLM can convincingly simulate lying, forgetting, and emotional states in a clinical conversation. |
| **Validation method** | Domain expert rates believability ≥ 4/5 on a structured rubric. |
| **Owner** | Aizat |
| **Entry criterion** | P0 exit criteria met; seed case available to test against. |
| **Exit criterion** | Expert rating recorded in `docs/proposal/user-insights.md`; H1 status updated to *confirmed* or *refuted* in `docs/proposal/hypotheses.md`; commit tagged `P1-tag`. |

**Risks for P1:**

| Risk | Mitigation |
|---|---|
| LLM produces inconsistent role behaviour across sessions | Run judge at `temperature=0`; version rubric prompt; fix seed case. |
| Expert rates believability < 4/5 | Hypothesis refuted → open new issue to iterate on prompt strategy before P2. Do not silently drop. |

---

#### P2 — Case System (May 2026)

| | |
|---|---|
| **Hypothesis** | A constrained test budget changes how learners reason through a clinical case. |
| **Validation method** | Corridor test: participant completes a P2 case without assistance from the team. |
| **Owner** | Ilnar + Timur |
| **Entry criterion** | P1 hypothesis closed (confirmed or refuted with documented rationale). |
| **Exit criterion** | ≥ 3 corridor-test participants; findings in `docs/proposal/user-insights.md`; H2 status updated; commit tagged `P2-tag`. |

**Risks for P2:**

| Risk | Mitigation |
|---|---|
| Participants can't finish case without help | Hypothesis refuted → document exactly where they got stuck; refine case or UI; do not claim it worked. |
| Insufficient participants | Alina recruits from peers / university contacts; minimum 3 to close H2. |

---

#### P3 — Full Loop (June – July 2026)

| | |
|---|---|
| **Hypothesis** | The complete flow (conversation → tests → diagnosis → debrief) feels like a game, not a form. |
| **Validation method** | User feedback session (≥ 5 participants) + Alina's structured interview summary. |
| **Owner** | All |
| **Entry criterion** | P2 hypothesis closed; full end-to-end flow running stably (`docker compose up`). |
| **Exit criterion** | Interview summary written by Alina; majority of participants describe the experience as engaging rather than form-filling; H3 status updated; commit tagged `P3-tag`. |

**Risks for P3:**

| Risk | Mitigation |
|---|---|
| Full loop has demo-breaking bugs | CI gate: `docker compose up` + smoke test must pass before the session. |
| Feedback is ambiguous — neither clearly game-like nor form-like | Alina uses structured interview protocol with specific questions, not open-ended "did you like it". |

---

### Phase 2 — Proposal Finalisation (August 2026)

**Goal:** Assemble validated evidence into a coherent startup proposal and deliver the pitch.

**Exit criteria:**
- Every claim in the proposal links to a Level 2 artifact (expert notes or user insight). No unvalidated assertions.
- `docs/architecture/system-architecture.md` reflects the current state of the prototype.
- `docs/proposal/hypotheses.md` shows status for all three hypotheses.
- Pitch deck references all three prototype iterations with their validation outcomes.
- Repository passes `docker compose up` from a fresh clone; reviewer can reach a working demo in ≤ 10 minutes (QA-DOC-01).

**Owner:** Karim (coordination, traceability review); All (content).

---

## 4. Milestones

| Milestone | Target Date | Exit criterion | Owner |
|:---|:---|:---|:---|
| **Discovery complete** | March 31, 2026 | Expert session done; 3 hypotheses open in `hypotheses.md` | Alina |
| **P1 validated** | April 30, 2026 | Expert rating recorded; H1 closed; `P1-tag` on commit | Aizat |
| **P2 validated** | May 31, 2026 | ≥ 3 corridor tests done; H2 closed; `P2-tag` on commit | Ilnar + Timur |
| **P3 validated** | July 15, 2026 | ≥ 5 feedback sessions; H3 closed; `P3-tag` on commit | All |
| **Proposal ready** | July 31, 2026 | All claims traceable; docs complete; demo runs from cold clone | Karim |
| **Pitch** | August 2026 | Delivered to course jury / IU | All |

---

## 5. Risks and Mitigations

Risks here are **proposal-level** — they affect whether the pitch is credible, not whether a feature is delivered.

| Risk | Probability | Impact | Mitigation |
|:---|:---|:---|:---|
| Hypothesis refuted with no time to iterate | Medium | High | Close each hypothesis by the milestone date, not the last day of the phase. Leave ≥ 1 week buffer per phase. |
| Insufficient user contacts for P2 / P3 | Medium | High | Alina maintains a running list of potential participants from week 1 of Discovery. |
| Proposal claim not traceable to evidence | Medium | High | Karim runs a traceability audit before Proposal Finalisation; every claim must link to `user-insights.md` or expert notes. |
| Demo crashes during pitch | Low | High | `P3-tag` commit is frozen and smoke-tested the day before pitch; no hotfixes on pitch day. |
| Patient role quality insufficient for expert approval | Medium | Medium | P1 is the earliest phase — if refuted, team has April–May to iterate before P2 builds on it. |

---

## 6. Team Roles (post-pivot)

| Person | Role | Strategic responsibility |
|:---|:---|:---|
| Alina | Startup Flow | User interviews, corridor tests, VPC, insight artifacts |
| Karim | Project Manager | Sprint planning, traceability audits, milestone validation |
| Ilnar | Backend Developer | Prototype backend, technical architecture section of proposal |
| Timur | Frontend Developer | Prototype UI, demo stability for corridor testing |
| Aizat | AI Specialist | LLM patient role research and implementation (P1 owner) |

---

## 7. Connection to Other Documents

```text
Strategic Plan (this document — phase + milestone level)
    ↓
docs/proposal/hypotheses.md  ←  status of H1 / H2 / H3
    ↓
Tactical Planning  ←  weekly sprint tasks that advance each hypothesis
    ↓
GitHub Issues  ←  atomic tasks with AC linked to hypotheses
    ↓
Prototype versions  ←  P1-tag / P2-tag / P3-tag commits
    ↓
docs/proposal/user-insights.md  ←  evidence that closes each hypothesis
```

Changes propagate **downward**: a change in a milestone date or hypothesis statement must be reflected in the tactical plan and in `hypotheses.md`. Changes propagate **upward** only when a hypothesis is refuted — that triggers a retrospective on the strategic phase, not just a task.

---

## Changelog

| Date | Author | Trigger | Changes |
|:---|:---|:---|:---|
| March 2026 | Karim Abdulkin | Industry partner engagement did not progress; course coordinator approved new goal | Initial version — replaced 5-month feature roadmap with three-phase hypothesis-driven plan aligned to startup proposal goal. |
