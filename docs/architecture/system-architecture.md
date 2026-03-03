# System Architecture — Virtual AI Patient (Overview)

## 1. Components
- **Flutter Client**
  - Chat UI
  - Investigations ordering UI
  - Submission forms (DDx/diagnosis/plan)
  - Debriefing view

- **FastAPI Backend**
  - Auth / SSO integration
  - Case catalog and access control
  - Session state machine
  - AI orchestration (patient dialogue + investigation generation)
  - Evaluation and scoring
  - Analytics export

- **AI Provider (OpenAI-compatible)**
  - OpenAI-style REST API
  - Token-based authentication
  - Model routing configurable per environment

- **Storage**
  - Case content store (versioned cases)
  - Session store (messages, orders, submissions)
  - Evaluation artifacts (scores, evidence)

## 2. Data flow (typical session)
```mermaid
sequenceDiagram
  autonumber
  participant U as Learner (Flutter)
  participant B as Backend (FastAPI)
  participant A as AI Provider (OpenAI-compatible)
  participant S as Storage

  U->>B: Launch case session
  B->>S: Load case (versioned)
  B-->>U: Session created + initial patient message

  loop Dialogue
    U->>B: Send user message
    B->>A: Generate patient response (grounded)
    A-->>B: Patient response
    B->>S: Persist message turn
    B-->>U: Patient response
  end

  U->>B: Order investigation(s)
  B->>S: Check if case has predefined result
  alt predefined
    B-->>U: Return stored result
  else generate
    B->>A: Generate plausible result (grounded + consistent)
    A-->>B: Result text/values
    B->>S: Persist result
    B-->>U: Return result
  end

  U->>B: Submit DDx/diagnosis/plan
  B->>S: Persist submission
  B->>B: Evaluate vs gold standard (rules + AI-assisted where allowed)
  B->>S: Persist scoring artifacts
  B-->>U: Debrief + scores
```

## 3. Architectural principles
- **Case-grounded generation**: the AI layer must not invent facts that contradict the case truth.
- **Reproducible scoring**: cases are versioned; scoring references a specific case version.
- **Provider-agnostic AI adapter**: only one integration layer speaks OpenAI-compatible API.
- **Auditable evaluation**: every score deduction has evidence and rationale for debriefing.
- **Security by design**: no real patient data; strict separation of case content vs user data.

