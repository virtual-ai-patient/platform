---
layout: default
title: Pipeline
parent: CI/CD
nav_order: 1
---

# CI/CD Pipeline
**Document Version:** 1.0
**URL:** [virtual-ai-patient.github.io/platform/cicd/pipeline](https://virtual-ai-patient.github.io/platform/cicd/pipeline)

## 1. Overview

Before this document, the pipeline was described piecemeal — a mention in
[Sprint 03 Overview](../sprints/sprint03/architecture.md), a line in
[Sprint 05 Overview](../sprints/sprint05/overview05.md), and the jobs
themselves in `.github/workflows/`. This is the single source of truth for
what the pipeline runs and why.

## 2. Pipeline goal

**Demo stability, not production readiness.**

Before the pivot, the pipeline was being built out toward a production
deployment: load testing, a SAST stage, and coverage gates aimed at an
industry-partner handoff. Under the current goal — a validated startup
proposal backed by a working prototype (see
[qa-rev3](../qa/qa-rev3.md)) — that bar is the wrong one. What actually
matters is that a specific commit reliably comes up and runs during a mentor
demo or a corridor-test session.

Load testing and SAST are **not** run today, and are **optional** for
prototype iterations going forward. They're worth adding only if a specific
proposal claim needs that evidence to back it up (e.g. a scalability claim
under [qa-rev2](../qa/qa-rev2.md) would need load-test evidence — but
QA-SCALE is suspended under the current [qa-rev3](../qa/qa-rev3.md), so
that trigger hasn't fired). Until then, they'd cost CI time without
supporting anything the proposal actually asserts.

## 3. Current pipeline

Orchestrated by [`ci.yml`](https://github.com/virtual-ai-patient/platform/blob/main/.github/workflows/ci.yml),
which only runs the jobs affected by a given change (via `dorny/paths-filter`).

| Job | Workflow file | Steps |
| :--- | :--- | :--- |
| Backend | [`backend-quality.yml`](https://github.com/virtual-ai-patient/platform/blob/main/.github/workflows/backend-quality.yml) | Ruff → MyPy (`--strict`) → pytest (coverage ≥ 80%) → build Docker image |
| Bot | [`bot-quality.yml`](https://github.com/virtual-ai-patient/platform/blob/main/.github/workflows/bot-quality.yml) | Ruff → MyPy → pytest (if configured) → build Docker image |
| Frontend | [`frontend-quality.yml`](https://github.com/virtual-ai-patient/platform/blob/main/.github/workflows/frontend-quality.yml) | `dart format` (check) → `flutter analyze` → `flutter test` → `flutter build web` → build Docker image |
| Docs | [`docs-quality.yml`](https://github.com/virtual-ai-patient/platform/blob/main/.github/workflows/docs-quality.yml) | markdownlint over `docs/**/*.md` |

Every job builds a Docker image as its last step so a green run always leaves
behind something runnable — the thing the demo-stability goal actually cares
about, more than the coverage number.

## 4. Prototype tagging

Each prototype iteration (P1, P2, P3 — see
[hypotheses.md](../proposal/hypotheses.md)) is reproducible from one commit:
after the validation session for that iteration, the owner tags the commit
that was actually demoed as `P1-tag`, `P2-tag`, or `P3-tag`.

This is the **L5** artifact in the configuration-management hierarchy (see
[configuration-management-rev2.md](../cm/configuration-management-rev2.md)) —
a prototype version paired with a validation result. The tag itself only
marks the commit; the validation finding it produced (expert rating,
corridor-test notes) is recorded as an **L2** entry in
[user-insights.md](../proposal/user-insights.md) and linked from the
matching hypothesis in [hypotheses.md](../proposal/hypotheses.md).

| Tag | Iteration | Hypothesis | Validation artifact |
| :--- | :--- | :--- | :--- |
| `P1-tag` | P1 | [H1 — Patient Role](../proposal/hypotheses.md#h1--patient-role) | Expert rubric session — recorded in user-insights.md, linked from H1's Evidence field once closed |
| `P2-tag` | P2 | [H2 — Case System](../proposal/hypotheses.md#h2--case-system) | Corridor test — recorded in user-insights.md, linked from H2's Evidence field once closed |
| `P3-tag` | P3 | [H3 — Full Loop](../proposal/hypotheses.md#h3--full-loop) | Structured feedback session — recorded in user-insights.md, linked from H3's Evidence field once closed |

A hypothesis is not closed until its Evidence field points at the L2 entry —
the tag alone doesn't close it.

## 5. Traceability

- [qa-rev3](../qa/qa-rev3.md) — QA-REPRO (`docker compose up`, seed script, mock LLM) and QA-DOC drove what "reproducible" means for this pipeline.
- [qa-rev4](../qa/qa-rev4.md) — QA-VAL criteria are what each `P*-tag` validation session is measured against.
- [hypotheses.md](../proposal/hypotheses.md) — owns the P1/P2/P3 iteration ↔ hypothesis mapping this doc's tagging table mirrors.

## Changelog

| Date | Revision | Author | Trigger / Source | Changes Made |
| :--- | :--- | :--- | :--- | :--- |
| 26-07-2026 | 1.0 | Ilnar Khasanov | [Issue #87](https://github.com/virtual-ai-patient/platform/issues/87) | Consolidated pipeline description into a single doc; reframed goal as demo stability; documented load-testing/SAST as optional; defined prototype tagging convention. |
