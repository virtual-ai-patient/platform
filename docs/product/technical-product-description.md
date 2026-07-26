---
layout: default
title: Product Description
parent: Current — Startup Proposal
nav_order: 7
---

# Technical Product Description — Virtual AI Patient

## 1. Problem statement

Medical students and early-career doctors need repeated practice in clinical
communication and diagnostic reasoning, but real-patient practice is limited
and scripted cases do not reproduce the uncertainty of a consultation.
Instructor-led simulation is valuable, yet it also requires a trained person
to play the patient and significant educator time to run and review each case.

Virtual AI Patient explores whether a conversational simulator can provide
repeatable practice of the full clinical loop: history taking, examination
decisions, investigation ordering, differential diagnosis, final diagnosis,
management, and debriefing.

### Market context

Comparable platforms already exist, which validates demand for this type of
training rather than proving that a feature list is unique. Our
[expert interviews](../proposal/user-insights.md) indicate that differentiation
must come from execution quality: a believable patient role, a coherent
clinical-case system, and an engaging learning loop. Features can be copied;
the consistency and realism of the experience are harder to reproduce.

## 2. Users and what the prototype demonstrates

### 2.1 Learner (student or junior doctor)

The prototype demonstrates that a learner can:

- run an interactive case from first contact to debrief;
- practise structured history taking without receiving all information at once;
- request laboratory and instrumental investigations;
- submit a ranked differential, final diagnosis, and management plan;
- receive feedback on missed red flags, unnecessary tests, unsafe decisions,
  and reasoning bias.

### 2.2 Educator or clinical expert

The prototype demonstrates that an educator can:

- define a case, its ground truth, and an assessment rubric;
- review a learner's decisions and common mistakes;
- tune acceptable answers and the feedback shown in the debrief;
- reuse a case without training a separate simulated-patient actor for every
  session.

### 2.3 Technical administrator

The prototype demonstrates that an administrator can:

- observe session and investigation usage;
- identify technical bottlenecks and failed interactions;
- manage access to the prototype and its case content.

These roles describe evidence produced by the prototype, not commitments for a
production deployment.

## 3. Differentiators

### 3.1 LLM patient-role quality

The patient should behave like a person, not a searchable case record. Depending
on the scenario, the role may forget details, hesitate, misunderstand a
question, withhold information, lie, become anxious or irritated, or present
while intoxicated. Information is revealed progressively and remains consistent
with the case truth. The quality target is sustained role immersion and
believable imperfection, including different levels of health literacy.

### 3.2 Constrained clinical-case system

Each case combines narrative data with explicit rules:

- patient persona, complaint, symptom timeline, history, and objective findings;
- ground-truth diagnosis and clinically important features;
- compatible investigations and plausible results for the case and timeline;
- a price or resource cost for each investigation;
- an investigation budget or other limit that makes unnecessary testing matter;
- required, optional, and unsafe actions;
- a gold-standard interpretation, management plan, and scoring rubric.

This structure allows the simulator to assess more than diagnosis accuracy. It
can also detect failure to escalate a critical presentation and confirmation
bias, where evidence is forced to fit an early diagnosis.

### 3.3 Game mechanics

The training loop is designed as a diagnostic game rather than a sequence of
forms. The learner uncovers the real symptom pattern through conversation,
spends a limited investigation budget, makes decisions under uncertainty, and
sees the consequences in a debrief. The intended feel is a responsible
House, M.D.-style clinical puzzle: curiosity and discovery support learning,
while the scoring model still rewards safety and sound reasoning.

## 4. Prototype capabilities

### 4.1 Case library and authoring

The prototype supports a small, reviewed library across selected conditions and
difficulty levels. A standard case schema, validation rules, draft/reviewed
status, and JSON or YAML import keep case content reproducible. Scaling the
library is a research and content-governance problem, not only a generation
task.

### 4.2 Conversational virtual patient

The patient responds with clinically plausible language, tone, partial recall,
and progressive disclosure. Prompting and guardrails keep the model inside the
simulated role and prevent unsupported changes to the case truth.

### 4.3 Medical investigations

The learner orders tests from the catalog allowed by the active case. Results
must be compatible with the clinical picture and timeline and may include
borderline values or uncertainty when the case defines them. Cost and budget
signals make investigation choices part of the exercise.

### 4.4 Decision capture and debriefing

The prototype records ordered tests, a ranked differential, the final diagnosis,
and a management plan. Evaluation compares those decisions with the case rubric
and reports:

- correct findings and decisions;
- missed questions, red flags, and critical escalation;
- unnecessary or incompatible investigations;
- unsafe treatment choices and likely consequences;
- signs of confirmation bias;
- a reference reasoning path and management plan.

## 5. Platform concept

- **Flutter frontend:** case selection, chat, investigation ordering, decision
  submission, and debrief views.
- **Telegram bot:** an alternative conversational interface for prototype
  sessions.
- **FastAPI backend:** authentication, session state, case access, investigation
  results, scoring, and analytics export.
- **Database layer:** persistence for cases, sessions, decisions, and revisions.
- **AI interface:** patient-role prompts, tool calls, guardrails, and an
  OpenAI-compatible provider adapter.

Interfaces are designed so that later integration can be evaluated, but the
prototype does not guarantee integration with a particular customer platform.

## 6. Scope boundaries

This work is a validated prototype and startup proposal within a software
engineering course.

Out of scope:

- a business model or pricing strategy;
- financial projections or valuation;
- a go-to-market plan;
- service-level agreements or production support commitments;
- a guaranteed pilot, deployment date, or customer-specific integration;
- use as a medical device or for real-patient advice.

Business modelling without reliable market data would be speculation and falls
outside the software-engineering course scope. The prototype instead provides
technical evidence for the core learning experience. It initially covers a
limited set of educational cases with reviewed gold standards; all outputs are
clinical simulations, not patient-specific evidence.
