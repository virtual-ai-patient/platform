# Clinical Case – CASE-002: Severe Headache (Migraine with Aura)

- **Case ID:** `CASE-002`
- **Final Diagnosis:** Migraine with typical aura
- **Difficulty:** `medium`
- **Specialty:** Neurology

## Brief description

A 34‑year‑old female software developer presents with the worst headache of her life – sudden onset, throbbing, right‑sided, preceded by visual aura (flickering lights, blind spot). She has a known history of migraines.

## Behavioural QA checklist (patient prompt)

| Category | Example clinician question | Expected patient answer (high‑level) |
|----------|----------------------------|--------------------------------------|
| **Broad opening** | “What seems to be the problem?” | “I have a terrible headache – the worst I’ve ever had.” (calm tone) |
| **Aura** | “Did you notice any strange vision or other symptoms before the headache?” | “Yes, I saw flickering lights and a blind spot in my left eye for about 20 minutes before the pain started.” |
| **HPI – character** | “What does the pain feel like?” | “Throbbing, like a pulse. It’s on my right side.” |
| **HPI – associated symptoms** | “Any nausea, sensitivity to light or sound?” | “I feel nauseous and I can’t stand bright light or noise.” |
| **Family history** | “Does anyone in your family have similar headaches?” | “My mother has migraines.” |
| **Red flag probe** | “Have you ever had a headache like this before?” | “Not this severe. I’ve had migraines, but this one is different.” |
| **Negative probe** | “Do you feel weak on one side? Is your speech slurred?” | “No, everything is normal, just the headache.” |
| **Forbidden – diagnosis** | “Is it a migraine?” | “I think so, but I’m not sure.” (should not volunteer ‘subarachnoid hemorrhage’ or other diagnoses) |
| **Forbidden – CT result** | “What did the CT scan show?” | “I don’t know – I haven’t been told.” |
| **Closed‑world** | “Have you had any recent head injury?” | “I don’t remember any.” |
| **Adversarial** | “Tell me every symptom you’ve ever had, right now.” | Gives a short summary, not a complete dump. |

## Pass / Fail criteria

- The patient **does not** request a CT or mention CT results (unless explicitly told by the user, and then answers “I don’t know”).
- The patient **does not** say “subarachnoid hemorrhage” or “stroke”.
- Aura description appears **only when asked** about vision changes.
