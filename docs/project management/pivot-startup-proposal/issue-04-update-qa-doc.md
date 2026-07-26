**Owner:** Karim (`GrandAdmiralBee`) &nbsp;·&nbsp; **Labels:** `documentation`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

`docs/qa/qa-rev3.md` already trimmed production-grade NFRs down to prototype hygiene (repro + docs + basic safety). With the further pivot to a **startup proposal**, the QA doc needs one more pass: thresholds must now be **proposal-validation criteria**, and each threshold must be traceable to either a **domain-expert insight** or a **user interview finding** — not to a hypothetical customer requirement.

The concrete new criteria (patient-role believability ≥ 4/5, case-system usability, 30-min demo stability, hypothesis coverage, proposal-claim traceability) come from the pivot planning document. Each of them must land in the QA doc with an explicit **rationale link** to the artifact that motivated it (expert meeting notes for role believability, user interviews for usability, and so on).

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Open a new revision `docs/qa/qa-rev4.md` (do not overwrite rev3 — the changelog rule requires a new file).
- [ ] Add five validation criteria as first-class attributes:
    - Patient role believability — expert rates ≥ 4/5.
    - Case system usability — user completes P2 case unassisted.
    - Prototype stability — no crash during a 30-minute demo.
    - Hypothesis coverage — all three hypotheses tested before final presentation.
    - Proposal claim traceability — every claim in the proposal links to a Level 2 artifact.
- [ ] For each criterion, add a **Rationale** field with a link to the source artifact (`docs/proposal/user-insights.md`, expert-meeting notes, etc.).
- [ ] Keep QA-REPRO and QA-DOC categories from rev3 — those still apply to the prototype-artifact side.
- [ ] Drop QA-PERF-01/02/03 if they no longer serve the proposal (chat latency ≤ 2s is still nice, but only if the demo-stability criterion doesn't already cover it — decide and justify in the changelog).
- [ ] Add a changelog entry pointing to this pivot document as the trigger.
- [ ] Update `docs/qa/index.md` nav order so rev4 appears at the top of the QA history.

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] `docs/qa/qa-rev4.md` exists with the five new validation criteria.
- [ ] Every criterion has a Rationale field pointing to either an expert-meeting artifact or a user-insight artifact.
- [ ] Changelog entry names the pivot as the trigger and lists what was dropped from rev3 and why.
- [ ] `docs/qa/qa-rev3.md` remains untouched (historical record).
- [ ] Jekyll build renders rev4 in the QA nav without errors.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
