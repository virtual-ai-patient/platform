---
layout: default
title: Tactical Planning — Rev 3 (Current)
parent: Tactical Planning
grand_parent: Current — Startup Proposal
nav_order: 3
---

# Tactical Planning — Rev 3

**Goal:** Deliver a startup proposal backed by a validated prototype.
**Active since:** July 2026
**Supersedes:** [tactical-planning-rev2.md](tactical-planning-rev2.md) (single-hypothesis-per-sprint model)
**Traceability:** [strategic-planning-rev3.md](strategic-planning-rev3.md) · [hypotheses.md](../proposal/hypotheses.md) · [configuration-management-rev2.md](../cm/configuration-management-rev2.md)

---

## 1. What Changed and Why

Rev 2 ran one hypothesis per sprint: the whole team focused on H1 until it closed, then H2, then H3. With limited time remaining, the dependency analysis in [strategic-planning-rev3.md](strategic-planning-rev3.md) shows H1, H2, and H3 can run simultaneously. Rev 3 restructures the sprint to manage four parallel tracks.

| Rev 2 focus | Rev 3 focus |
| :--- | :--- |
| One active hypothesis per sprint | Three hypotheses active simultaneously across four tracks |
| Sprint goal = advance active hypothesis | Sprint goal = advance **each track's** hypothesis |
| Monday planning: one team, one hypothesis | Monday planning: one goal stated per track owner |
| Wednesday sync: joint status | Wednesday sync: 15 min per track; full integration every 2nd week |
| Denis sees one hypothesis at Thursday | Denis sees all three tracks at Thursday |

Everything else is preserved: 2-week sprint, Mon/Wed/Thu rhythm, DoD requiring hypothesis to advance, and the hypothesis closure ritual.

---

## 2. Four Tracks

| Track | Owner | Hypothesis | Running condition |
| :--- | :--- | :--- | :--- |
| A | Aizat | H1 — Patient Role | Starts sprint 1; independent |
| B | Ilnar | H2 — Case System | Starts sprint 1; independent |
| C | Timur | H3 — Game Feel | Game design starts sprint 1; final validation unblocks after H2 ready |
| D | Alina | Recruitment + L2 artifacts | Starts sprint 1; serves all three tracks |

---

## 3. Two-Week Sprint Rhythm

The 2-week structure is unchanged. What changes is that sprint events now happen **per track**, not for the team as a single unit.

