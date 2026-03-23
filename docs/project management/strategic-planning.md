# Strategic Planning — Virtual AI Patient

## 5-Month Roadmap (March – July 2026)

---

## 1. What is Strategic Planning?

Strategic planning defines our **long-term vision, major milestones, and resource allocation** over the remaining project timeline. It answers:

- **What** are we building by July 2026?
- **When** will each major component be delivered?
- **Why** are we prioritizing certain features over others?
- **How** do we ensure we meet our goals despite risks?

For our project, strategic planning covers **5 months** (March–July 2026) and breaks down the work into monthly phases with clear deliverables.

---

## 2. Strategic Overview

### Timeline at a Glance

```text
March      April      May        June       July
└────┬─────┴────┬─────┴────┬─────┴────┬─────┴────┬
Foundation   Core MVP    Medical    MVP        Final
             Complete    Workflow   Complete   Polish
     
EPIC-00      EPIC-01,02  EPIC-05,06 EPIC-07    Testing
EPIC-14      EPIC-03,04  EPIC-08,11 EPIC-10    Documentation
EPIC-13      EPIC-12                EPIC-09    Presentation
```

### Key Milestones

| Milestone | Target Date | Description | Link to Milestone |
|:---|:---|:---| :---|
| **Project Kickoff** | March 1, 2026 | Team formed, repository created | |
| **Foundation Complete** | March 31, 2026 | Repo, CI/CD, basic prototype working | https://github.com/virtual-ai-patient/platform/milestone/1 |
| **MVP Core Complete** | April 30, 2026 | Auth, cases, chat working end-to-end | https://github.com/virtual-ai-patient/platform/milestone/2 |
| **Medical Workflow Done** | May 31, 2026 | Tests, diagnosis, treatment implemented | https://github.com/virtual-ai-patient/platform/milestone/3 |
| **MVP Feature Complete** | June 30, 2026 | Evaluation, debrief, analytics ready | https://github.com/virtual-ai-patient/platform/milestone/4 |
| **Final Presentation** | July 15, 2026 | MVP demo to stakeholders | https://github.com/virtual-ai-patient/platform/milestone/5 |
| **Project End** | July 31, 2026 | Documentation and handover complete | https://github.com/virtual-ai-patient/platform/milestone/6 |

---

## 3. Month-by-Month Breakdown

### Month 1: March — Foundation & Infrastructure

#### March Goals
- Establish development infrastructure
- Create working proof-of-concept
- Set up team processes

#### March Key Deliverables

| Deliverable | Description | Owner | Epic |
|:---|:---|:---|:---|
| **Repository Setup** | Monorepo structure with all directories | Ilnar | EPIC-00 |
| **CI/CD Pipelines** | GitHub Actions for backend, frontend, bot | Ilnar | EPIC-14 |
| **Docker Environment** | Local development with docker-compose | Ilnar | EPIC-14 |
| **Documentation** | README, technical description, QA docs | Alina | EPIC-00 |
| **Basic Chat Prototype** | Simple conversation with synthetic patient | Aizat + Ilnar | EPIC-03 |
| **Database Schema** | Initial design for cases and users | Ilnar | EPIC-13 |
| **Team Processes** | Tactical planning defined and adopted | Alina | — |

#### March Success Criteria
- [ ] New developer can clone repo and run entire stack with one command
- [ ] Basic chat works (user types, AI responds with synthetic data)
- [ ] All documentation in place
- [ ] CI passes on main branch
- [ ] Team following weekly tactical cycle

---

### Month 2: April — Core MVP Features

#### April Goals
- User can log in and access cases
- Full conversational patient with realistic behavior
- Case library functional

#### April Key Deliverables

| Deliverable | Description | Owner | Epic |
|:---|:---|:---|:---|
| **Authentication** | Login/signup, JWT, role-based access | Ilnar | EPIC-01 |
| **Case Library** | Case CRUD, library UI, case details | Ilnar + Timur | EPIC-02 |
| **Conversational Engine** | Full patient dialogue with emotions, progressive info | Aizat | EPIC-03 |
| **AI Safety** | Guardrails, disclaimers, monitoring | Aizat | EPIC-04 |
| **Database Complete** | All migrations, indexed queries | Ilnar | EPIC-13 |
| **API Layer** | FastAPI endpoints for all core functions | Ilnar | EPIC-12 |
| **Login UI** | Flutter screens for auth | Timur | EPIC-08 |

