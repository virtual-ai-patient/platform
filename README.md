# Virtual AI Patient — Monorepo

Welcome to the central repository for the **Virtual AI Patient** platform. This project is a high-fidelity medical simulation environment designed to bridge the gap between theoretical medical knowledge and clinical practice.

## Documentation & Traceability

Our source of truth, including **Quality Attributes (QA)**, **Architecture**, and **Meeting Retrospectives**, is hosted via GitHub Pages:

👉 **[View Official Project Documentation](https://virtual-ai-patient.github.io/platform)**

All changes to this repository must follow the [Configuration Management Policy](https://www.google.com/search?q=https://virtual-ai-patient.github.io/platform/cm/configuration-management) to ensure full traceability from code commits back to client requirements.

---

## Project Overview

**Virtual AI Patient** is a training platform where learners (medical students and junior doctors) navigate a full clinical workflow in a safe, risk-free environment.

### The Context

Medical education often lacks "safe-to-fail" interactive environments. Real-life clinical rotations are limited, and practicing on actual patients is high-risk. Our platform provides a dynamic alternative that mimics real-world diagnostic pressure.

### Problems We Solve

* **Knowledge Gap:** Transitions students from rote memorization to active diagnostic reasoning.
* **Subjective Feedback:** Provides an automated, deterministic evaluation against a medical "Gold Standard."
* **Resource Constraints:** Offers access to diverse clinical cases without needing standardized patient actors.

---

## Monorepo Structure

We use a monorepo approach to ensure atomic changes across the entire stack.

* `backend/` — **FastAPI** service handling session state, medical logic, and AI orchestration.
* `bot/` — **Telegram-bot** interface for mobile-first clinical simulations.
* `frontend/` — **Flutter** web client for an immersive, rich UI experience.
* `docs/` — **Jekyll**-based documentation, requirements, and sprint history.
* `data/` — Clinical case libraries and nosology schemas.

---

## Running the stack (Docker Compose)

From the repository root, Compose brings up **PostgreSQL**, the **FastAPI backend**, the **Flutter web frontend** (nginx), and the **Telegram bot**.

### Prerequisites

* [Docker](https://docs.docker.com/get-docker/) and Docker Compose v2 (`docker compose`).
* **Docker must be running** before you invoke Compose. On macOS, open **Docker Desktop** and wait until it reports that the engine is running. If you see `Cannot connect to the Docker daemon at unix:///.../docker.sock`, the daemon is not started (or your Docker context points at a stopped VM).

### Setup

1. Copy the environment template and edit values (especially `SECRET_KEY` and database credentials if you change them):

   ```bash
   cp .env.example .env
   ```

2. The compose file reads `.env`. It seeds **admin**, **educator**, and a demo **learner** (`LEARNER_USERNAME` / `LEARNER_EMAIL` / `LEARNER_PASSWORD`, default `user` / `user@example.com` / `changeme`). Public signup also creates **learners** only. Educators can create and publish cases; learners see **published** cases in the library. Override these in `.env` for production. Compose applies the same defaults as the backend when variables are missing, so you should not see blank-string warnings after copying `.env.example`.

3. For the **bot** service, set a real token. Either edit `docker-compose.yml` under `bot.environment.TELEGRAM_BOT_TOKEN` or use a Compose override file so you do not commit secrets.

### Start everything

Build images and run all services in the foreground (logs in the terminal):

```bash
docker compose up --build
```

Run detached (in the background):

```bash
docker compose up --build -d
```

Stop and remove containers:

```bash
docker compose down
```

### URLs

| Service  | URL |
| -------- | --- |
| Frontend | [http://localhost:8080](http://localhost:8080) |
| Backend API | [http://localhost:8000](http://localhost:8000) |
| OpenAPI docs | [http://localhost:8000/docs](http://localhost:8000/docs) |

Postgres is available inside the Compose network as host `postgres` on port `5432` (not exposed to the host by default in this file).

### Frontend and the API in Docker

The Flutter web client reads `BACKEND_BASE_URL` at **build** time (`String.fromEnvironment`). The default is `http://localhost:8000`, which matches calling the API from your browser while the backend is published on port `8000`. To point at another host, rebuild the frontend image with a build argument / `dart-define` (for example extend `frontend/Dockerfile` with `ARG BACKEND_BASE_URL` and pass `--dart-define=BACKEND_BASE_URL=...` to `flutter build web`).

---

## Seeding the database (sample clinical cases)

Compose (and the backend on startup) create **users** only. To add **clinical case** rows, use the helper script under `scripts/`. It authenticates as an **educator** and calls `POST /cases` for each JSON fixture, so data ends up in Postgres like any normal API create.

### Prerequisites

* Backend is reachable (for example `docker compose up` with the API on port `8000`).
* The **educator** account exists (Compose seeds `educator` / `changeme` by default, overridable via `.env`).
* `curl` and `python3` on your machine.

### Run

From the repository root:

```bash
./scripts/seed_clinical_cases.sh
```

If the repo root has a `.env` file, the script sources it automatically. You can override the target API and credentials without editing the script:

```bash
BACKEND_BASE_URL=http://localhost:8000 \
EDUCATOR_USERNAME=educator \
EDUCATOR_PASSWORD=changeme \
./scripts/seed_clinical_cases.sh
```

| Variable | Default | Purpose |
| -------- | ------- | ------- |
| `BACKEND_BASE_URL` | `http://localhost:8000` | API base URL (no trailing slash). |
| `EDUCATOR_USERNAME` | `educator` | User that owns the created cases. |
| `EDUCATOR_PASSWORD` | `changeme` | Password for login. |

Fixtures live in `scripts/case_seed/` (for example `seed_em_stemi_001.json`). The script posts each file in order. **HTTP 201** means a new case was stored; **HTTP 409** means that `case_id` already exists and the row is skipped.

To add more sample cases later, drop another valid `POST /cases` JSON file into `scripts/case_seed/` and append its path to the `CASE_FILES` array in `scripts/seed_clinical_cases.sh`.

---

## Team Roles & Responsibilities

| Name | Role | Primary Focus & Artifact Ownership |
| --- | --- | --- |
| **Alina** | **Project Manager** | Sprint management, client liaison, and documentation hierarchy (`/docs/sprints`, `product_description.md`). |
| **Karim** | **Quality Assurance** | Quality Attributes revisions, traceability auditing, and acceptance criteria validation (`/docs/qa/qa-revN.md`). |
| **Ilnar** | **Backend Developer** | FastAPI services, AI orchestration, scoring logic, and database schemas (`/backend`, `/data`). |
| **Timur** | **Frontend Developer** | Flutter web client implementation, UI/UX consistency, and frontend-backend integration (`/frontend`). |
| **Aizat** | **Telegram Bot Dev** | Bot logic, Telegram API integration, and mobile-first simulation flow (`/bot`). |