```text
┌──────────────────────────────────────────────────────────────────┐
│  WEEK 1                                                          │
│                                                                  │
│  [Monday W1] — Sprint Planning (per track)                       │
│  Each track owner states:                                        │
│    • Track goal this sprint                                      │
│    • Dependencies needed from other tracks                       │
│    • Is recruitment on track for my session this sprint?         │
│  Karim: resolve any cross-track blockers before the session week │
│                                                                  │
│            ↓                                                     │
│                                                                  │
│  [Wednesday W1] — Per-Track Sync (15 min per track, capped)     │
│    A: Aizat — H1 progress, blocker, what's needed from D        │
│    B: Ilnar — H2 progress, blocker, what's needed from D        │
│    C: Timur — H3/game design progress, H2 dependency status     │
│    D: Alina — participant pipeline status for each track         │
│  Karim resolves cross-track blockers before Thursday             │
│                                                                  │
│            ↓                                                     │
│                                                                  │
│  [Thursday W1] — Mentor Check-in (light, 30 min)                │
│  Denis sees status across all three tracks:                      │
│    • "Here is what we learned / built this week across H1/H2/H3" │
│    • No go/no-go expected; unblock recruitment or prototype issues│
│                                                                  │
│            ↓                                                     │
│                                                                  │
│  [Tue–Fri W1, flexible] — Sessions (per track schedule)          │
│  Each track runs its session when participant is available        │
│  Tracks may run sessions on different days within the same sprint │
│                                                                  │
├──────────────────────────────────────────────────────────────────┤
│  WEEK 2                                                          │
│                                                                  │
│  [Mon–Wed W2] — L2 Recording + Analysis (per track)             │
│    • Each track owner drafts and commits L2 artifact same day    │
│    • Anonymise per guidelines in user-insights.md                │
│    • Map findings to hypothesis criteria (QA-VAL)                │
│    • Ship prototype fixes surfaced by the session                │
│                                                                  │
│            ↓                                                     │
│                                                                  │
│  [Wednesday W2] — Integration Review (every 2nd sprint)          │
│  Full cross-track review — do H1/H2/H3 tracks still tell a      │
│  coherent proposal story? Runs instead of standard per-track sync│
│                                                                  │
│            ↓                                                     │
│                                                                  │
│  [Thursday W2] — Mentor Session — Hypothesis Decisions (50 min)  │
│  Denis sees findings across all active tracks                    │
│  Any track that ran a session this sprint presents:              │
│    • L2 artifact key findings                                    │
│    • Hypothesis go/no-go if criteria are met                     │
│  Karim + hypothesis owner decide per track independently         │
│  Update hypotheses.md live for any track that closes             │
│                                                                  │
│            ↓                                                     │
│                                                                  │
│  [Friday W2] — Wrap-up                                           │
│  Close completed issues; carry open items to next sprint         │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 4. Monday Sprint Planning (per track)

**Inputs:**
- Hypothesis status per track from `hypotheses.md`
- Action items from previous sprint's Thursday W2 session
- Participant availability per track — confirm slots before planning ends
- H2 backend readiness (affects Track C switch date)

**Planning steps:**

| Step | Activity | Tool |
| :--- | :--- | :--- |
| 1 | Each track owner states the sprint goal for their track | `hypotheses.md` |
| 2 | Dependency check: what does each track need from others this sprint? | Verbal; blockers go to GitHub Issues |
| 3 | Confirm Alina's participant pipeline covers all sessions planned this sprint | Track D status |
| 4 | Assign facilitator + note-taker per session | GitHub Assignees |
| 5 | Create or update implementation issues per track; set AC from QA-VAL | GitHub Issues |

**Output:** 3–5 issues per active track, each with owner, AC, and hypothesis link.

---

## 5. Wednesday Sync (per track, 15 min cap)

Each track owner gives a status in this order:
1. Progress since Monday
2. Blocker (if any) — name it explicitly; "slow but OK" is not a blocker report
3. Dependency needed from another track before Thursday

Karim logs cross-track dependencies and resolves them before Thursday.

**Every 2nd Wednesday (Integration Review):**
All four track owners answer one question: "Do H1, H2, and H3 findings still tell a coherent startup proposal story?" If not, Karim escalates to a proposal-narrative correction before the pitch deck is written.

---

## 6. Thursday Mentor Session Agendas

### Thursday W1 — Check-in (30 min)

Denis sees all three tracks simultaneously. No per-hypothesis deep dive unless requested.

| Time | Activity |
| :--- | :--- |
| 5 min per track (15 min total) | Status: is the session scheduled? Any prototype or recruitment blocker? |
| 10 min | Unblock any cross-track or recruitment issue |
| 5 min | Adjust sprint scope if participant cancelled or is delayed |

**Output:** Blockers unblocked; sprint scope per track confirmed.

### Thursday W2 — Hypothesis Decisions (50 min)

| Time | Activity |
| :--- | :--- |
| 5 min per track (up to 15 min total) | Present L2 artifact key findings for any track that ran a session |
| 15 min | Map findings to hypothesis criteria (QA-VAL) per track |
| 10 min | Per-track hypothesis go/no-go decisions |
| 5 min | Scope and priority adjustments for next sprint (per track) |
| 5 min | Document action items as GitHub Issues |

**Output:** Updated `hypotheses.md` for any track that closes; ≥1 new or updated GitHub Issue.

---

## 7. Prototype Session Protocol

Unchanged from Rev 2. Applies independently per track.

**Before the session:**
- Prototype is deployable via `docker compose up` (QA-REPRO-01).
- Seed case loaded (QA-REPRO-02).
- Mock LLM enabled if no API key available (QA-REPRO-03).
- Track C before H2 switch: mock backend is acceptable; document which backend was used in the L2 artifact.

**During the session:**
- Facilitator runs the participant through the prototype without coaching.
- Note-taker records raw observations in real time.
- Session is not recorded without explicit participant consent.

**After the session (same day):**
- Note-taker drafts the L2 artifact using the template from [configuration-management-rev2.md](../cm/configuration-management-rev2.md).
- Anonymise per the rules in [user-insights.md](../proposal/user-insights.md).
- Commit to `docs/proposal/user-insights.md` before end of day.
- Open follow-up GitHub Issues for findings that affect hypothesis criteria.

---

## 8. Definition of Done (updated)

### Issue-level DoD

An issue is Done only when **both** conditions are true:

| Condition | How to verify |
| :--- | :--- |
| Technical AC met | PR merged, tests pass, doc updated |
| Track advanced | Linked hypothesis status updated in `hypotheses.md`, or a new L2 artifact committed |

If an issue does not touch any hypothesis (e.g. infra fix), the second condition is waived and noted explicitly in the issue.

### Sprint-level DoD (new in Rev 3)

A sprint closes when **all three** conditions are true:

- [ ] Each track has advanced its hypothesis **OR** explicitly documented why it did not (blocker named in a GitHub Issue, not silent)
- [ ] Any new L2 artifact from sessions committed to `user-insights.md`
- [ ] Cross-track dependencies updated in `hypotheses.md` (e.g. H2 ready → Track C switch date set)

**A sprint does NOT close if a track is silently stuck.** Blockers must be named.

---

## 9. Hypothesis-Closure Ritual (unchanged, now per track)

A hypothesis is closed only at the **Thursday W2 mentor session**, independently per track. H1 can close while H2 and H3 are still running.

1. Pull up the hypothesis entry in [hypotheses.md](../proposal/hypotheses.md).
2. Confirm the exit criterion from QA-VAL is met (or clearly not met).
3. Confirm the supporting L2 artifacts in [user-insights.md](../proposal/user-insights.md) are committed and anonymised.
4. Karim + hypothesis owner state the verdict aloud.
5. Update `hypotheses.md` status field in the same session.
6. If **validated**: open a follow-up issue to incorporate the finding into the proposal deck.
7. If **refuted**: open a retrospective issue, update `hypotheses.md`, notify Monday planning. Do not silently drop.

**Who decides:** Karim + the track's hypothesis owner. No unilateral closure.

**Proposal finalisation trigger:** When all three hypotheses are explicitly closed (confirmed or refuted), Karim calls a Proposal Finalisation sprint. Refutation does not block finalisation — it must be acknowledged in the pitch.

---

## 10. Handling Hypothesis Refutation (unchanged)

| Step | Action | Owner |
| :--- | :--- | :--- |
| 1 | Change status in `hypotheses.md` to `Refuted` with date and evidence reference | Karim |
| 2 | Open a retrospective GitHub Issue explaining what the evidence showed | Karim + track owner |
| 3 | Notify Monday planning — adjust that track's scope | Alina (PM) |
| 4 | Do **not** silently remove the hypothesis — it remains as evidence | All |

Refutation is not failure; it is evidence. The other tracks continue unaffected.

---

## 11. Success Metrics

| Metric | Target | How to measure |
| :--- | :--- | :--- |
| L2 artifacts committed same day as session | 100% | Check commit date vs session date |
| All tracks advance or name a blocker each sprint | Every sprint | Sprint wrap-up review on Friday W2 |
| Hypothesis status updated at Thursday W2 session | Every session that ran | `hypotheses.md` last-modified date |
| Issues with QA-VAL AC reference | 100% of hypothesis-linked issues | Issue review at Monday planning |
| Refuted hypotheses documented | 100% | `hypotheses.md` has no blank status |
| Integration review held every 2nd sprint | 100% | Wednesday W2 calendar |

---

## Changelog

| Date | Author | Changes |
| :--- | :--- | :--- |
| July 2026 | Karim Abdulkin | **Rev 3:** replaced single-hypothesis-per-sprint model with four parallel tracks (A/B/C/D). Monday planning now per-track. Wednesday sync now 15 min per track with full integration review every 2nd sprint. Thursday shows all three tracks to Denis simultaneously. Sprint-level DoD added: track must advance or name blocker explicitly. Hypothesis closure ritual unchanged but now fires independently per track. 2-week sprint, Mon/Wed/Thu rhythm, issue-level DoD, and closure ritual preserved. |
| 24-07-2026 | Karim Abdulkin | Rev 2: aligned session protocol and closure ritual with P-01/P-02 findings; added QA-VAL references. |
| March 2026 | Karim Abdulkin | Rev 2 initial: hypothesis-driven cycle, closure ritual, new DoD. |
