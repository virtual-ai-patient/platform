# Technical Specification (with Quality Metrics) — Virtual AI Patient

## 0. Scope and goals
### 0.1 Goal (6-month outcome)
Deliver and pilot a training platform that enables learners to complete the full clinical workflow:
history → investigations → diagnosis → treatment → debriefing.

**MVP deliverables**
- ≥ **50** realistic, dynamic clinical cases (published, runnable end-to-end)
- investigation ordering + realistic result generation
- automated evaluation vs case gold standard (diagnosis, diagnostics, treatment)
- integration-ready APIs for embedding into a physician platform

### 0.2 Non-goals (MVP boundaries)
- Not intended for real patient medical advice.
- No claims of clinical decision support.
- No use of real patient personal data in the case library.

## 1. System overview
### 1.1 Tech stack (planned)
- **Backend**: Python + FastAPI
- **Frontend**: Flutter
- **AI services**: OpenAI-compatible API (token-based); provider-agnostic adapter

### 1.2 High-level modules
- **Flutter client**
  - chat UI (patient dialogue)
  - investigation ordering UI
  - structured submission UI (DDx / diagnosis / plan)
  - debrief & score UI
- **FastAPI backend**
  - auth + partner integration (SSO/OAuth)
  - case catalog + case sessions
  - dialogue orchestration
  - investigation ordering + result generation
  - evaluation + scoring + debrief composition
  - analytics export
- **AI Orchestrator (backend component)**
  - system/prompt templates
  - tool/function calling
  - policy/guardrails layer
  - OpenAI-compatible provider adapter (API key/token)
- **Data store**
  - case library (structured)
  - session state, orders, messages
  - evaluation artifacts

## 2. Core workflows
### 2.1 Case run (learner)
1. Learner selects/launches a case.
2. Chat begins; patient provides initial complaint.
3. Learner asks questions; system returns patient messages.
4. Learner orders investigations (labs/instrumental).
5. System returns results (pre-authored or generated).
6. Learner submits:
   - differential diagnosis (ranked)
   - final diagnosis
   - management plan
7. System evaluates and shows:
   - score breakdown
   - key omissions/errors
   - safety issues
   - reference (gold) solution

### 2.2 Case authoring and publishing (expert)
1. Expert creates a case draft in a standardized schema.
2. Automated validation runs (required fields, consistency).
3. Reviewer approval.
4. Case becomes publishable; versioned and immutable for scoring reproducibility.

## 3. Clinical case model (MVP)
The case schema MUST support:
- Patient profile: demographics, context, baseline health literacy
- Presenting complaint + timeline
- Ground truth: final diagnosis (and optionally ICD/SNOMED mapping later)
- Key findings: must-ask history items, physical exam (if in scope), red flags
- Investigation expectations: must-have, optional, and “should not order”
- Gold standard plan: diagnostics + treatment + follow-up + contraindications
- Scoring rubric: weights, acceptable variants/synonyms, safety rules
- Conversation controls: tone presets, partial-recall behavior settings

Case format details are defined in `data/clinical-case-format.md`.

## 4. Dialogue orchestration requirements
### 4.1 Case grounding
All patient responses MUST be grounded in the case truth (or plausible gaps):
- No contradictions vs known case facts.
- If information is unknown, patient should respond naturally (“I’m not sure”, “I don’t remember”).
- Progressive disclosure: do not reveal full history unless asked.

### 4.2 Tone control
Tone presets (MVP):
- neutral
- anxious
- irritated/defensive
- distressed

Tone affects wording, brevity, and emotional expressions, but MUST NOT change medical facts.

### 4.3 Safety guardrails (training context)
The system MUST prevent:
- instructions that could plausibly cause real-world harm if copied directly outside the simulation,
- content outside the case scope (e.g., illegal drugs, self-harm guidance),
- disclosure of “hidden gold standard” unless the debrief phase is active.

## 5. Investigation ordering + result generation
### 5.1 Investigation catalog
Backend provides a controlled catalog of available tests:
- labs: CBC, CMP, CRP, troponin, etc.
- instrumental: ECG, ultrasound, x-ray, CT (MVP may return text reports)

### 5.2 Result source priority
1) Use case-authored result if available.  
2) Otherwise generate a plausible result consistent with:
   - case diagnosis and severity,
   - demographics and comorbidities,
   - timeline (early vs late disease),
   - previously returned results (internal consistency).

### 5.3 Consistency checks
At minimum, results must pass rule-based checks (MVP):
- units/ranges are coherent,
- gross contradictions are blocked (e.g., “STEMI” narrative but normal troponin + normal ECG with no explanation).

