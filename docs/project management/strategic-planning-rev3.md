---
layout: default
title: Strategic Planning — Rev 3 (Current)
parent: Strategic Planning
grand_parent: Current — Startup Proposal
nav_order: 3
---

# Strategic Planning — Revision 3 (parallel tracks)

**Goal:** Deliver a startup proposal backed by a validated prototype.
**Active since:** July 2026
**Supersedes:** [strategic-planning-rev2.md](strategic-planning-rev2.md) (sequential P1→P2→P3)
**Traceability:** [tactical-planning-rev3.md](tactical-planning-rev3.md) · [hypotheses.md](../proposal/hypotheses.md) · [configuration-management-rev2.md](../cm/configuration-management-rev2.md)

---

## 1. What is Strategic Planning?

Strategic planning defines our **vision, tracks, and success criteria** over the project timeline. It answers:

- **What** are we delivering by August 2026?
- **How** do tracks run in parallel and converge?
- **How** do we know each hypothesis is closed?
- **Who** owns each track?

---

## 2. Goal (unchanged)

In early 2026 the team's engagement with the original industry partner (Third Opinion) did not progress to a signed agreement. The team pivoted to:

> **Deliver a startup proposal for an AI-powered clinical training simulator, backed by a validated prototype.**

The proposal must demonstrate three things:

1. The **LLM patient role** is the core differentiator — believable lying, forgetting, emotional states, and hesitation.
2. A **structured case system** with constrained resources changes how learners reason.
3. The combined experience feels like a **game**, not a form.

*Scope boundary:* Business model, go-to-market strategy, and funding ask are explicitly out of scope for this SE course project.

---

## 3. Why Parallel Tracks (Rev 3 change)

Rev 2 used a sequential structure: close P1 before starting P2, close P2 before starting P3. This was conservative. With limited time remaining, the dependency analysis shows that H1, H2, and H3 can run simultaneously:

| Hypothesis | Needs from others | Can start without |
| :--- | :--- | :--- |
| H1 — Patient Role (Aizat) | Nothing | Any UI — console input is enough for expert rating |
| H2 — Case System (Ilnar) | Nothing | H1 can be a mock patient during development |
| H3 — Game Feel (Timur) | H2 backend for **final validation only** | Game design + mock UI start immediately; switch to real backend when H2 is ready |
| Track D — Recruitment (Alina) | Nothing | Independent from day one |

**Only one hard dependency:** H3 final validation requires H2 budget system to be working. H3 research and game design are fully independent.

---

## 4. Four Parallel Tracks

```text
Sprint 1          Sprint 2          Sprint 3          Finalisation
────────────────────────────────────────────────────────────────────
Track A — Aizat
  [Prompt design] → [Expert session] → [Close H1] ─────────────────┐
                                                                     │
Track B — Ilnar                                                      │
  [Budget system] → [Corridor test] → [Close H2] ───────────────────┤
                                                                     │
Track C — Timur                                                      │
  [Game design]   → [Mock UI + H3]  → [Real backend] → [Close H3] ──┤
               ↑ H2 backend ready ──────────────────┘               │
                                                                     ▼
Track D — Alina                                              Proposal
  [Recruit H1 expert] → [Recruit H2/H3 participants] ──────> Finalisation
                                                             Sprint
────────────────────────────────────────────────────────────────────
```

### Track A — Patient Role (H1 owner: Aizat)

**Goal:** Prove that an LLM can convincingly simulate lying, forgetting, and emotional states.

| Stage | Output | Exit criterion |
| :--- | :--- | :--- |
| Prompt design | Prompt variants for all 5 rubric dimensions | Automated harness passes for dimensions 1–3; dimensions 4–5 have prompt strategy |
| Expert session | L2 artifact in `user-insights.md` | Session conducted; raw notes committed same day |
| Validation | H1 closed | Expert rating ≥ 4/5 on all 5 dimensions; `hypotheses.md` updated; `P1-tag` on commit |

**Entry:** Seed case available (already satisfied).
**Exit (H1 closed):** As defined in `hypotheses.md`.

---

### Track B — Case System (H2 owner: Ilnar)

**Goal:** Prove that a constrained investigation budget changes how learners reason.

| Stage | Output | Exit criterion |
| :--- | :--- | :--- |
| Budget system | Working backend with price catalog and per-session counter | `docker compose up` passes QA-REPRO-01/02/03 |
| Corridor test | ≥ 3 participants complete case without assistance | Observers record budget-driven strategy changes |
| Validation | H2 closed | Findings in `user-insights.md`; H2 status updated; `P2-tag` on commit |

**Entry:** Independent — starts sprint 1.
**Exit (H2 closed):** As defined in `hypotheses.md`. Also unblocks Track C final validation.

---

### Track C — Game Feel (H3 owner: Timur)

**Goal:** Prove that the full loop (conversation → tests → diagnosis → debrief) feels like a game.

Track C has two phases with a hard switch point:

| Phase | Depends on | Output |
| :--- | :--- | :--- |
| Game design + mock UI | Nothing | Interview ≥ 2 users on game mechanics concept; build mock UI for H3 sessions |
| Switch to real backend | H2 backend ready (Track B) | Integrate real budget system; run H3 validation sessions |
| Validation | H2 closed | ≥ 5 participants; H3 closed; `P3-tag` on commit |

**Hard switch date:** Agreed at sprint 2 Monday planning once H2 backend is confirmed ready.
**Entry:** Game design starts sprint 1 on mock. Final validation unblocks only after H2 closes.
**Exit (H3 closed):** As defined in `hypotheses.md`.

