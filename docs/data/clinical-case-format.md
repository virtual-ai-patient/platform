# Clinical Case Data Format — MVP

This document defines a **minimal, scalable** schema for clinical cases and the “gold standard” required for evaluation.

## 1. Design goals
- **Clinician-friendly**: editable as YAML/JSON with clear fields.
- **Validation-ready**: required fields are explicit; can be linted in CI.
- **Versionable**: each published case has an immutable version for reproducible scoring.
- **Grounding-first**: AI dialogue and generated investigations reference only this case truth (plus allowed “unknown/uncertain” gaps).

## 2. File layout (recommended)
- One case per file: `cases/<case_id>.yaml`
- Optional attachments: `cases/<case_id>/attachments/*` (later phase)

## 3. Schema (MVP)
### 3.1 Required fields
- `case_id`: string (unique, stable)
- `metadata`:
  - `title`
  - `language` (must be `en`)
  - `difficulty` (`easy|medium|hard`)
  - `specialty` (free text, e.g., `internal_medicine`)
  - `tags` (list)
- `patient`:
  - `age`
  - `sex` (`female|male|other`)
  - `persona` (short text)
  - `tone_presets` (subset of supported tones)
- `presentation`:
  - `chief_complaint`
  - `history_of_present_illness` (ground truth narrative)
  - `key_history_points`:
    - `must_ask`: list of strings
    - `nice_to_ask`: list of strings
    - `red_flags`: list of strings
- `ground_truth`:
  - `final_diagnosis` (string)
  - `differential` (ranked list of strings)
  - `severity_or_stage` (optional string)
- `investigations`:
  - `catalog_hints` (optional list of recommended tests to show first)
  - `expected`:
    - `must_order`: list
    - `optional`: list
    - `should_not_order`: list
  - `results` (map by test name; can be partial)
- `management_gold`:
  - `diagnostic_plan` (list of steps)
  - `treatment_plan` (list of steps)
  - `contraindications` (list of “do not do”)
  - `follow_up` (list)
- `scoring`:
  - `weights` (e.g., diagnosis/diagnostics/treatment/safety)
  - `acceptable_answers` (synonyms/variants)
  - `critical_safety_errors` (list)

### 3.2 Optional fields
- `patient.pmH` / `patient.meds` / `patient.allergies` (structured)
- `physical_exam` (structured or narrative)
- `investigations.results_generated_policy` (how to generate missing tests)
- `localization` (future multilingual)

## 4. Example (minimal YAML)
```yaml
case_id: chest_pain_001
metadata:
  title: "Acute chest pain in a smoker"
  language: "en"
  difficulty: "medium"
  specialty: "emergency_medicine"
  tags: ["chest_pain", "cardiology", "triage"]

patient:
  age: 54
  sex: "male"
  persona: "Busy delivery driver, worried but trying to downplay symptoms."
  tone_presets: ["neutral", "anxious", "irritated"]

presentation:
  chief_complaint: "Chest pain"
  history_of_present_illness: >
    Substernal pressure for 45 minutes, started at rest, radiates to left arm,
    associated with diaphoresis and nausea.
  key_history_points:
    must_ask:
      - "Onset, duration, character, radiation, associated symptoms"
      - "Cardiovascular risk factors (smoking, HTN, DM, family history)"
      - "Medications and allergies (esp. antiplatelets, anticoagulants)"
    nice_to_ask:
      - "Recent exertion, stress, infections"
    red_flags:
      - "Syncope"
      - "Severe dyspnea"

ground_truth:
  final_diagnosis: "Acute coronary syndrome (ST-elevation myocardial infarction)"
  differential:
    - "ST-elevation myocardial infarction"
    - "Unstable angina"
    - "Aortic dissection"
    - "Pulmonary embolism"

investigations:
  expected:
    must_order: ["ECG", "Troponin", "Vital signs"]
    optional: ["Chest X-ray"]
    should_not_order: ["Elective stress test"]
  results:
    ECG:
      type: "text_report"
      value: "ST elevation in II, III, aVF with reciprocal depression in I, aVL."
    Troponin:
      type: "lab_value"
      value: 2.4
      unit: "ng/mL"
      reference_range: "0.00–0.04"

management_gold:
  diagnostic_plan:
    - "Immediate ECG and repeat if initial nondiagnostic"
    - "Serial troponins as indicated"
  treatment_plan:
    - "Activate cath lab / urgent reperfusion pathway"
    - "Aspirin unless contraindicated"
  contraindications:
    - "Discharge without ruling out ACS"
  follow_up:
    - "Risk factor modification and cardiology follow-up after acute management"

scoring:
  weights:
    diagnosis: 0.35
    diagnostics: 0.25
    treatment: 0.30
    safety: 0.10
  acceptable_answers:
    final_diagnosis:
      - "STEMI"
      - "ST-elevation MI"
  critical_safety_errors:
    - "Recommending discharge with ongoing ischemic chest pain"
```

## 5. Validation rules (MVP)
- `metadata.language` must be `en`
- required sections must exist
- every `expected.must_order` test must exist in the global catalog
- if `results` contains lab values, `unit` and `reference_range` are required
- scoring weights must sum to 1.0 (within tolerance)