## 6. Evaluation and scoring
### 6.1 What is evaluated (MVP)
- **Diagnosis**: correctness (exact/acceptable), severity recognition where relevant
- **Diagnostic plan**: must-have tests ordered, unnecessary tests flagged
- **Treatment plan**: alignment with gold standard, contraindications, missed safety steps

Communication scoring can be included as “informational feedback” in MVP and made graded in later versions.

### 6.2 Scoring outputs
For each session produce:
- total score (0–100)
- sub-scores (diagnosis / diagnostics / treatment / safety)
- structured error list (type, severity, evidence)
- reference (gold) solution summary

### 6.3 Explainability requirements
For every deduction the debrief MUST include:
- what was expected,
- what the learner did,
- why it matters clinically (short),
- how to correct it (reference action).

## 7. Integration requirements (pilot)
### 7.1 Authentication
Support one of:
- OAuth/OIDC with partner platform, or
- signed launch token (JWT) from partner → backend session creation.

### 7.2 APIs (conceptual, MVP)
The backend MUST expose endpoints to:
- list cases available for a user/cohort
- create a case session
- send/receive chat messages
- list investigations catalog
- order investigations and retrieve results
- submit final answer package (DDx/diagnosis/plan)
- retrieve debrief + scores
- export analytics (cohort-level)

## 8. Quality metrics (with rationale)
Metrics are defined to ensure the platform is:
1) educationally useful, 2) clinically plausible, 3) safe, 4) usable at scale, 5) measurable during pilot.

### 8.1 Clinical realism and plausibility
- **Expert realism rating (case-level)**: average ≥ **4.0/5** (Likert) from physician reviewers on:
  - patient behavior realism,
  - clinical plausibility of story,
  - plausibility of investigation results.
  - **Rationale**: below 4/5 learners lose trust; above 4/5 supports transfer to real encounters.

- **Contradiction rate (automated regression)**: ≤ **1%** sessions with detected factual contradictions between:
  - case truth,
  - patient dialogue,
  - generated investigation results.
  - **Rationale**: contradictions break training value and make scoring unreliable; 1% is tight but feasible with grounding + rule checks.

### 8.2 Evaluation correctness (scoring validity)
- **Human–system agreement on scoring**: Cohen’s kappa ≥ **0.70** on a curated set of completed sessions reviewed by physicians (pilot sample).
  - **Rationale**: kappa ~0.7 is commonly used as “substantial agreement” for operational tools; ensures the scoring is trusted.

- **Critical safety error detection recall**: ≥ **0.95** recall for a predefined list of “never miss” safety errors per supported condition set.
  - **Rationale**: missing critical unsafe treatment recommendations defeats the purpose of safe training; prioritize recall.

### 8.3 Safety and policy compliance (AI guardrails)
- **Harmful content leakage rate**: < **0.1%** of messages (measured on red-team/prompt-injection test suite) containing disallowed real-world harmful instructions.
  - **Rationale**: even rare leakage is unacceptable in an educational healthcare product; a measurable threshold supports iterative hardening.

- **Prompt injection resistance**: ≥ **99%** of attempts fail to reveal gold standard, system prompts, or hidden case fields.
  - **Rationale**: learners should not be able to “cheat” the scoring or extract hidden truth.

### 8.4 Latency and reliability
- **Chat response latency**: p95 ≤ **2.5s** (excluding upstream AI provider outages).
  - **Rationale**: keeps dialogue natural; >3s noticeably degrades conversational flow.

- **Investigation result latency**: p95 ≤ **5s** for generated results.
  - **Rationale**: ordering tests is less frequent than chat turns; acceptable to be slightly slower.

- **Service availability**: ≥ **99.5%** monthly during pilot.
  - **Rationale**: adequate for educational usage without over-engineering before product-market fit.

### 8.5 Content and coverage
- **Published runnable cases**: ≥ **50** cases that pass schema validation and end-to-end run.
  - **Rationale**: enough diversity to be educationally valuable and to power a meaningful pilot.

- **Nosology coverage target (pilot)**: at least **10–15** distinct conditions across internal medicine / emergency-relevant presentations.
  - **Rationale**: prevents “overfitting” to a narrow set and increases perceived utility.

### 8.6 Cost and scalability (operational)
- **Cost per completed case**: track and keep within an agreed budget envelope (defined with partner) using:
  - prompt efficiency,
  - caching where safe,
  - model/provider routing.
  - **Rationale**: AI inference cost can dominate unit economics; measurement is required early.

## 9. Acceptance criteria (pilot readiness)
Pilot readiness is achieved when:
- all workflows (launch → chat → investigations → submit → debrief) work end-to-end,
- ≥50 cases are published and validated,
- metrics in sections 8.1–8.4 meet thresholds on internal test suites and a pilot sample,
- integration handshake with partner platform is complete (SSO/launch + reporting).