#### April Success Criteria
- [ ] User can register, log in, and log out
- [ ] User can browse available cases
- [ ] User can start a case and have full conversation with AI patient
- [ ] AI responses respect guardrails (no medical advice)
- [ ] Conversation history saved in database

---

### Month 3: May — Medical Workflow

#### May Goals
- Add medical tests ordering
- Capture diagnosis and treatment decisions
- Polish frontend for realistic workflow

#### May Key Deliverables

| Deliverable | Description | Owner | Epic |
|:---|:---|:---|:---|
| **Test Catalog** | 20+ common medical tests available | Ilnar | EPIC-05 |
| **Test Ordering UI** | Interface to select and order tests | Timur | EPIC-05 |
| **Test Results** | Plausible results generated per case | Ilnar | EPIC-05 |
| **Decision Forms** | Diagnosis and treatment plan submission | Timur | EPIC-06 |
| **Telegram Bot** | Basic bot functionality (chat only) | Aizat | EPIC-09 |
| **Frontend Polish** | Improved UI/UX for main workflow | Timur | EPIC-08 |
| **Case Authoring (Basic)** | Educators can create simple cases | Ilnar + Timur | EPIC-11 |

#### May Success Criteria
- [ ] User can order tests during conversation
- [ ] Test results appear and are plausible for the case
- [ ] User can submit differential diagnosis and treatment plan
- [ ] Telegram bot supports basic chat
- [ ] Educator can create a new case via admin interface

---

### Month 4: June — MVP Completion

#### June Goals
- Implement automated scoring and debriefing
- Add analytics dashboard
- Complete all MVP features
- Prepare for pilot testing

#### June Key Deliverables

| Deliverable | Description | Owner | Epic |
|:---|:---|:---|:---|
| **Evaluation Engine** | Compare learner decisions to gold standard | Ilnar | EPIC-07 |
| **Debrief Generation** | Detailed feedback with reference solution | Ilnar + Aizat | EPIC-07 |
| **Case Authoring (Full)** | Complete tools with validation and preview | Timur + Ilnar | EPIC-11 |
| **Analytics Dashboard** | Basic analytics with export functionality | Ilnar + Timur | EPIC-10 |
| **Telegram Bot (Complete)** | Full bot functionality with tests and debrief | Aizat | EPIC-09 |
| **Integration Tests** | Full test suite for all endpoints | Karim | QA-REL |
| **Load Testing** | Simulate 100+ concurrent users | Karim | QA-SCALE |

#### June Success Criteria
- [ ] After completing case, user receives detailed debrief
- [ ] Scoring is consistent and matches gold standard
- [ ] Educator can create, preview, and publish cases
- [ ] Analytics dashboard shows learner progress
- [ ] Telegram bot supports full workflow
- [ ] Test coverage >70%
- [ ] System handles 100 concurrent users without degradation
- [ ] **MVP is feature-complete**

---

### Month 5: July — Final Polish & Delivery

#### July Goals
- Pilot with users
- Bug fixing and performance optimization
- Complete documentation
- Deliver final presentation

#### July Key Deliverables

| Deliverable | Description | Owner | Epic |
|:---|:---|:---|:---|
| **User Testing** | Pilot with 5-10 students | Alina + Karim | — |
| **Feedback Integration** | Incorporate pilot feedback | All | — |
| **Bug Fixing** | Address all critical and high-priority bugs | All | — |
| **Performance Optimization** | Final tuning based on load tests | Ilnar | QA-PERF |
| **Documentation** | User guides, API docs, handover docs | All | — |
| **Final Presentation** | Demo script, slides, live demo | Alina + All | — |
| **Handover** | Repository clean, docs complete, code frozen | All | — |

