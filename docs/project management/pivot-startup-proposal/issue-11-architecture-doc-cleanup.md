**Owner:** Ilnar (`ilnarkhasanov`) &nbsp;·&nbsp; **Labels:** `documentation`, `component: backend`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

`docs/architecture/system-architecture.md` has already been partially updated for the prototype scope: nginx is out of the main diagrams and each diagram has a type label (Diagram 1 — Static component view, Diagram 2 — Dynamic session flow, Diagram 3 — Deployment view). What is still missing is a sweep for consistency with the current QA revision, plus a formal diagram-notation reference so mentors don't have to ask "what kind of diagram is this?" during the demo.

This issue covers three cleanup passes: (a) remove any remaining nginx references outside the main diagrams (integration notes, sprint docs, README fragments), (b) cross-link every architectural claim to the current `qa-rev3.md`, and (c) attach an explicit notation reference to each diagram (which UML/C4/mermaid family it belongs to) so a reviewer can name what they are looking at without asking.

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Sweep the whole `docs/` tree for `nginx` references (`grep -r nginx docs/`) and remove anything left over from the pre-pivot deployment view — including in `docs/integrations/`, sprint overviews, and `docs/README.md`. Any nginx config that must persist for developer reference moves into a separate `docs/architecture/deployment-notes.md` and is called out as "developer-only, not part of the proposal view".
- [ ] Add a **"QA compliance"** subsection to `system-architecture.md` that lists which QA-rev3 attributes each architectural decision satisfies (e.g. AIProvider abstraction → QA-ARCH-01, action_logs → QA-ARCH-02, mock LLM → QA-REPRO-02). Every bullet links to the corresponding line in `docs/qa/qa-rev3.md`.
- [ ] Under each of the three diagrams, add a one-line **notation** tag naming the diagram family concretely — for example:
    - Diagram 1: "C4 model, Level 2 (Container diagram) rendered with mermaid `flowchart TB`."
    - Diagram 2: "UML sequence diagram rendered with mermaid `sequenceDiagram`."
    - Diagram 3: "UML deployment diagram rendered with mermaid `flowchart LR`."
- [ ] Add a short **"Diagram legend"** section at the top of the doc explaining what a container / sequence / deployment diagram *is* and what it *isn't*, so a reviewer can map them to standard notation without asking.
- [ ] Verify the doc still renders on the Jekyll site (`bundle exec jekyll build` locally or a preview PR).

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] `grep -ri nginx docs/` returns nothing except an intentional mention in `deployment-notes.md` (if that file is kept).
- [ ] `system-architecture.md` has a "QA compliance" subsection with at least one QA-rev3 reference per architectural decision.
- [ ] Each of the three diagrams has an explicit notation tag naming its family (container / sequence / deployment).
- [ ] A "Diagram legend" section explains the three notations in one paragraph each.
- [ ] Jekyll build succeeds; no broken internal links.
- [ ] Does not touch the LLM Patient Role Design section (that is issue #5's scope).

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
