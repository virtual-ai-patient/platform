**Owner:** Alina (`rayderdo`) &nbsp;·&nbsp; **Labels:** `documentation`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

Under the pivot, user interviews and corridor tests are our primary evidence source — but only if the findings are captured in a comparable, structured way. If each interview lives in a separate Google doc with its own format, the proposal can't cite them consistently and the CM policy (issue #6) can't treat "User Insight" as a first-class artifact.

Create `docs/proposal/user-insights.md` as the running log. Every entry follows a fixed structure so that a reviewer can scan the log linearly, and so that any insight can be traced to the hypothesis it advances. This document is the L2 artifact referenced by the new CM hierarchy (issue #6) and by the H2 / H3 rows in `hypotheses.md` (issue #8).

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Create `docs/proposal/user-insights.md` with an intro that names it as the L2 artifact and links to `docs/cm/configuration-management.md`.
- [ ] Define a **fixed per-entry template**:
    - `date` (ISO)
    - `participant` (anonymised handle — e.g. `P-01`, `P-02`)
    - `method` (interview / corridor test / expert session)
    - `context` (one line: what the participant was shown or asked)
    - `key insights` (bulleted, ≤ 5 items)
    - `linked hypothesis` (H1 / H2 / H3 or "none")
    - `follow-up issues` (list of GitHub issue links, or "none yet")
- [ ] Add one worked example entry so the format is unambiguous for future logging.
- [ ] Add an anonymisation guideline: no names, no institution names, no clinical specialty combined with location.
- [ ] Register in Jekyll nav under "Proposal".

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] `docs/proposal/user-insights.md` exists with the fixed per-entry template documented.
- [ ] All seven fields (date, participant, method, context, insights, linked hypothesis, follow-up issues) are named in the template.
- [ ] One worked example entry demonstrates the format.
- [ ] Anonymisation guideline is present and enforceable (a reviewer can tell whether a future entry violates it).
- [ ] Doc is discoverable from the site nav under "Proposal".

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
