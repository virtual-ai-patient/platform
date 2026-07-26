**Owner:** Aizat (`muitiiifruckt`) &nbsp;·&nbsp; **Labels:** `documentation`, `component: ai`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

The pivot to a startup proposal moves the emphasis of the architecture document: the **LLM Patient Role Design** is now our core differentiator (per the domain-expert meeting — the market is validated, so quality of execution is what matters). It deserves its own top-level section in `docs/architecture/system-architecture.md`, owned by Aizat, that a reviewer can read as evidence for the proposal's differentiator claim.

This issue is scoped to that section only. General architecture-doc cleanup (nginx removal, qa-rev3 cross-references, formal diagram-type naming) is a separate issue owned by Ilnar (see issue #11).

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Add a new top-level section **"LLM Patient Role Design"** to `system-architecture.md`.
- [ ] Cover the four behaviours:
    - **Lying** — partial-recall vs deliberate-concealment prompt patterns.
    - **Forgetting** — turn-count triggered state degradation.
    - **Emotions** — tone modulation grounded in the case persona.
    - **State management** — how per-turn state is fed back into the prompt.
- [ ] For each behaviour, include either a short prompt-pattern example or a link to the corresponding subsection of `docs/proposal/patient-role-research.md` (issue #9).
- [ ] Cross-link the new section from the "Architectural principles" list ("LLM Patient Role Design is the primary differentiator — see §…").

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] `system-architecture.md` contains an "LLM Patient Role Design" top-level section covering lying / forgetting / emotions / state management.
- [ ] Each of the four behaviours has either an inline example or a link into `docs/proposal/patient-role-research.md`.
- [ ] The section is referenced from the "Architectural principles" list.
- [ ] The three existing diagrams still render correctly on the docs site after the edit.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
