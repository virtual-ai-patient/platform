**Owner:** Ilnar (`ilnarkhasanov`) &nbsp;·&nbsp; **Labels:** `documentation`, `component: backend`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

The CI/CD pipeline description (currently spread across `docs/README.md`, sprint overviews, and the QA doc's changelog — there is no single source doc yet) is framed around **production readiness**: load testing, SAST, coverage gates, deployment automation. Under the pivot, the pipeline's job is different — its goal is **demo stability**. A prototype iteration needs to be reproducibly runnable during a mentor demo or a corridor-test session; nothing more.

Create a single CI/CD document under `docs/cicd/pipeline.md` that describes the *current* pipeline (Ruff, MyPy, pytest, `flutter analyze`), reframes its purpose as demo stability, drops load-testing and SAST as mandatory gates for prototype iterations, and adds **prototype version tagging** (`P1-tag`, `P2-tag`, `P3-tag`) so each hypothesis test is reproducible from a specific commit.

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Create `docs/cicd/pipeline.md` (with a matching `docs/cicd/index.md` if the docs site's Jekyll nav needs it).
- [ ] Document the current pipeline: Ruff → MyPy → pytest → `flutter analyze` → build docker images. Cite the workflow files under `.github/workflows/` by name.
- [ ] Add a **"Pipeline goal"** section: demo stability, not production readiness. State explicitly that load testing and SAST are optional for prototype iterations and only required if the proposal makes a specific claim that needs that evidence.
- [ ] Add a **"Prototype tagging"** section: after each iteration, tag the commit that was used for the validation demo as `P1-tag` / `P2-tag` / `P3-tag`. Store the corresponding validation artifact (expert rating, corridor-test findings) linked from `docs/proposal/hypotheses.md`.
- [ ] Cross-reference from `docs/README.md` and from qa-rev4 (once issue #4 lands).

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] `docs/cicd/pipeline.md` exists and documents the actual current pipeline.
- [ ] "Pipeline goal" section explicitly says "demo stability, not production readiness".
- [ ] Load testing and SAST are documented as optional for prototype iterations, with a rationale.
- [ ] Prototype tagging convention is defined (`P1-tag`, `P2-tag`, `P3-tag`) and links from tag to validation artifact are described.
- [ ] `docs/README.md` links to the new CI/CD doc.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
