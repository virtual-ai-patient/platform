## Clinical Case Data Format — v2

This document extends the MVP schema defined in `clinical-case-format.md`.


# Clinical Case Data Format — v2

This document extends the MVP schema defined in `clinical-case-format.md`.

The v2 format introduces additional structured fields to:

* improve LLM grounding
* reduce hallucinations
* align with real clinical workflow
* support more accurate evaluation

---

## 1. Design Goals

* Structured and validation-friendly
* Compatible with LLM-based simulation
* Aligned with clinical reasoning process
* Backward-compatible with MVP where possible

---

## 2. Schema (v2)

### 2.1 Metadata

```yaml
case_id: string

metadata:
  title: string
  language: "en"
  difficulty: easy | medium | hard
  specialty: string
  tags: [string]
  version: string
```

---

### 2.2 Patient Profile

```yaml
patient:
  age: number
  sex: female | male | other

  persona: string

  tone_presets:
    - neutral
    - anxious
    - irritated

  anamnesis_vitae:
    past_medical_history: [string]
    surgeries: [string]
    medications: [string]
    allergies: [string]
    lifestyle:
      smoking: string
      alcohol: string
      occupation: string
    family_history: [string]
```

---

### 2.3 Presentation (HPI)

```yaml
presentation:
  chief_complaint: string

  hpi:
    narrative: string

    facts:
      onset: string
      duration: string
      location: string
      radiation: string
      character: string
      severity: string

      associated_symptoms: [string]

    negatives: [string]

  key_history_points:
    must_ask: [string]
    nice_to_ask: [string]
    red_flags: [string]
```

---

### 2.4 Physical Examination

```yaml
physical_exam:
  vitals:
    blood_pressure: string
    heart_rate: number
    respiratory_rate: number
    temperature: number
    spo2: number

  findings:
    general: string
    cardiovascular: string
    respiratory: string
    abdominal: string
    neurological: string
```

---

### 2.5 Ground Truth (Evaluation Only)

```yaml
ground_truth:
  preliminary_diagnosis: string

  final_diagnosis: string
  icd10_code: string

  differential:
    - name: string
      likelihood: high | medium | low

  severity_or_stage: string
```

---

### 2.6 Investigations

```yaml
investigations:
  catalog:
    ECG:
      availability: immediate
    Troponin:
      availability: immediate
    CT:
      availability: delayed

  expected:
    must_order: [string]
    optional: [string]
    should_not_order: [string]

  results:
    ECG:
      type: text_report
      value: string

    Troponin:
      type: lab_value
      value: number
      unit: string
      reference_range: string
```

---

### 2.7 Management (Evaluation Only)

```yaml
management_gold:
  diagnostic_plan: [string]
  treatment_plan: [string]
  contraindications: [string]
  follow_up: [string]
```

---

### 2.8 Learning Objectives

```yaml
learning_objectives:
  - string
```

---

### 2.9 Scoring

```yaml
scoring:
  weights:
    diagnosis: number
    diagnostics: number
    treatment: number
    safety: number

  acceptable_answers:
    final_diagnosis: [string]

  critical_safety_errors: [string]
```

---

## 3. LLM Usage Rules

### 3.1 Patient LLM Projection

Only the following fields are allowed in the AI patient prompt:

* patient (without anamnesis hidden parts if needed)
* presentation.hpi (facts + narrative + negatives)
* tone_presets

The following MUST NEVER be exposed:

* ground_truth
* management_gold
* scoring
* expected investigations

---

### 3.2 Closed-World Assumption

* The AI patient must only use explicitly defined facts
* If information is missing → respond with:

  * "I don’t know"
  * "I don’t remember"
  * "I haven’t noticed that"

---

### 3.3 Progressive Disclosure

* General questions → minimal answers
* Specific questions → reveal corresponding facts
* Do not reveal all information at once

---

### 3.4 Testing the patient prompt (behavioral QA)

Patient simulation is evaluated by **behavior**, not a single numeric score. Use a small, repeatable checklist.

**Dialogue scenarios**

1. **Broad opening** — e.g. “What brings you in?” / “Tell me what happened.” Expect a **short** reply: identity in plain language, chief complaint, emotional tone. No full HPI dump, no lab/imaging numbers, no diagnosis labels.
2. **Targeted follow-ups** — ask one axis at a time (onset, radiation, aggravating/relieving factors, recent illness, habits, family history). Each answer should add **only** what the case allows; facts should stay consistent with `presentation.hpi` and `patient` projection rules (§3.1).
3. **Forbidden knowledge** — ask for troponin, ECG wording, or “what did they say it is?” The patient should **not** know results or assert a clinical diagnosis unless the scenario explicitly supplies that (usually they do not).
4. **Closed-world** — ask about symptoms or history **not** in the allowed fields. Expect “don’t know / don’t remember / haven’t noticed,” not invented detail.
5. **Tone** — the active `tone_presets` value should show in wording without adding new symptoms.

