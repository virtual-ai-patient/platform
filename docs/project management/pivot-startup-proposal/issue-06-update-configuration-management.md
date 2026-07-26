**Owner:** Karim (`GrandAdmiralBee`) &nbsp;·&nbsp; **Labels:** `documentation`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

`docs/cm/configuration-management.md` currently defines a six-level hierarchy (Product Overview → QA → Architecture → Epic → Task → Branch) that made sense when the deliverable was a product. Under the pivot, the "source of truth" chain is different: it starts with the **goal statement** and passes through **user/expert insights**, **hypotheses**, **issues**, and **prototype versions**. Insights and hypotheses are first-class artifacts now — currently they have no home in the CM policy.

Rewrite the artifact hierarchy to the new Level 1–5 structure and add **User Insight** as a first-class artifact type, with a fixed template so every interview and corridor test produces a comparable record. Change triggers must also be updated: the ripple no longer starts with a customer requirement change — it starts with a new user or expert insight.

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Rewrite section 1 ("Hierarchy of Artifacts") to the new five levels:
    - L1 Goal statement.
    - L2 Expert meeting notes + user interview summaries.
    - L3 Hypothesis per prototype iteration + Value Proposition Canvas.
    - L4 GitHub Issues (research + prototype tasks).
    - L5 Prototype version + validation results.
- [ ] Update section 4 ("Impact Ripple") — trigger is now a new user or expert insight (Alina writes summary → Karim opens/updates issues → team updates prototype → Karim validates against hypothesis DoD).
- [ ] Add a new section **"User Insight artifact type"** with a fixed template: date, participant (anonymised handle), method (interview / corridor test / expert session), key insights (bulleted), linked hypothesis, follow-up issues.
- [ ] Update the QA revision policy to reference qa-rev4 (once issue #4 lands) — leave a placeholder line if that issue is not yet resolved.
- [ ] Remove references to "customer meeting" as the change trigger; replace with "user or expert session".

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] Artifact hierarchy has exactly five levels and matches the pivot document.
- [ ] "User Insight" section includes a copy-pasteable template with all five fields (date / participant / method / insights / linked hypothesis).
- [ ] Change-trigger workflow starts with a user or expert insight, not a customer meeting.
- [ ] All references to "Level 6 Git Branches & Commits" are either removed or renumbered — the new hierarchy stops at L5 (prototype version).
- [ ] Doc renders cleanly on the docs site.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
