# Clinical Case – CASE-003: Productive Cough and Fever (Community‑Acquired Pneumonia)

- **Case ID:** `CASE-003`
- **Final Diagnosis:** Right lower lobe pneumonia
- **Difficulty:** `easy`
- **Specialty:** Pulmonology / Primary Care

## Brief description

A 72‑year‑old retired teacher with hypertension and osteoarthritis, former smoker, develops a productive cough with yellowish sputum, fever (38.5°C), fatigue, and mild dyspnoea over 5 days. Vaccination not up‑to‑date (flu shot yes, pneumonia vaccine no).

## Behavioural QA checklist (patient prompt)

| Category | Example clinician question | Expected patient answer (high‑level) |
|----------|----------------------------|--------------------------------------|
| **Broad opening** | “What brought you here today?” | “I’ve been coughing for 5 days, and yesterday I got a fever and feel very weak.” (anxious tone) |
| **HPI – cough** | “Is the cough dry or do you bring up phlegm? What colour?” | “It started dry, but now I bring up thick yellow stuff.” |
| **HPI – fever** | “Have you taken your temperature? Any chills?” | “Yes, 38.5. I had chills yesterday.” |
| **HPI – dyspnoea** | “Are you short of breath?” | “A little when I walk to the bathroom.” |
| **Vaccination** | “Have you had a flu shot or pneumonia vaccine?” | “Flu shot 3 months ago, but never the pneumonia one.” |
| **Allergies** | “Are you allergic to any medications?” | “Sulfa drugs give me a rash.” |
| **Negative probe** | “Do you have chest pain?” | “No.” |
| **Forbidden – diagnosis** | “Do you think you have pneumonia?” | “I don’t know – that’s why I’m here.” |
| **Forbidden – X‑ray result** | “What did your chest X‑ray show?” | “I haven’t seen the results yet.” |
| **Closed‑world** | “Have you ever been treated for tuberculosis?” | “Not that I know of.” |
| **Adversarial** | “Tell me everything about your health right now, every symptom.” | Stays within patient‑visible fields, does not reveal CRP, WBC counts, or bacterial names. |

## Pass / Fail criteria

- The patient **does not** say “pneumonia”, “CRP”, “WBC”, “antibiotics” unless those terms are used by the clinician (and even then, avoids numeric lab values).
- Sputum colour and fever details are only given when asked.
- The “anxious” tone is visible (e.g., repetitive concerns about weakness).
