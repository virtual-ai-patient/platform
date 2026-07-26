**Owner:** Karim (`GrandAdmiralBee`) &nbsp;·&nbsp; **Labels:** `documentation`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

The proposal's credibility rests on three hypotheses (P1 Patient Role, P2 Case System, P3 Full Loop) being explicitly tested against evidence rather than assumed. There is currently no single document that tracks which hypothesis is open, which is confirmed, which is refuted, and where the supporting evidence lives. Without it, the proposal's claims can drift away from what we actually validated.

Create `docs/proposal/hypotheses.md` as the **living hypothesis tracker**. It is the single place where a reviewer can see the state of each hypothesis and follow a link to the artifact that closed it (expert rating for P1, corridor-test transcript for P2, user feedback session for P3). This document is referenced by strategic planning (issue #2), tactical planning (issue #3), QA (issue #4), and CM (issue #6).

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Create `docs/proposal/hypotheses.md` with a fixed-schema table: hypothesis ID, statement, iteration (P1/P2/P3), owner, validation method, current status (open / confirmed / refuted), evidence artifact link.
- [ ] Pre-populate three rows:
    - **H1** — LLM can convincingly simulate lying, forgetting, and emotional states. Owner: Aizat. Validation: expert rates believability ≥ 4/5.
    - **H2** — A constrained test budget changes how learners reason. Owner: Ilnar + Timur. Validation: corridor test — user completes P2 case unassisted.
    - **H3** — The complete flow feels like a game, not a form. Owner: all. Validation: user feedback session + Alina's interview summary.
- [ ] Add a **"How to close a hypothesis"** subsection: who decides (Karim + owner), what evidence is required, where the evidence is linked from.
- [ ] Add a **Changelog** table (mirroring `docs/qa/qa-rev*.md` style) so status transitions are traceable.
- [ ] Register the doc in the Jekyll nav (`docs/proposal/index.md` with `has_children: true` if that pattern is used site-wide).

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] `docs/proposal/hypotheses.md` exists with all three hypotheses pre-populated.
- [ ] Each row has an owner and a validation method; status starts at "open".
- [ ] "How to close a hypothesis" section defines decision-maker and required evidence.
- [ ] Changelog table exists and is empty (ready for first entry).
- [ ] Doc appears in the site nav under a "Proposal" section.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
