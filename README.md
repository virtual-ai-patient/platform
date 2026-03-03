# Virtual AI Patient — Monorepo

This repository consolidates the project into a single codebase:
- `apps/backend` — FastAPI backend (**from `virtual-ai-patient/backend`, branch `login-api`**)
- `apps/bot` — bot service (**from `virtual-ai-patient/bot`**)
- `docs` — product & technical documentation (**from `virtual-ai-patient/docs`**)

## Why monorepo
- Single CI/CD pipeline and shared standards
- Easier cross-service changes and versioning
- One place for onboarding and architecture docs

## Structure
```
apps/
  backend/
  bot/
docs/
.github/
```

## CI/CD
GitHub Actions workflows live in `.github/workflows/` and run jobs per component using path filters.

