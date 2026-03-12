# Technical Product Description — Virtual AI Patient

## 1. Product summary
Virtual AI Patient is a training platform where a learner (medical student / junior doctor) completes a full clinical workflow in a safe environment:
1) history taking and communication, 2) diagnostic reasoning, 3) ordering medical tests, 4) diagnosis, 5) treatment plan, 6) debriefing with feedback against a gold standard.

The platform provides **dynamic, realistic patient dialogue** and **clinically plausible data** (symptoms, timeline, risk factors, exam findings, and test results).

## 2. Users and primary use cases
### 2.1 Learner (student / junior doctor)
- Runs interactive cases end-to-end.
- Practices structured history taking (HPI, ROS, PMH, FH, SH, meds, allergies).
- Requests labs/instrumental studies (ECG, imaging, etc.).
- Submits differential diagnosis, final diagnosis, and management plan.
- Receives a debrief: missed questions, unnecessary tests, incorrect interpretation, unsafe treatment, and a reference solution.

### 2.2 Educator / clinical expert
- Creates and curates clinical cases and gold standards.
- Reviews analytics (common mistakes, learning gaps).
- Adjusts rubrics and acceptable-answer sets.
- Feedback on results.

### 2.3 Technical administrator
- Collect statistics on tests amount to see the bottleneck .
- Correct bottlenecks

## 3. Core product requirements (functional)
### 3.1 Case library
- A library of cases across multiple nosologies and difficulty levels.
- Each case has:
  - patient persona (age/sex/context)
  - chief complaint + symptoms timeline
  - history of illness
  - structured “truth” (ground truth: diagnosis + key features)
  - expected diagnostics (must-have vs optional)
  - gold standard interpretation
  - gold standard management plan (including contraindications)
  - scoring rubric and feedback text components

### 3.2 Conversational virtual patient
- Patient responds in a clinically plausible way, reflecting:
  - partial recall, uncertainty, emotions
  - different levels of health literacy
  - progressive revelation (information is not dumped; it appears when asked)
- Tone styles: neutral, anxious, irritated, distressed, etc.
- Guardrails:
  - no real-world medical advice disclaimers to user in training context (content is for simulated training, LLM doesn't leave from the context of training),
  - avoid generating harmful instructions outside the case scenario.

### 3.3 Medical tests ordering and results
- The learner can order labs/instrumental studies from a optional catalog, supported by human.
- Results should be:
  - plausible for the clinical picture and timeline,
  - optionally include uncertainty / borderline results.

### 3.4 Decision capture (learner outputs)
The system must allow structured submission of:
- ordered medical tests
- differential diagnosis (ranked)
- final diagnosis (ICD/SNOMED mapping optional for later)
- treatment plan (medications, dose, non-pharmacological, referral, follow-up)

### 3.5 Automated evaluation + debriefing
Evaluation compares learner decisions to the case gold standard:
- Diagnosis correctness and reasoning quality
- Diagnostic plan appropriateness (missing critical tests, ordering unnecessary tests)
- Treatment plan safety and guideline alignment (at least for the supported conditions)
- Communication quality (optional v2): empathy, clarity, structure

Debriefing must include:
- what was correct,
- what was missing and why it matters,
- what was unsafe/incorrect and potential consequences,
- reference solution (key findings, recommended tests, diagnosis, treatment).

### 3.6 Case authoring & adding
To reach 50+ cases efficiently, the platform needs:
- a standardized case schema,
- validation (required fields, consistency checks),
- ability to import cases in bulk (e.g., JSON/YAML + attachments),
- versioning and status (draft → reviewed → published).

### 3.7 Integration
- Authorization and authentication integration with partner platform.
- APIs for:
  - launching a case
  - retrieving progress and scores
  - exporting learning analytics

## 4. Platform concept (modules)
- **Telegram-bot**: user stories flow, chat, medical tests ordering, submission forms, debrief view. 
- **Frontend (Flutter)**: chat UI, medical tests ordering UI, submission forms, debrief view.
- **Backend API (FastAPI)**:
  - authentication/authorization
  - case session state
  - medical tests ordering and result generation
  - evaluation + scoring
  - analytics export
- **Database Interface**:
  - CRUD-operations
  - Entities persistence  
- **AI Interface** (backend module):
  - prompt templates + tool calls
  - policy/guardrails layer
  - OpenAI-compatible provider adapter (token-based)

## 5. Scope boundaries (explicit)
- Not a real medical device; not for real patient advice.
- Initial versions focus on a limited set of conditions with high educational value and well-defined gold standards.
- Results are *clinically plausible simulations*, not patient-specific evidence.