#### July Success Criteria
- [ ] Pilot users can complete cases independently
- [ ] Feedback collected and analyzed
- [ ] No critical bugs open
- [ ] All documentation complete and accurate
- [ ] Final presentation delivered successfully
- [ ] Project handed over with clear next steps

---

## 5. Critical Path Dependencies

| Dependency | Affected Epics | Risk Level | Mitigation |
|:---|:---|:---|:---|
| **LLM Token Access** | EPIC-03, EPIC-04 | 🔴 High | Use local LLM or mock responses for development |
| **Customer Data/Cases** | EPIC-02, EPIC-11 | 🟡 Medium | Use synthetic data from ChatGPT |
| **NDA / Legal Signing** | All (real data) | 🟡 Medium | Assume synthetic until signed; plan B |
| **Team Availability (May–June)** | All | 🟡 Medium | Plan sprints around known time off |
| **Denis Feedback Timeliness** | All | 🟢 Low | Weekly cycle accounts for feedback |
| **Medical Expert Input** | EPIC-02, EPIC-07 | 🟡 Medium | Denis to connect experts in May–June |

---

## 6. Resource Planning

### Team Capacity Assumptions

| Role | Person | Availability | Notes |
|:---|:---|:---|:---|
| **Backend** | Ilnar | 20 hrs/week | Primary on backend, database, API |
| **Frontend** | Timur | 20 hrs/week | Flutter web, UI/UX |
| **Bot** | Aizat | 15 hrs/week | Telegram bot, AI prompts |
| **PM** | Alina | 15 hrs/week | Coordination, docs, customer communication |
| **QA** | Karim | 15 hrs/week | Testing, test automation, management |

### Total Team Capacity: ~85 person-hours per week

### Effort Estimates by Month

| Month | Focus | Estimated Hours | Confidence |
|:---|:---|:---|:---|
| March | Foundation | 60 hrs | High |
| April | Core MVP | 85 hrs | Medium |
| May | Medical Workflow | 80 hrs | Medium |
| June | MVP Completion | 85 hrs | Medium |
| July | Final Polish | 60 hrs | High |

---

## 7. Risk Management

### Top 5 Risks

| Risk | Probability | Impact | Mitigation |
|:---|:---|:---|:---|
| **LLM access delayed** | High | High | Build with mock LLM; switch later |
| **Team member unavailable** | Medium | Medium | Cross-train; "two is one" principle |
| **Scope creep** | Medium | High | Strict MVP definition; features to backlog |
| **Customer unresponsive** | Low | Medium | Build with synthetic data; document attempts |
| **Medical expert availability** | Medium | Medium | Denis to secure commitments early |

---

## 8. Success Metrics

| Metric | Target | Measurement |
|:---|:---|:---|
| **On-time delivery** | 100% of monthly milestones | Compare actual vs planned |
| **Feature completion** | 100% of MVP features by June 30 | Epic acceptance criteria |
| **Quality** | <10 critical bugs at delivery | Bug tracker |
| **User feedback** | Positive pilot feedback | Pilot surveys |
| **Documentation** | 100% complete by July 31 | Checklist |

---

## 9. Connection to Tactical Planning

```text
Strategic Roadmap (5 months)
    ↓
Monthly Milestones
    ↓
Epics broken into sprint goals
    ↓
Sprint goals → Daily tasks (tactical execution)
    ↓
Daily tasks → Weekly feedback (Denis)
    ↓
Feedback → Adjust next sprint
    ↓
Sprints → Monthly progress
    ↓
Monthly progress → Roadmap achieved
```

---

## 10. Summary: 5-Month Strategic Plan

| Month | Theme | Key Epics | Deliverable |
|:---|:---|:---|:---|
| **March** | Foundation | 00, 14, 13, 03 | Working prototype, infrastructure ready |
| **April** | Core MVP | 01, 02, 03, 04, 12 | Auth, cases, chat complete |
| **May** | Medical Workflow | 05, 06, 08, 11 | Tests, diagnosis, treatment |
| **June** | **MVP Complete** | 07, 09, 10, 11 | **Evaluation, debrief, analytics ready** |
| **July** | Final Polish | All | Pilot feedback, documentation, presentation |

---
