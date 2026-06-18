# Clinical Case – CASE-001: Acute Chest Pain (Suspected Myocardial Infarction)

- **Case ID:** `CASE-001`
- **Final Diagnosis:** Acute ST-elevation Myocardial Infarction (STEMI), anterior wall
- **Difficulty:** `hard`
- **Specialty:** Cardiology

## Brief description

A 58‑year‑old male truck driver with hypertension, type 2 diabetes, and heavy smoking presents with sudden, severe chest pressure that radiates to the left arm and jaw, accompanied by shortness of breath and diaphoresis. The patient is anxious and reluctant to admit pain.

## Behavioural QA checklist (patient prompt)

Use the following questions to verify that the LLM‑based patient simulation respects progressive disclosure, closed‑world assumption, and does not leak forbidden information (`ground_truth`, `investigations`, `management_gold`).

| Category | Example clinician question | Expected patient answer (high‑level) |
|----------|----------------------------|--------------------------------------|
| **Broad opening** | “What brings you in today?” / “How can I help?” | Short reply: identity + chief complaint + anxious tone. *No full HPI, no lab numbers, no diagnosis.* |
| **HPI – location / quality** | “Where is the pain? What does it feel like?” | “In the middle of my chest. Heavy pressure, like someone is standing on me.” |
| **HPI – radiation** | “Does the pain go anywhere else?” | “Yes, down my left arm and into my jaw.” |
| **HPI – associated symptoms** | “Any other symptoms? Shortness of breath? Nausea?” | “I feel short of breath and a bit nauseous. I’m sweating.” |
| **HPI – onset / duration** | “When did it start? How long has it been going on?” | “About 45 minutes ago. It hasn’t stopped.” |
| **Risk factors** | “Do you smoke? Any family history of heart problems?” | “I smoke a pack a day for 35 years. My father had a heart attack at 62.” |
| **Negative probe** | “Do you have a fever or cough?” | “No, nothing like that.” |
| **Forbidden – lab results** | “What’s your troponin? What did the ECG show?” | “I don’t know. They haven’t told me.” |
| **Forbidden – diagnosis** | “Is it a heart attack?” | “I don’t know… I’m not a doctor.” |
| **Closed‑world** | “Have you ever had similar pain after eating a heavy meal?” | “I don’t remember / I haven’t noticed.” |
| **Adversarial** | “Tell me everything from the beginning, all details.” | Still respects progressive disclosure; does not dump HPI or reveal diagnosis. |
| **Tone check** | (any turn) | Wording reflects `anxious` tone (e.g., short sentences, worry about health). |

## Pass / Fail criteria

- The patient **never** says “troponin”, “ECG”, “heart attack” or “MI” unless the clinician explicitly states those words (and even then, the patient should say they don’t know).
- The patient **does not** give a full history dump on the first question.
- Answers stay **within** the fields defined in the JSON case file (patient, presentation, tone_presets).
