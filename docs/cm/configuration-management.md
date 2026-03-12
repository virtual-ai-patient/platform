
# Configuration Management & Traceability Policy — Virtual AI Patient

## 1. The Hierarchy of Artifacts

To maintain a strict "Chain of Truth," every artifact in the repository follows a specific hierarchy. No development task may exist without a reference to a higher-level requirement revision.

1. **Level 1: Product Overview (`/docs/product/technical-product-description.md`)** – High-level vision and business boundaries.
2. **Level 2: Quality Attributes (`/docs/qa/qa-rev(N).md`)** – Technical benchmarks and performance metrics.
3. **Level 3: Architecture & Design (`/docs/architecture/`)** – System diagrams and technical specifications.
4. **Level 4: GitHub Epics** – Business value units containing User Stories and Dependencies.
5. **Level 5: GitHub Tasks** – Atomic implementation units with specific Acceptance Criteria (AC).
6. **Level 6: Git Branches & Commits** – The physical code implementation.

## 2. Traceability & Linkage Rules

Every artifact must be bi-directionally linked using the following "Thread of Integrity."

### 2.1. Documentation as the Source of Truth

All high-level documentation is hosted at: `https://virtual-ai-patient.github.io/platform`.

* **Epics** must include a **"Documentation Reference"** section in their description, linking to the specific `qa-rev(N).md` or Architecture page they implement.
* **Example:** `Ref: [QA-Rev3 - Latency Requirements](https://virtual-ai-patient.github.io/platform/qa/qa-rev3)`.

### 2.2. The Implementation Chain (Code to QA)

To ensure every line of code serves a requirement, the following mapping is mandatory:

| Artifact | Linkage Requirement | Key Metadata to Include |
| --- | --- | --- |
| **GitHub Epic** | URL to `technical-product-description.md` or `qa-rev(N).md` | User Story, Dependencies, Epic-level AC. |
| **GitHub Task** | Parent Epic ID (#Number) | Technical AC, link to Architecture doc if applicable. |
| **Git Branch** | Task ID in branch name (e.g., `feature/#123-ai-tone`) | Link to the Task being solved. |
| **Pull Request** | Task ID and Link to updated Docs | "Closes #123"; confirms no drift from `qa-rev(N).md`. |

## 3. Quality Attributes (QA) Revision Policy

Non-functional requirements are managed in the `/docs/qa/` directory.

* **Naming:** Files are named `qa-rev(N).md` (e.g., `qa-rev1.md`).
* **Changelog:** Every revision must conclude with a summary of changes, the reason for the change, and a link to the `action-points.md` from the meeting that triggered it.
* **Acceptance Criteria (AC) Alignment:** The AC in a GitHub Task must be a direct derivative of the current `qa-rev(N).md`. If the QA rev says "AI response $\le$ 5s", the Task AC must explicitly state: *"Verify response time is $\le$ 5s per qa-rev(N)"*.


## 4. Traceability Workflow: The "Impact Ripple"

When a change occurs, the following "ripple" must be executed to prevent documentation-code drift:

1. **Trigger:** A client meeting results in an `action-point.md` to change the Evaluation scoring logic.
2. **Doc Update:** The Analyst creates a new `qa-rev(N+1).md` at `https://virtual-ai-patient.github.io/platform/qa/qa-rev(N+1)`.
3. **Epic Revision:** The corresponding GitHub Epic is updated. The "Documentation Reference" link is changed to the new URL.
4. **Task Validation:** Existing Tasks under that Epic are reviewed. If their Acceptance Criteria contradict the new QA revision, they are put on "Hold" and updated.
5. **Code Alignment:** Developers update the branch implementation to meet the new AC defined by the revised QA document.


## 5. Definition of Done (DoD)

A Task or Epic is only considered "Done" if:

* [ ] The code passes all technical Acceptance Criteria.
* [ ] The implementation is verified against the linked `qa-rev(N).md` metrics.
* [ ] The documentation on `https://virtual-ai-patient.github.io/platform` reflects the current state of the feature.
