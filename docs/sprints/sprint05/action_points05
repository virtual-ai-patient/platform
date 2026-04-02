
# Action Points

### AP-001: Document Clinical Case Structure
- **Owner:** Alina + Team
- **What:** Research and document what a clinical case contains:
  - Patient persona fields
  - Symptom structure
  - Medical history fields
  - Gold standard structure (hidden from AI)
  - Evaluation criteria
- **Output:** Add to `docs/case-schema.md`
- **Due:** April 9, 2026

### AP-002: Create Synthetic Cases in JSON Format
- **Owner:** Ilnar, Aizat
- **What:** Create 2-3 synthetic cases following the documented schema
- **Format:** JSON files stored in `/cases/` directory
- **Source:** ChatGPT-generated, then manually reviewed
- **Due:** April 9, 2026

### AP-003: Build LLM Evaluation Harness
- **Owner:** Ilnar, Aizat
- **What:** Create a script/tool that:
  - Loads a case from JSON
  - Sends patient context to LLM (no diagnosis!)
  - Asks predefined questions
  - Records answers for analysis
- **Goal:** Test LLM behavior without spending money (use DeepSeek free tier or local model)
- **Due:** April 16, 2026

### AP-004: Prepare Working Demo for Next Presentation
- **Owner:** Timur, Ilnar
- **What:** Ensure `docker-compose up` works and frontend shows:
  - Authentication flow
  - Case selection (with synthetic cases)
  - Basic chat interface
- **Output:** Live demo during next mentor presentation
- **Due:** April 9, 2026

### AP-005: Add Clickable Links to Presentation
- **Owner:** Alina
- **What:** Add hyperlinks to:
  - GitHub repository
  - Specific documentation files
  - Pull requests showing completed work
  - Demo video (if recorded)
- **Why:** Mentors have limited time and won't search for materials
- **Due:** Before next presentation (April 9, 2026)

### AP-006: Document AI Evaluation Results
- **Owner:** Aizat, Ilnar
- **What:** After running evaluation harness, document:
  - Which LLM(s) were tested
  - What questions were asked
  - How accurate the responses were
  - What prompt improvements were made
- **Output:** Add to `docs/ai-evaluation.md`
- **Due:** April 16, 2026

### AP-007: Request Medical Expert Access (If Needed)
- **Owner:** Alina
- **What:** Prepare specific questions for medical experts (via Mansur):
  - How are clinical cases structured in real medical education?
  - What symptoms are critical for common diseases?
  - How is diagnostic accuracy evaluated?
- **Output:** List of prepared questions before requesting meeting
- **Due:** April 16, 2026 (if needed)

### AP-008: Re-prioritize Frontend Over Telegram Bot
- **Owner:** Alina (PM)
- **What:** Officially pause Telegram bot work; move all frontend tasks to higher priority
- **Update:** Update GitHub Project board and sprint planning
- **Due:** Immediately

---

## Key Insights from Mentor

### On AI Architecture
> "You cannot depend on the LLM's interpretation of a disease. It will hallucinate. It will invent symptoms. Give the AI only what a real patient knows — how they feel, not what they have."

### On Proving Value Before Spending
> "Build the evaluation harness first, test with free models, show me it works. Then we go to Denis for API keys. Don't ask for money before proving the concept."

### On Process Documentation
> "Document what you actually do, even if it's not perfect. Then show how you plan to improve it. That's what mentors are looking for."

### On Visibility
> "Add clickable links to everything. Mentors won't search for 5 minutes. If they can't find it in 2-3 clicks, they assume it doesn't exist."

---

## Next Milestones

| Milestone | Target Date | Status |
|:---|:---|:---|
| Case schema documented | April 9 | 🔴 Not started |
| Synthetic cases created | April 9 | 🔴 Not started |
| Working demo ready | April 9 | 🟡 In progress |
| LLM evaluation harness | April 16 | 🔴 Not started |
| AI evaluation results | April 16 | 🔴 Not started |
| Medical expert questions prepared | April 16 | 🔴 Not started |

---

## Summary

### Critical Path Forward

```
1. Document case structure (AP-001)
2. Create synthetic cases (AP-002)
3. Build evaluation harness (AP-003)
4. Test with free LLM (DeepSeek)
5. Present results to mentor (AP-006)
6. Request API keys from Denis (if justified)
```

### The Most Important Takeaway

> **Do not give the diagnosis to the AI.** The AI simulates a patient who doesn't know what's wrong. The learner must figure it out through questions. The gold standard diagnosis is stored separately for evaluation only.
