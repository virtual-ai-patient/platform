**Owner:** Karim (`GrandAdmiralBee`) &nbsp;·&nbsp; **Labels:** `documentation`

### <h2> Task Description & Context <a id="task-description-and-context" href="#task-description-and-context">🔗</a> </h2>

The published docs site (`https://virtual-ai-patient.github.io/platform`) currently mixes documents written under the **old goal** (medical training product for a customer) with documents written under the **new goal** (startup proposal). Right now a mentor or reviewer opening the site can't tell at a glance which docs still apply and which are historical — the nav is flat and the old artefacts (market assessment, pilot-oriented product description, old QA revisions, epic-driven strategic plan) sit next to the current ones.

Restructure the online docs so the pivot is visible on the landing page. Two top-level sections: **"Current — Startup Proposal (post-pivot)"** and **"Historical — Product for Customer (pre-pivot)"**, each with its own sub-nav. Historical documents are not deleted — they stay reachable, but under an explicit "historical" bucket so nobody accidentally cites them as current. A short note at the top of the landing page explains the pivot in two sentences and points to the current section.

### <h2> Subtasks <a id="subtasks" href="#subtasks">🔗</a> </h2>

- [ ] Rewrite `docs/index.md` (landing page): a two-paragraph intro naming the pivot (old goal → new goal), then two clearly labelled sections — **"Current — Startup Proposal"** and **"Historical — Product for Customer"** — each with a linked list of documents in that bucket.
- [ ] Audit every doc under `docs/` and assign it to one bucket:
    - **Current:** qa-rev3 (and rev4 once it lands), current `system-architecture.md`, `technical-product-description.md` (after issue #1 lands), pivoted planning docs, everything under `docs/proposal/`, current sprint, `cm/`, `cicd/` (once issue #7 lands).
    - **Historical:** qa-rev1, qa-rev2, `docs/market/market-assessment.md`, pre-pivot sprint overviews (sprint01–05), any epic/roadmap references to the discontinued 5-month product timeline, integration notes tied to Third Opinion.
- [ ] Update the Jekyll nav (`_config.yml` and per-file `parent:` / `nav_order:` frontmatter) so the two buckets are the top-level nav entries, and each historical doc has a visible "**Historical (pre-pivot)**" badge in its title.
- [ ] Add a short **"About the pivot"** page (`docs/about-the-pivot.md`) that explains the goal change, links to the pivot planning document, and is reachable from both buckets.
- [ ] Verify all internal links after the reorg (`bundle exec jekyll build --strict-front-matter` or a link checker) — any doc referencing a moved page must be updated.
- [ ] Post a short note in `#docs` / team chat once the site is republished so the team stops citing historical docs by accident.

### <h2> Task Acceptance Criteria <a id="task-acceptance-criteria" href="#task-acceptance-criteria">🔗</a> </h2>

- [ ] Landing page opens with a two-paragraph explanation of the pivot.
- [ ] Nav has exactly two top-level buckets: **Current — Startup Proposal** and **Historical — Product for Customer**.
- [ ] Every document under `docs/` is assigned to exactly one bucket; nothing is orphaned.
- [ ] Every historical page shows a visible "**Historical (pre-pivot)**" badge in its title or top-of-page banner.
- [ ] `docs/about-the-pivot.md` exists and is linked from both buckets.
- [ ] Jekyll build succeeds with no broken internal links.
- [ ] Old QA revisions (rev1, rev2) remain reachable — nothing is deleted, only reorganised.

### <h2> Sub-issues <a id="sub-issues" href="#sub-issues">🔗</a> </h2>

Sub-issues are blockers for this task.
