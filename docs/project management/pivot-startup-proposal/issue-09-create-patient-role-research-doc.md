**Owner:** Aizat (`muitiiifruckt`) &nbsp;·&nbsp; **Labels:** `documentation`, `component: ai`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

The domain-expert meeting confirmed that similar clinical-training platforms already exist, so the proposal's differentiator is **quality of execution of the LLM patient role** — specifically, believable lying, forgetting, emotional states, and hesitation. This is exactly the P1 hypothesis and Aizat's owned area. Right now the research is scattered across chat, scratch prompts, and personal notes.

Create `docs/proposal/patient-role-research.md` as the consolidated record of what prompt strategies work, what doesn't, and what we recommend for the production system. This document feeds two other artifacts: the LLM Patient Role Design section of the architecture doc (issue #5) and the differentiator claims in `technical-product-description.md` (issue #1). If those claims aren't backed by evidence here, they don't belong in the proposal.

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Create `docs/proposal/patient-role-research.md` with the following top-level sections:
    - **Scope** — what the research covers and what it deliberately excludes.
    - **Method** — models tested, prompt-strategy variants, evaluation setup (expert rater, believability rubric).
    - **Findings per behaviour** — one subsection each for lying, forgetting, emotional states, hesitation. Every subsection: what worked, what didn't, example prompts, believability rating.
    - **Recommendations for production** — the prompt patterns we'd carry forward if the proposal is accepted.
    - **Open questions** — behaviours we couldn't validate in-scope.
- [ ] For each finding, include either (a) a rater score from the expert session or (b) an explicit note that the finding is preliminary and needs validation.
- [ ] Cross-link from the architecture doc's "LLM Patient Role Design" section (issue #5) and from the H1 row in `docs/proposal/hypotheses.md` (issue #8).
- [ ] Register in the Jekyll nav under "Proposal" (same section as hypotheses.md).

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] `docs/proposal/patient-role-research.md` exists with all five top-level sections.
- [ ] Each of the four behaviours (lying / forgetting / emotional states / hesitation) has its own findings subsection.
- [ ] Every finding is either backed by an expert rating or explicitly marked "preliminary — needs validation".
- [ ] "Recommendations for production" section names concrete prompt patterns, not vague guidance.
- [ ] Doc is linked from the architecture doc and from `hypotheses.md`.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
