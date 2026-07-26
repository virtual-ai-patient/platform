# Pivot to startup proposal — documentation update issues

The customer engagement (Third Opinion) ended because of an NDA
blocker with Innopolis University. With two weeks left in the course,
the coordinator approved a pivot: instead of shipping a product to a
customer, the team delivers a **startup proposal backed by a validated
prototype**.

This folder contains the GitHub-style issues (task-template format)
for realigning every practice-area document to that new goal. Each
issue is scoped to one document and one owner; together they cover
the full documentation set required for the final presentation.

## Summary table

| # | Title | Owner (GitHub) | Labels |
|---|---|---|---|
| 01 | Reframe `technical-product-description.md` as startup-proposal context | Alina (`rayderdo`) + Timur (`timur-harin`) | `documentation` |
| 02 | Rewrite Strategic Planning as Discovery → P1/P2/P3 → Proposal Finalisation | Karim (`GrandAdmiralBee`) | `documentation` |
| 03 | Rewrite Tactical Planning around hypothesis-closure ritual and new DoD | Karim (`GrandAdmiralBee`) | `documentation` |
| 04 | Replace QA thresholds with proposal-validation criteria | Karim (`GrandAdmiralBee`) | `documentation` |
| 05 | Add LLM Patient Role Design section to `system-architecture.md` | Aizat (`muitiiifruckt`) | `documentation`, `component: ai` |
| 06 | Update Configuration Management to the new Level 1–5 hierarchy + User Insight artifact | Karim (`GrandAdmiralBee`) | `documentation` |
| 07 | Reframe CI/CD doc from production-readiness to demo-stability; add prototype tagging | Ilnar (`ilnarkhasanov`) | `documentation`, `component: backend` |
| 08 | Create `docs/proposal/hypotheses.md` (living hypothesis tracker for P1/P2/P3) | Karim (`GrandAdmiralBee`) | `documentation` |
| 09 | Create `docs/proposal/patient-role-research.md` (Aizat's LLM findings) | Aizat (`muitiiifruckt`) | `documentation`, `component: ai` |
| 10 | Create `docs/proposal/user-insights.md` (running log of interviews + corridor tests) | Alina (`rayderdo`) | `documentation` |
| 11 | Architecture doc cleanup — final nginx sweep, qa-rev3 cross-refs, formal diagram-notation labels | Ilnar (`ilnarkhasanov`) | `documentation`, `component: backend` |
| 12 | Online docs cleanup — split site nav into "Current — Startup Proposal" and "Historical — Product for Customer" | Karim (`GrandAdmiralBee`) | `documentation` |

## Iteration → owner map

| Iteration | Hypothesis | Owner |
|---|---|---|
| P1 — Patient Role | LLM can convincingly simulate lying, forgetting, and emotional states | Aizat |
| P2 — Case System | Constrained test budget changes how learners reason | Ilnar + Timur |
| P3 — Full Loop | Complete flow feels like a game, not a form | All |

## New artifact hierarchy (Level 1–5)

```
L1  Goal statement (this pivot document)
L2  Expert meeting notes + user interview summaries
L3  Hypothesis per prototype iteration + Value Proposition Canvas
L4  GitHub Issues (research + prototype tasks)
L5  Prototype version + validation results
```

Change trigger: new insight from user interview or expert session
→ Alina writes insight summary → Karim creates/updates issues
→ team updates prototype → Karim validates against hypothesis DoD.
