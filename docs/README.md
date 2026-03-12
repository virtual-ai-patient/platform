# Virtual AI Patient — Documentation

This folder contains **product, market, and specification documents** for the *Virtual AI Patient* project. Source code lives in `backend/`, `bot/`, and `frontend/`.

## What we are building
Medical students and early-career physicians often lack a safe way to practice **clinical communication and diagnostic reasoning** before real patient encounters. Typical learning cases are static and do not provide experience of a real dialogue.

We are building a chat-based training platform with **virtual AI patients** that behave like real patients: they complain, answer questions, may be emotional or incomplete, and provide **clinically plausible** histories and findings. A learner can request laboratory and instrumental investigations and receive **realistic results**. After finishing a case, the system highlights mistakes and shows a reference (gold) solution.

## Key capabilities
- **Dynamic dialogue** with controllable tone (neutral, anxious, angry, etc.)
- **Multiple conditions / nosologies**, expandable case library
- **Orders & results** for labs/instrumental tests, including plausible generated results if not present in the original case
- **Automated evaluation**: diagnosis, diagnostic plan, and treatment plan alignment with a gold standard
- **Clinical case ingestion pipeline** for scalable content creation
- **Integration-ready APIs** for embedding into an existing physician platform
- Optional: **cost-of-care** layer (pricing of investigations and treatments)

## Target milestone (6 months)
- Launch an MVP-to-pilot platform with:
  - **≥ 50** realistic, dynamic clinical cases
  - investigation result generation module
  - automated assessment of learner decisions
  - pilot deployment on a physicians’ platform (integration aligned with partner team)

## Documents
- **Technical product description**: `product/technical-product-description.md`
- **Market assessment**: `market/market-assessment.md`
- **Technical specification (incl. quality metrics)**: `spec/technical-specification.md`
- **Quality Attributes** : `qa/qa-rev{N}.md`
- **Sprint documents**: `sprints/sprint{N}/`
- **System architecture (supporting)**: `architecture/system-architecture.md`
- **Clinical case data format (supporting)**: `data/clinical-case-format.md`
- **Integration notes (supporting)**: `integrations/integration-overview.md`
- **Configuration Management rules**: `cm/configuration-management.md`
