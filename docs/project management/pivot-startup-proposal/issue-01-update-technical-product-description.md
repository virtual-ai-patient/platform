**Owners:** Alina (`rayderdo`) &nbsp;·&nbsp; Timur (`timur-harin`) &nbsp;·&nbsp; **Labels:** `documentation`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

The customer engagement (Third Opinion) ended over an NDA blocker with Innopolis University. The course coordinator approved a pivot: instead of delivering a product to a real customer, the team delivers a **startup proposal backed by a validated prototype**. `docs/product/technical-product-description.md` currently reads as a product spec addressed to a customer — it needs to be reframed as the product-context section of that proposal.

The reframed document should explain: what problem we address, why the market is validated (similar platforms exist), and why we can compete despite that (quality of execution — patient-role realism, structured case system, game mechanics). It should also state explicitly that business modelling and financial projections are out of scope, so a reviewer understands the SE-course boundary rather than reading it as a gap.

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Replace section 1 ("Product summary") with a **Problem statement** and a **Market context** paragraph (similar platforms exist; differentiation is quality of execution — per the domain-expert meeting).
- [ ] Rewrite the users section to keep the same three roles (learner / educator / admin) but frame each around what the *prototype* demonstrates, not what a shipped product would do.
- [ ] Add a **Differentiators** section: LLM patient role quality (lying / forgetting / emotions / hesitation), constrained-resource case system (test budget + test–case compatibility), game mechanics (Doctor House reference).
- [ ] Add an explicit **Scope boundaries** section: no business model, no financial projections, no go-to-market — with a one-line rationale ("SE-course scope; business analysis would be speculation without real market data").
- [ ] Remove or trim any requirement worded as a customer commitment (SLAs, integration guarantees, milestone dates tied to Third Opinion).
- [ ] Cross-link the doc from `docs/README.md` and from `docs/proposal/hypotheses.md` once that file exists.

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] The document opens with a problem statement + market-context paragraph, not with a product summary.
- [ ] "Differentiators" section names all three: patient role quality, constrained case system, game mechanics.
- [ ] "Scope boundaries" section explicitly lists what is out of scope (business model, financials, GTM) and why.
- [ ] No requirement in the document reads as a commitment to a specific customer or a specific pilot deployment.
- [ ] `docs/README.md` link to `technical-product-description.md` still resolves; the doc renders cleanly with the site's Jekyll build (no broken links, no leftover TODOs).

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
