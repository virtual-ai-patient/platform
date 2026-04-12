# Meeting Overview
---

## 1. Meeting Summary

The team presented progress on backend case management and frontend case library. Key discussions focused on:

- **Demo readiness** – The mentor requested a working demonstration of the chat interface and case selection.
- **LLM experiments** – The team has conducted initial tests with different models (DeepSeek, etc.) but lacks a structured artifact (e.g., Jupyter notebook) showing prompts, responses, and evaluation.
- **API key blocker** – The team is waiting for an API key to integrate a production LLM. The mentor is willing to provide a key **only after** seeing a clear research artifact that proves the chosen approach works.
- **Pull request visibility** – The mentor emphasized using open Pull Requests (not just commit history) to make individual work visible to other mentors and stakeholders.
- **Russian language requirement** – The final dialogue should be in Russian, though experiments can be in English.

---

## 2. Key Technical Status

### Backend & Frontend
- Backend: Case management endpoints completed, seed script available to populate database with synthetic cases.
- Frontend: Case library view (list of cases) is functional. Chat UI is under development.
- The team uses OpenAPI spec generation → code generation for frontend requests to ensure contract consistency.

### Case Data Structure
- The team has defined a JSON structure for clinical cases (persona, symptoms, gold standard, etc.).
- A sample case has been created and tested manually with LLM.

### LLM Experiments (Aizat)
- Tests performed with DeepSeek, Chinese models (produce thinking in parentheses), and others.
- No Jupyter notebook or systematic evaluation artifact exists yet.
- The team believes the basic conversational engine can work, but needs API key to integrate into the backend.

---

## 3. Mentor’s Core Feedback

### On Demonstrating Progress
> *“If you have done research but have no artifact, you might as well have drunk coffee and done nothing.”*

- **Every research activity must produce a tangible artifact** (notebook, script, documented test results).
- The artifact should allow someone else to reproduce the results without spending the same amount of time.
- For LLM experiments, a **Jupyter notebook** is the preferred format – showing prompts, model responses, and evaluation against expected answers.

### On the “Conversational Virtual Patient Engine” (EPIC-03)
- The mentor is not convinced that the engine works because **there is no visible evidence** (no chat UI, no CLI demo, no notebook).
- **Minimum requirement:** Show a working conversation – even a simple script that asks a few questions and receives plausible answers.
- If the team shows a working conversation (even with a free/local model) and a clear evaluation of why the answers are acceptable, the mentor will provide an API key.

### On API Key & Proxy
- The mentor can provide a key but warned that direct Google API usage may be blocked. He suggested setting up a proxy endpoint (e.g., on a separate server) to avoid rate limits / regional blocks.
- The team can also use free models (DeepSeek, Gemini free tier) for initial prototyping.

### On Pull Requests vs Commit History
- **Pull Requests are preferred** because they clearly show who is working on what, and mentors can see open PRs at a glance.
- Commit history is less visible. The team should adopt a workflow where every change starts with a branch and a PR (even if not immediately merged).

### On Language
- The final product should support **Russian** (target audience is Russian-speaking medical students).
- Experiments can be in English, but the team must eventually test with Russian prompts and responses.
