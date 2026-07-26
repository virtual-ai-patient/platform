---
layout: default
title: CM — Rev 2 (Current)
parent: Configuration Management
grand_parent: Current — Startup Proposal
nav_order: 2
---

# Configuration Management — Revision 2 (post-pivot: startup proposal)

> **[RETROSPECTIVE — Written July 2026]** This document describes the CM hierarchy and traceability policy as we believe it *should have been* defined from the start of the pivot. In practice the project did not operate by this framework from day one — this is our honest reconstruction of the correct approach, written for the startup proposal. See [About the Pivot](../about-the-pivot.md).

## 1. Artifact Hierarchy

Every artifact in the repository traces back to the project goal through a five-level chain. No GitHub Issue may exist without a reference to a Level 2 or Level 3 artifact.

```text
L1  Goal statement
    docs/product/technical-product-description.md

L2  Evidence artifacts
    docs/proposal/user-insights.md
    Expert meeting notes, interview summaries, corridor-test findings

L3  Hypothesis + validation plan
    docs/proposal/hypotheses.md
    Value Proposition Canvas

L4  GitHub Issues
    Research tasks and prototype tasks with Acceptance Criteria

L5  Prototype version + validation result
    Git commit tagged P1-tag / P2-tag / P3-tag
    Validation finding recorded in L2 artifact
```

### What each level means

| Level | Owner | Changes when… |
|:---|:---|:---|
| L1 | Alina / Karim | Project goal is redefined |
| L2 | Alina | A user interview, expert session, or corridor test is conducted |
| L3 | Karim | A hypothesis is opened, updated, confirmed, or refuted |
| L4 | Karim | A hypothesis needs new work to advance |
| L5 | Ilnar / Timur / Aizat | A prototype iteration is ready for validation |

---

## 2. User Insight — first-class artifact type

A **User Insight** is any finding from a user interview, expert session, or corridor test that advances or challenges a hypothesis. It is recorded in `docs/proposal/user-insights.md` using the template below immediately after the session.

### Template

```markdown
### YYYY-MM-DD — P-XX

- **Date:** YYYY-MM-DD
- **Participant:** P-XX  (anonymous handle — never a name)
- **Method:** interview | corridor test | expert session
- **Context:** One line — what the participant was shown or asked.
- **Key insights:**
  - Observation stated as a finding, not an unsupported conclusion. (≤ 5 items)
- **Linked hypothesis:** H1 | H2 | H3 | none
- **Follow-up issues:** #NNN, or "none yet"
```

### Anonymisation rules

An entry is acceptable only when **all** of the following hold:

- Participant identified by handle only (P-01, P-02 …).
- No personal names, institution names, or identifying role+location combinations.
- No quotation contains re-identifying detail.
- Follow-up issues link to project work, not to private interview material.

A reviewer must request a change before merging any entry that breaks one of these rules.

---

## 3. Traceability rules

Every artifact must satisfy the linkage requirement for its level.

| Artifact | Must reference | Key fields |
|:---|:---|:---|
| **L3 hypothesis** | L1 goal statement | Hypothesis statement, owner, validation method, status |
| **GitHub Issue** | L2 insight entry or L3 hypothesis | AC tied to the hypothesis; linked issue numbers |
| **Git branch** | Issue number in branch name (`feature/NNN-short-name`) | — |
| **Pull Request** | `Closes #NNN`; link to updated doc if doc changed | Confirms no drift from current QA revision |
| **Prototype tag** (L5) | L3 hypothesis being tested | Validation finding recorded in L2 before tag is created |

### Documentation as source of truth

All practice area documents are published at `https://virtual-ai-patient.github.io/platform`. A claim in a GitHub Issue must link to the published URL of the L2 or L3 artifact it derives from — not to a file path.

Example: `Ref: [QA-rev3 — Reproducibility](https://virtual-ai-patient.github.io/platform/qa/qa-rev3#6-reproducibility-qa-repro-new)`

---

## 4. Change trigger — the "Impact Ripple"

Changes propagate **downward** from the level where the change originates. A change at L2 (new insight) may require updates at L3 (hypothesis refined), L4 (new issues), and L5 (prototype iteration replanned). A change at L4 (issue closed) propagates upward only if it closes or refutes a hypothesis.

### Trigger: new user or expert insight (most common)

1. Alina conducts a session and records a User Insight entry in `docs/proposal/user-insights.md`.
2. If the insight changes what a hypothesis claims or how it is validated, Karim updates `docs/proposal/hypotheses.md` (status, validation method, or linked evidence).
3. If the updated hypothesis requires new or changed work, Karim opens or updates GitHub Issues at L4.
4. Team implements; Ilnar / Timur / Aizat update the prototype.
5. When the iteration is ready for validation, the commit is tagged (P1-tag / P2-tag / P3-tag) and the validation finding is recorded as a new L2 entry.

### Trigger: hypothesis refuted

A refuted hypothesis is **not silently dropped**. Karim:

1. Updates `docs/proposal/hypotheses.md` — status → *refuted*, evidence link filled.
2. Opens a retrospective issue: what the finding means and whether a new hypothesis is warranted.
3. Notifies the team at the next Monday planning.

### Trigger: QA revision

If QA attributes change (new `qa-rev(N).md`), Karim reviews open GitHub Issues for AC drift. Any Issue whose AC contradicts the new revision is put on hold and updated before work resumes.

---

## 5. QA revision policy

Non-functional requirements and validation criteria are managed under `/docs/qa/`.

- **Naming:** `qa-rev1.md`, `qa-rev2.md`, `qa-rev3.md` … — never overwrite a previous revision.
- **Current revision:** `qa-rev3.md` (prototype + handoff scope, post-pivot).
- **Changelog:** Every revision ends with a changelog table: date, author, trigger, changes made.
- **AC alignment:** The AC in a GitHub Issue must cite the specific QA attribute it satisfies. Example: *"Verified per QA-REPRO-01: `docker compose up` reaches working demo."*

---

## 6. Definition of Done

### Task (L4 → L5)

A GitHub Issue is **Done** only when:

- [ ] The artifact or code change described in the AC is complete and merged.
- [ ] The linked hypothesis has advanced: new evidence recorded, hypothesis status updated, or — if refuted — a retrospective issue opened.
- [ ] Any updated documentation is live on `https://virtual-ai-patient.github.io/platform`.

"Tests pass" or "PR merged" alone is **not** sufficient to close an issue.

### Prototype iteration (L5)

A prototype iteration (P1 / P2 / P3) is **Done** only when:

- [ ] The hypothesis it targets is explicitly confirmed or refuted.
- [ ] The validation finding is recorded as a User Insight entry (L2).
- [ ] The commit used for the validation session is tagged (`P1-tag`, `P2-tag`, or `P3-tag`).
- [ ] `docs/proposal/hypotheses.md` shows the updated status.

---

## Changelog

| Date | Author | Trigger | Changes |
|:---|:---|:---|:---|
| March 2026 | Karim Abdulkin | Pivot to startup proposal goal; industry partner engagement did not progress | Full rewrite. Replaced six-level product-delivery hierarchy with five-level hypothesis-driven hierarchy (L1 goal → L2 insights → L3 hypotheses → L4 issues → L5 prototype versions). Added User Insight as a first-class artifact type with template and anonymisation rules. Changed Impact Ripple trigger from "customer meeting" to "user or expert session". Updated DoD to require hypothesis advancement, not only code merge. |
