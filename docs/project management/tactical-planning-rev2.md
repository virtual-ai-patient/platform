# Tactical Planning — Rev 2

**Goal:** Deliver a startup proposal backed by a validated prototype.
**Active since:** March 2026 (pivot)
**Traceability:** [strategic-planning-rev2.md](strategic-planning-rev2.md) · [hypotheses.md](../proposal/hypotheses.md) · [configuration-management-rev2.md](../cm/configuration-management-rev2.md)

---

## 1. What Changed and Why

Rev 1 organised work around weekly feature delivery reviewed by the mentor on Thursdays. After the pivot the primary output is no longer a shipped feature — it is **evidence that advances a hypothesis**. The weekly cycle is restructured accordingly:

| Rev 1 focus | Rev 2 focus |
| :--- | :--- |
| Ship tasks from sprint backlog | Advance or close a hypothesis |
| Denis confirms features are correct | Thursday session decides hypothesis go/no-go |
| DoD = code passes AC | DoD = artifact done **and** hypothesis advanced |
| Feedback source: mentor | Feedback source: expert sessions, corridor tests, mentor |

---

## 2. Two-Week Sprint Rhythm

### Why two weeks

Rev 1 used one-week sprints optimised for fast feature delivery. Hypothesis validation has a different bottleneck: **people**. Recruiting an expert, aligning on a meeting slot, running the session, and waiting for a follow-up question to be answered can easily take three to five days on its own. Team members also carry coursework, part-time jobs, and other commitments that make it unrealistic to run a prototype session, analyse findings, and produce a committed L2 artifact in a two-day execution window.

A two-week sprint gives us:
- one week to recruit, prepare, and run the session;
- a second week to record the L2 artifact, analyse findings, run prototype improvements if needed, and arrive at Thursday's mentor session with a complete evidence package.

The mentor meeting still happens every Thursday, but the hypothesis go/no-go decision is made at the **second** Thursday of the sprint, once evidence is fully recorded.

