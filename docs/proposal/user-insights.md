---
title: User insights
parent: Proposal
nav_order: 3
---

# User Insights

This page is the running **L2 User Insight artifact** defined by
[Configuration Management](../cm/configuration-management.md). It records
interviews, expert sessions, and corridor tests in a consistent format so that
proposal claims can be traced to evidence and linked hypotheses.

## Entry template

Copy this block for every new entry. Keep key insights to five items or fewer.

### YYYY-MM-DD — P-XX

- **Date:** YYYY-MM-DD
- **Participant:** P-XX
- **Method:** interview, corridor test, or expert session
- **Context:** One line describing what the participant was shown or asked.
- **Key insights:**
  - Insight stated as an observation, not an unsupported conclusion.
- **Linked hypothesis:** H1, H2, H3, or none
- **Follow-up issues:** GitHub issue links, or none yet.

## Anonymisation guideline

An entry is acceptable only when all of the following are true:

- the participant is identified by an anonymous handle such as P-01;
- personal names and institution names are not recorded;
- a clinical specialty and a location are never recorded together;
- quotations and context do not contain details that can re-identify the
  participant;
- follow-up issues link to project work, not to private interview material.

A reviewer should request a change before merging any entry that breaks one of
these rules.

## Entries

### 2026-07-22 — P-01

- **Date:** 2026-07-22
- **Participant:** P-01
- **Method:** expert session
- **Context:** Retrospective notes from the first expert interview about training
  value, clinical reasoning errors, and realistic patient simulation.
- **Key insights:**
  - The expert estimated that a comparable product could have substantial
    commercial value (about 20 million; currency was not recorded), but this is
    directional evidence rather than a financial projection.
  - A simulator could save educator time and reduce repeated training of people
    who act as patients in scenario-based teaching.
  - Two serious learner errors are missing a presentation that needs immediate
    escalation and forcing symptoms to fit an early diagnosis.
  - Cases should distinguish subjective patient-reported information from
    objective findings and support a workflow that can include tests, referrals,
    and delayed diagnosis.
  - The patient role should allow emotion, incomplete or false answers,
    confusion, and intoxication instead of modelling an ideal patient.
- **Linked hypothesis:** H1, H3
- **Follow-up issues:** [#81](https://github.com/virtual-ai-patient/platform/issues/81),
  [#85](https://github.com/virtual-ai-patient/platform/issues/85),
  [#88](https://github.com/virtual-ai-patient/platform/issues/88)

### 2026-07-22 — P-02

- **Date:** 2026-07-22
- **Participant:** P-02
- **Method:** expert session
- **Context:** Retrospective notes from the second expert interview about market
  context and the qualities that should differentiate the prototype.
- **Key insights:**
  - Similar products already exist, which supports demand for the concept.
  - Individual features are easy to copy; differentiation should come from the
    quality and consistency of the whole learning experience.
  - Clinical cases need explicit investigation prices, test-to-case
    compatibility, and other constraints that can be assessed.
  - Patient-role immersion depends on believable forgetting, lying, hesitation,
    emotion, and delayed disclosure.
  - The simulator should feel like a diagnostic game, using scarce tests and
    symptom discovery to create a responsible House, M.D.-style puzzle.
- **Linked hypothesis:** H1, H2, H3
- **Follow-up issues:** [#81](https://github.com/virtual-ai-patient/platform/issues/81),
  [#85](https://github.com/virtual-ai-patient/platform/issues/85),
  [#88](https://github.com/virtual-ai-patient/platform/issues/88),
  [#89](https://github.com/virtual-ai-patient/platform/issues/89)
