# Action Points

### AP-001: Rewrite Configuration Management to Describe Actual Process
- **Owner:** Alina
- **What:** Update `docs/project-management/configuration-management.md` to describe:
  - **Triggers:** Thursday meetings with Denis, sprint reviews
  - **Roles:** PM initiates changes, team reviews, changes committed to docs
  - **Artifact chain:** Meeting minutes → action points → requirement revision → changelog
  - **Tools:** GitHub Issues, markdown docs in `/docs/`
- **Goal:** Mentors can see exactly how requirements flow through our process

---

### AP-002: Add Changelog to All Key Documents
- **Owner:** Karim
- **What:** Add a changelog section to:
  - `technical-product-description.md`
  - `qa/qa-rev1.md`
  - `project-management/strategic-roadmap.md`
- **Format:**
  ```markdown
  ## Changelog
  | Date | Author | Change | Rationale |
  |:---|:---|:---|:---|
  | 2026-03-31 | Alina | Added NDA delay context | Feedback from mentors |
  ```
- **Goal:** Every change is traceable

---

### AP-003: Make Strategic Roadmap Specific to Our Project
- **Owner:** Alina
- **What:** Rewrite `strategic-roadmap.md` to include:
  - **Our constraints:** NDA delay → using synthetic data
  - **Our unknowns:** No medical experts yet → plan for expert validation in May
  - **Our decisions:** Why we prioritize certain features over others
  - **Specific milestones:** Based on our timeline, not generic project phases
- **Goal:** Anyone reading knows *exactly* what we're building and why

---

### AP-004: Add Demo to Next Presentation
- **Owner:** Timur, Ilnar, Aizat
- **What:** Prepare a **live demo** of the current prototype for the next mentor presentation
- **Why:** Mentors couldn't assess technical progress because they didn't see anything running
- **Format:** Short video or live screen share showing:
  - Login screen
  - Case selection
  - Chat with synthetic patient
  - Test ordering (if ready)
- **Goal:** Make technical work visible

---

### AP-005: Add Clickable Links to Presentations
- **Owner:** Alina
- **What:** In all future presentations, add **clickable links** to:
  - GitHub repository
  - Specific docs (e.g., `docs/technical-product-description.md`)
  - Demo video (if recorded)
- **Why:** Mentors don't have time to search; if they can't find it in 2-3 clicks, they assume it doesn't exist

---

### AP-006: Pre-Meeting Sync for Mentor Sessions
- **Owner:** Team
- **What:** Before each mentor meeting, the team should:
  1. Meet for 30 minutes to align
  2. Identify open questions
  3. Assign who will present which part
  4. Prepare materials (links, demo)
- **Why:** Coming unprepared makes the meeting less productive; mentors have limited time

---

### AP-007: Define "Threshold of Success"
- **Owner:** Team
- **What:** Write down what "success" means for our project:
  - Is it a working MVP?
  - Is it a well-documented process?
  - Is it a prototype that can be handed over?
- **Why:** Without this, mentors can't evaluate if we succeeded
- **Format:** Add to `strategic-roadmap.md` as a section "What Success Looks Like"

---

### AP-008: Document Our Actual Decision-Making
- **Owner:** Alina
- **What:** In `docs/decision-logs/`, document key decisions:
  - Why we use synthetic cases (NDA delay)
  - Why we focus on web + Telegram (not mobile)
  - Why we delay medical expert validation until May
- **Why:** Shows mentors we understand *why* we make choices, not just *what* we do

---

## 5. Key Insights from the Meeting

### What Mentors Value Most
1. **Process visibility** — how requirements flow through the team
2. **Specificity** — plans tailored to our project, not generic templates
3. **Traceability** — ability to see why decisions were made
4. **Demonstrated work** — demos, links, visible progress
5. **Team alignment** — coming to meetings as a prepared unit

### Our Strengths (According to Mentor)
- Technical skills are strong
- Repository is well-organized
- Team members are capable

### Our Weaknesses (To Improve)
- Process documentation describes ideal, not actual
- Strategic plan is too generic
- No live demo shown
- Lack of visible traceability (changelogs, decision logs)

---

## 6. Next Steps

| Task | Owner | Due |
|:---|:---|:---|
| Rewrite config management doc | Alina | April 3 |
| Add changelogs to all docs | Karim | April 3 |
| Rewrite strategic roadmap | Alina | April 3 |
| Prepare demo for next presentation | Timur, Ilnar, Aizat | April 10 |
| Add clickable links to presentation | Team | April 10 |
| Pre-meeting sync | Team | Before next mentor meeting |

---

## 7. Summary

The feedback is clear: **document what you actually do**, not what you think you should do. Make your strategic plan **specific to your project**, not a template. And **show your work** — demos and links make technical progress visible.

> "If you can describe your current process, even if it's not perfect, that's a huge plus. Then you can explain how you'll improve it. That's what mentors are looking for."
