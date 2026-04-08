# Clinical Case Design Rationale

## 1. Introduction

This document explains the design decisions behind the clinical case schema used in the Virtual AI Patient project.

The goal of the schema is to support:

* realistic clinical simulations
* reliable evaluation of learners
* safe and grounded behavior of the AI patient (LLM)

---

## 2. Limitations of the MVP Format

The initial MVP schema provides a simple structure but has several limitations:

* **Unstructured HPI**

  * Narrative-only format leads to ambiguity
  * LLM may infer or hallucinate additional details

* **Missing explicit negatives**

  * Absence of symptoms is not clearly defined
  * Violates the closed-world assumption

* **No anamnesis vitae**

  * Missing past medical history, medications, lifestyle
  * Prevents full clinical reasoning

* **No physical examination data**

  * Makes simulation unrealistic
  * Blocks assessment of diagnostic reasoning

* **Over-reliance on free text**

  * Hard to validate
  * Hard to control LLM behavior

---

## 3. Design Principles

The extended schema is based on the following principles:

* **Closed-world simulation**

  * The AI patient can only use explicitly defined facts

* **Progressive disclosure**

  * Information is revealed only when asked

* **Separation of concerns**

  * Patient data is strictly separated from evaluation data

* **Alignment with clinical workflow**

  * Structure reflects real medical practice (history → exam → tests → diagnosis)

---

## 4. Added Fields and Rationale

### Anamnesis vitae

**What:**
Past medical history, medications, allergies, lifestyle, family history.

**Why:**
Essential for real clinical reasoning and required in standard medical intake.
Without this, the AI patient either lacks information or hallucinates.

---

### Explicit negatives

**What:**
Structured list of absent symptoms.

**Why:**
Critical for enforcing closed-world behavior and preventing hallucinations.

---

### Structured HPI

**What:**
Separation into:

* narrative (human-readable)
* structured facts (onset, location, severity, etc.)

**Why:**
Improves grounding and reduces ambiguity in LLM responses.

---

### Physical examination

**What:**
Vitals and system-based findings.

**Why:**
Required for realistic simulation and proper evaluation of diagnostic steps.

---

### Preliminary diagnosis

**What:**
Diagnosis after initial assessment, before investigations.

**Why:**
Reflects real clinical workflow and allows intermediate evaluation.

---

### ICD-10 code

**What:**
Standardized diagnosis code.

**Why:**
Required in clinical documentation and useful for precise evaluation.

---

### Learning objectives

**What:**
Description of what the case is designed to teach.

**Why:**
Improves usability for educators and supports structured feedback.

---

## 5. Impact on AI Patient Behavior

These changes improve the AI patient in several ways:

* reduce hallucinations
* enforce consistency
* ensure all responses are grounded in case data
* improve realism of interaction

---

## 6. Summary

The extended schema transforms the case format from a narrative description into a structured, controllable system suitable for LLM-based simulation and reliable evaluation.
