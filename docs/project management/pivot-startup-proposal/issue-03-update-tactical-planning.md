**Owner:** Karim (`GrandAdmiralBee`) &nbsp;·&nbsp; **Labels:** `documentation`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

`docs/project management/tactical-planning.md` describes a weekly rhythm oriented around delivering features to Denis on Thursday. The weekly rhythm itself stays (Monday planning, Wednesday sync, Thursday mentor demo, Friday retro), but the *content* of a sprint changes: tasks are no longer feature-delivery items but research and validation tasks that advance a hypothesis.

The document needs a new **hypothesis-closure ritual** section — who decides that a hypothesis is validated / refuted, when that decision happens, and what artifact records it. It also needs an updated **Definition of Done**: a task is done only when both (a) the artifact is created and (b) the linked hypothesis has advanced (new evidence, refined claim, or closed). "Tests pass" is no longer sufficient by itself.

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Keep section 2 ("Weekly Tactical Rhythm") as-is except: rename "Denis Feedback Session" to "Mentor / Expert Feedback Session" and add a note that this is where hypothesis-closure decisions happen.
- [ ] Add a new section **"Hypothesis closure ritual"**: trigger (evidence collected), decision-maker (Karim + owner of the hypothesis), artifact updated (`docs/proposal/hypotheses.md`), and how a refutation is handled (open a new issue, do not silently drop).
- [ ] Update the **Definition of Done** section (or add it if not present) with two parts: DoD-task (artifact created **and** hypothesis advanced) and DoD-iteration (hypothesis explicitly confirmed or refuted with linked evidence).
- [ ] Add a **Traceability rule** line: every issue references at least one Level 2 or Level 3 artifact (per `docs/cm/configuration-management.md`).
- [ ] Remove any wording that implies feature-count velocity as a success metric.

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] "Hypothesis closure ritual" section exists and names decision-maker, trigger, and updated artifact.
- [ ] DoD is expressed in two parts (task-level and iteration-level), and both require hypothesis advancement — not only test/lint success.
- [ ] Weekly rhythm still shows Monday planning + Thursday mentor session + Friday retro (nothing is lost).
- [ ] Traceability rule appears in the doc and points to `docs/cm/configuration-management.md`.
- [ ] No mention of "features shipped per sprint" as a success metric.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