```text
┌──────────────────────────────────────────────────────────┐
│  WEEK 1                                                  │
│                                                          │
│  [Monday W1]                                             │
│  Sprint Planning                                         │
│  • Review hypothesis status                              │
│  • Confirm participant and session slot for this sprint  │
│  • Assign facilitator + note-taker                       │
│  • Open or update GitHub issues; set AC from QA-VAL      │
│            ↓                                             │
│  [Thursday W1]                                           │
│  Mentor Check-in (light)                                 │
│  • Status update — no go/no-go expected                  │
│  • Unblock any recruitment or prototype blockers         │
│            ↓                                             │
│  [Tue–Fri W1, flexible]                                  │
│  Prototype Session                                       │
│  • Run session when participant is available             │
│  • Note-taker records raw observations                   │
│                                                          │
├──────────────────────────────────────────────────────────┤
│  WEEK 2                                                  │
│                                                          │
│  [Mon–Wed W2]                                            │
│  L2 Recording + Analysis                                 │
│  • Draft and commit L2 artifact in user-insights.md      │
│  • Anonymise per guidelines                              │
│  • Map findings to hypothesis criteria (QA-VAL)          │
│  • Ship any prototype fixes surfaced by the session      │
│            ↓                                             │
│  [Thursday W2]                                           │
│  Mentor Session — Hypothesis Decision                    │
│  • Present findings and L2 artifact                      │
│  • Hypothesis go/no-go: Karim + owner decide             │
│  • Update hypotheses.md live                             │
│  • Document action items as GitHub issues                │
│            ↓                                             │
│  [Friday W2]                                             │
│  Wrap-up                                                 │
│  • Close completed issues                                │
│  • Carry over any open items to next sprint              │
│            ↓                                             │
│  [Monday W1 of next sprint] (repeat)                     │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

## 3. Hypothesis-Closure Ritual

A hypothesis is closed (validated or refuted) only at the **Thursday mentor session**, following this checklist:

1. Pull up the hypothesis entry in [hypotheses.md](../proposal/hypotheses.md).
2. Confirm that the exit criterion from QA-VAL is met (or clearly not met).
3. Confirm that the supporting L2 artifacts in [user-insights.md](../proposal/user-insights.md) are committed and anonymised.
4. Decision-makers (Karim + hypothesis owner) state the verdict aloud.
5. Update `hypotheses.md` status field in the same session.
6. If **validated**: open a follow-up issue to incorporate the finding into the proposal deck.
7. If **refuted**: open a retrospective issue, update `hypotheses.md`, notify Monday planning. Do not silently drop the refutation — it is evidence too.

**Who decides:** Karim + hypothesis owner. No unilateral closure.

---

## 4. Definition of Done (DoD)

An issue is Done only when **both** conditions are true:

| Condition | How to verify |
| :--- | :--- |
| Technical AC met | PR merged, tests pass, doc updated |
| Hypothesis advanced | Linked hypothesis status updated in `hypotheses.md`, or a new L2 artifact committed |

If an issue does not touch any hypothesis (e.g. infra fix), the second condition is waived and noted explicitly in the issue.

---

## 5. Sprint Planning (Monday, Week 1)

**Inputs:**
- Hypothesis status from `hypotheses.md`
- Action items from previous sprint's Thursday W2 mentor session
- Participant availability — confirm slot before planning ends
- Team capacity for both weeks

**Planning steps:**

| Step | Activity | Tool |
| :--- | :--- | :--- |
| 1 | Check which hypothesis is active (P1 / P2 / P3 phase per strategic-planning-rev2) | hypotheses.md |
| 2 | Decide session type for the week | GitHub Issue |
| 3 | Assign facilitator, note-taker, participant contact | GitHub Assignees |
| 4 | Create or update implementation issues needed to run the session | GitHub Issues → Task Tracker |
| 5 | Set AC referencing the relevant QA-VAL criterion | Issue description |

**Output:** 3–5 issues with owners and AC, linked to active hypothesis.

---

## 6. Prototype Session Protocol

**Before the session:**
- Prototype is deployable via `docker compose up` (QA-REPRO-01).
- Seed case loaded (QA-REPRO-02).
- Mock LLM enabled if no API key available (QA-REPRO-03).
- Facilitator has session guide; note-taker has L2 template open.

**During the session:**
- Facilitator runs the participant through the prototype without coaching.
- Note-taker records raw observations in real time.
- Session is not recorded without explicit participant consent.

**After the session (same day):**
- Note-taker drafts the L2 artifact using the User Insight template from [configuration-management-rev2.md](../cm/configuration-management-rev2.md).
- Anonymise per the rules in [user-insights.md](../proposal/user-insights.md).
- Commit to `docs/proposal/user-insights.md` before end of day.
- Open follow-up GitHub issues for findings that affect hypothesis criteria.

---

## 7. Thursday Mentor Session Agendas

### Thursday W1 — Check-in (30 min)

| Time | Activity |
| :--- | :--- |
| 10 min | Status update: is the session scheduled? Any prototype blockers? |
| 10 min | Early observations if session already ran |
| 10 min | Adjust sprint scope if participant cancelled or is delayed |

**Output:** Blockers unblocked; sprint scope confirmed or adjusted.

### Thursday W2 — Hypothesis Decision (50 min)

| Time | Activity |
| :--- | :--- |
| 5 min | Present L2 artifact — key findings only |
| 15 min | Map findings to hypothesis criteria (QA-VAL) |
| 10 min | Hypothesis go/no-go discussion |
| 10 min | Scope and priority adjustments for next sprint |
| 5 min | Document action items as GitHub issues |
| 5 min | Update `hypotheses.md` status live |

**Output:** Updated `hypotheses.md`, ≥1 new or updated GitHub issue.

---

## 8. Handling Hypothesis Refutation

If a hypothesis is refuted at the Thursday session:

| Step | Action | Owner |
| :--- | :--- | :--- |
| 1 | Change status in `hypotheses.md` to `Refuted` with date and evidence reference | Karim |
| 2 | Open a retrospective GitHub issue explaining what the evidence showed | Karim + owner |
| 3 | Notify Monday planning — adjust prototype scope | Alina (PM) |
| 4 | Do **not** silently remove the hypothesis — it remains in `hypotheses.md` as evidence | All |

Refutation is not failure; it is evidence. The proposal must acknowledge it honestly.

---

## 9. Success Metrics

| Metric | Target | How to measure |
| :--- | :--- | :--- |
| L2 artifacts committed same day as session | 100% | Check commit date vs session date |
| Hypothesis status updated at Thursday session | Every session | `hypotheses.md` last-modified date |
| Issues with QA-VAL AC reference | 100% of hypothesis-linked issues | Issue review at Monday planning |
| Refuted hypotheses documented | 100% | `hypotheses.md` has no blank status |

---

## Changelog

| Date | Author | Changes |
| :--- | :--- | :--- |
| March 2026 | Karim Abdulkin | Initial Rev 2 — hypothesis-driven cycle, closure ritual, new DoD |
| 24-07-2026 | Karim Abdulkin | Aligned session protocol and closure ritual with P-01/P-02 findings; added QA-VAL references |
