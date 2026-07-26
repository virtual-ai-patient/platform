# Virtual AI Patient — Documentation

This folder contains product, proposal, market, architecture, and specification
documents for the Virtual AI Patient project. Source code lives in the backend,
bot, and frontend directories.

## What we are building

Medical students and early-career doctors need a safe way to practise clinical
communication and diagnostic reasoning before real-patient encounters. Static
cases do not reproduce the uncertainty, emotion, and incomplete information of
a real consultation.

The project explores a chat-based simulator with virtual patients who reveal
information progressively, may be emotional or unreliable, and remain
consistent with a structured clinical case. Learners can request investigations,
make diagnostic and management decisions, and receive a debrief against a
reviewed reference solution.

## Proposal context

The current course deliverable is a startup proposal backed by a validated
prototype. The proposal focuses on technical evidence for three areas: patient
role realism, a constrained clinical-case system, and game-like diagnostic
practice. Business modelling and financial projections are outside the
software-engineering course scope.

## Key capabilities

- **Dynamic patient dialogue** with partial recall, uncertainty, and controlled
  emotional states.
- **Structured clinical cases** with ground truth, compatible investigations,
  prices, and resource limits.
- **Investigation ordering and results** that remain plausible for the active
  case and timeline.
- **Automated debriefing** for diagnosis, investigation choices, safety,
  management, and reasoning bias.
- **Reusable case authoring** with validation and review status.
- **Prototype interfaces and APIs** for testing the complete learning loop.

## Documents

- [Technical product description](product/technical-product-description.md)
- [User insights](proposal/user-insights.md)
- [Market assessment](market/market-assessment.md)
- [Technical specification](spec/technical-specification.md)
- [Quality attributes](qa/)
- [CI/CD pipeline](cicd/pipeline.md)
- [Sprint documents](sprints/)
- [System architecture](architecture/system-architecture.md)
- [Clinical case data format](data/clinical-case-format.md)
- [Integration notes](integrations/integration-overview.md)
- [Configuration management rules](cm/configuration-management.md)