---

### Track D — Recruitment and L2 Artifacts (owner: Alina)

**Goal:** Ensure participants are available for every session across all three tracks.

| Responsibility | Notes |
| :--- | :--- |
| Recruit H1 domain expert | Hardest to recruit — start in sprint 1, week 1 |
| Recruit H2/H3 corridor-test participants | Can draw from same pool; minimum 3 for H2, 5 for H3 |
| Facilitate sessions | One facilitator per session; note-taker assigned per session |
| Commit L2 artifacts | Same day as session; template from configuration-management-rev2 |

Alina is not the sole note-taker — each track owner may take notes for their own session with Alina facilitating. Any arrangement that gets the L2 artifact committed same day is acceptable.

---

## 5. Integration Point — Proposal Finalisation

When **all three hypotheses are explicitly closed** (confirmed or refuted), Karim calls a Proposal Finalisation sprint:

- Every claim in the proposal links to a Level 2 artifact. No unvalidated assertions.
- `docs/architecture/system-architecture.md` reflects the current state of the prototype.
- `docs/proposal/hypotheses.md` shows status for all three hypotheses.
- Pitch deck references all three tracks with their validation outcomes.
- Repository passes `docker compose up` from a fresh clone; reviewer can reach a working demo in ≤ 10 minutes (QA-DOC-01).

A refuted hypothesis is **not a blocker** for finalisation — it must be documented and acknowledged in the pitch, not hidden.

---

## 6. Milestones

| Milestone | Target | Exit criterion | Owner |
| :--- | :--- | :--- | :--- |
| Discovery complete | March 2026 ✓ | Expert sessions done; 3 hypotheses open | Alina |
| All tracks started | Sprint 1 (late July 2026) | Issues open per track; Alina recruiting | All |
| H1 closed | August 2026 | Expert rating recorded; `P1-tag` | Aizat |
| H2 closed | August 2026 | ≥ 3 corridor tests; `P2-tag` | Ilnar |
| H3 closed | August 2026 | ≥ 5 sessions; `P3-tag` | Timur |
| **All hypotheses closed** | August 2026 | All three statuses set in `hypotheses.md` | Karim |
| Proposal ready | August 2026 | All claims traceable; demo runs from cold clone | Karim |
| Pitch | August 2026 | Delivered to course jury / IU | All |

The "All hypotheses closed" milestone replaces "P3 validated" from Rev 2. Hypotheses close independently — H1 may close before H2 or H3.

---

## 7. Risks and Mitigations

Risks inherited from Rev 2 plus parallel-specific additions.

| Risk | Probability | Impact | Mitigation |
| :--- | :--- | :--- | :--- |
| Hypothesis refuted with no time to iterate | Medium | High | Each track closes by its own milestone date. Refutation is recorded and used as evidence — do not retry indefinitely. |
| Alina recruiting for 3 tracks simultaneously | High | High | Prioritise H1 expert first (hardest to recruit); H2 and H3 corridor tests can draw from the same participant pool. |
| H3 blocked waiting for H2 backend | Medium | Medium | Timur works on mock UI and game design until H2 is confirmed ready; hard switch date agreed at sprint 2 planning. |
| Wednesday sync becomes 3 parallel monologues | Medium | Medium | 15 min per track (capped); every 2nd Wednesday is a full integration review — do the three tracks still tell a coherent proposal story? |
| Coordination overhead slows all tracks | Medium | Medium | Karim owns cross-track dependencies; any blocker raised by Wednesday, resolved before Thursday. |
| Proposal claim not traceable to evidence | Medium | High | Karim runs traceability audit before Proposal Finalisation sprint. |
| Demo crashes during pitch | Low | High | Tag commit frozen and smoke-tested the day before pitch; no hotfixes on pitch day. |

---

## 8. Team Roles

| Person | Track | Strategic responsibility |
| :--- | :--- | :--- |
| Aizat | A — H1 | Prompt design, automated harness, expert session, H1 closure |
| Ilnar | B — H2 | Backend budget system, corridor test facilitation, H2 closure |
| Timur | C — H3 | Game design, mock UI, switch to real backend, H3 closure |
| Alina | D — Recruitment | Participant pipeline across all tracks, L2 artifacts, proposal narrative |
| Karim | Cross-track | Sprint planning, dependency resolution, traceability audit, milestone validation |

---

## 9. Connection to Other Documents

```text
Strategic Plan Rev 3 (this document — tracks + milestones)
    ↓
docs/proposal/hypotheses.md  ←  status of H1 / H2 / H3 (per-track)
    ↓
Tactical Planning Rev 3  ←  per-track sprint goals and cross-track sync
    ↓
GitHub Issues  ←  atomic tasks with AC linked to hypothesis and track
    ↓
Prototype tags  ←  P1-tag / P2-tag / P3-tag (independent per track)
    ↓
docs/proposal/user-insights.md  ←  evidence that closes each hypothesis
```

---

## Changelog

| Date | Author | Changes |
| :--- | :--- | :--- |
| July 2026 | Karim Abdulkin | **Rev 3:** replaced sequential P1→P2→P3 phases with four parallel tracks (A/B/C/D). Single hard dependency retained: H3 final validation requires H2 backend. Added parallel-specific risks. "All hypotheses closed" milestone replaces "P3 validated". Goal statement, hypotheses, team roles, and traceability hierarchy preserved unchanged. |
| July 2026 | Karim Abdulkin | Rev 2: hypothesis-driven phases replacing 5-month feature roadmap. |
| March 2026 | Karim Abdulkin | Initial post-pivot plan. |