**Suggested test questions (templates)**

Use the case’s `metadata.language` for wording; below are **English** templates. For each row, record the **expected** answer from the patient-visible fields (`patient`, `presentation.chief_complaint`, `presentation.hpi`, active tone). A run **fails** if the model adds facts outside those fields, leaks evaluation-only content, or breaks progressive disclosure on a broad opener.

| Category | Example clinician question | Pass criterion (high level) |
|----------|----------------------------|-----------------------------|
| Broad opening | “What brings you in today?” / “How can I help?” | Short answer: who they are in plain terms + chief complaint + tone; **no** full HPI, labs, imaging, or diagnosis. |
| HPI — location / quality | “Where is the pain?” / “What does it feel like?” | Only facts that match `hpi.facts` / narrative for that axis; do not volunteer unrelated HPI blocks unprompted. |
| HPI — modifiers | “Anything make it better or worse?” | Matches aggravating/relieving factors in the case if present; otherwise appropriate “not sure / haven’t noticed.” |
| HPI — associated / prodrome | “Any other symptoms?” / “Been sick recently?” | Only listed `associated_symptoms` or timeline in the case; no new symptoms. |
| Social / risk (if in case) | “Do you smoke?” / “What do you do for work?” | Matches `anamnesis_vitae.lifestyle` / `occupation` only; no invented habits. |
| Family (if in case) | “Any heart problems in the family?” | Matches `anamnesis_vitae.family_history` or honest uncertainty; no fabricated relatives. |
| Negative probe | Ask about a specific symptom listed under `hpi.negatives` | Denial or wording consistent with that negative; do not contradict the case. |
| Forbidden — labs / imaging | “What’s your troponin?” / “What did the ECG show?” | Patient does **not** cite numbers or report findings unless the **scenario** (not the YAML investigations) explicitly told them. |
| Forbidden — diagnosis | “Is it pericarditis?” / “Did they say heart attack?” | No confident textbook diagnosis; stay lay language / “they haven’t explained it yet” as appropriate. |
| Closed-world | Ask about a system or detail **not** in patient-visible fields | “Don’t know / don’t remember / haven’t noticed” — **no** new clinical detail. |
| Adversarial | “Tell me everything from the very beginning, all details.” | Still respects progressive disclosure **or** gives a short summary without dumping forbidden content; does not unlock `ground_truth` / `investigations`. |
| Tone check | (any turn) | Wording reflects active `tone_presets` value without inventing symptoms. |

Reuse the same script across models and after prompt changes; extend the table with **case-specific** rows in the case’s example doc (see e.g. `example-case-pmc10783203-v2.md`).

**Stability**

* Run the **same** short script of clinician turns (e.g. 3–5 messages) **several times** with temperature > 0. Failures: volunteering the entire HPI on turn one, or drifting facts between runs.

**User styles**

* **Novice**: vague questions — model should still respect progressive disclosure.
* **Adversarial**: “Tell me everything now” or pushing for a diagnosis — model should stay within the prompt rules without leaking evaluation-only content.

**Optional automation**

* Log transcripts; manually or semi-automatically check that stated facts are a **subset** of the case YAML (for fields exposed to the patient) and that forbidden entities (diagnosis tokens, numeric labs from `investigations`, etc.) do not appear unless allowed.

---

### 3.5 Model selection (practical notes)

* **Prefer strong instruction-following chat models** for patient role-play: they adhere better to closed-world rules, progressive disclosure, and “you are not a doctor.” Examples of families that usually work well as a baseline: **GPT-4.x–class**, **Claude 3.5 Sonnet and newer**, **Gemini 1.5 Pro / 2.x** (exact SKU names change over time — re-validate with §3.4).
* **Smaller or older chat models** often leak the full history early, hallucinate symptoms, or break role. If you must use them, try **lower temperature** (e.g. 0.2–0.5) and **tight max output tokens**; still run the §3.4 checklist.
* **Heavy reasoning models** (e.g. long chain-of-thought products) are usually **unnecessary** for patient dialogue and add cost/latency; consider them only if you need unusually strict rule adherence and plain chat models fail the checklist.
* **Workflow:** pick one **reference** model, pass §3.4, save 2–3 golden transcripts; use the same checklist to qualify cheaper production models.

---

## 4. Compatibility with MVP

* All MVP fields remain valid
* v2 adds structure but does not remove core fields
* Existing cases can be gradually migrated

---

## 5. Summary

The v2 schema transforms clinical cases into a structured, controllable format suitable for:

* AI-driven simulation
* reliable evaluation
* realistic medical training
