# Пример кейса в формате v2 (из открытого источника)

## Связь с внутренними документами

- Схема полей: [clinical-case-format-v2.md](clinical-case-format-v2.md).
- Тип источника по классификации проекта: [clinical-case-sources.md](../data/clinical-case-sources.md) — раздел **3. Secondary Sources → Scientific journals** (клинический case report с полной презентацией, обследованиями и исходом).

Ниже — **один** конкретный кейс, переложенный в YAML по v2. Он не является официальным кейсом продукта; это шаблон для проверки полей и достаточности данных из литературы.

---

## Источник данных

| Поле | Значение |
|------|----------|
| Публикация | Omodara AB et al. *A Young Male Presenting With Chest Pain, Elevated Troponin Levels, and a Clinical Dilemma: A Case Report.* Cureus. 2023. |
| **PMC (полный текст)** | https://pmc.ncbi.nlm.nih.gov/articles/PMC10783203/ |
| **DOI** | https://doi.org/10.7759/cureus.50391 |
| PMID | 38213369 |

---

## Насколько полные данные для кейса v2

| Блок v2 | Полнота | Комментарий |
|---------|---------|-------------|
| `metadata` | Высокая | Заголовок и теги заданы редакторски; `case_id` вымышлен для репозитория. |
| `patient` / `anamnesis_vitae` | Высокая | Взято из раздела Case presentation статьи. |
| `presentation.hpi` | Высокая | Факты и негативы согласованы с текстом; `narrative` — краткий **язык пациента** (не дословная цитата статьи). |
| `physical_exam.vitals` | Высокая | Числа из статьи. |
| `physical_exam.findings` | Средняя | В статье детально сердце; остальные системы — «unremarkable» обобщённо. |
| `ground_truth` | Высокая по клинике | Финальный вывод и дифференциал из Discussion/CMR; **ICD-10** в статье не указан — проставлен ориентировочно (уточнять по локальным правилам кодирования). |
| `investigations` | Высокая | Таблицы 1–2, описание ЭКГ, рентгена, эхо, КМР — из статьи. |
| `management_gold` | Высокая | Из разделов Treatment / Outcome. |
| `learning_objectives` | Редакторские | В статье как учебные цели не формулированы — добавлены по смыслу кейса. |
| `scoring` | Частично | Веса и acceptable_answers — **пример**, в источнике нет рубрики оценки студента. |

**Итог:** для **симуляции и золотого стандарда** источник **очень полный**; для **автоматического скоринга** не хватает только готовой рубрики (её проект задаёт отдельно).

---

## Patient system prompt (v2)

Системное сообщение для LLM в роли пациента собирается **только** из полей, перечисленных в [clinical-case-format-v2.md](clinical-case-format-v2.md) §3.1 (patient + `presentation.hpi` и жалоба + тон). Правила closed-world и прогрессивного раскрытия — §3.2–3.3. Не подставлять: `key_history_points`, `physical_exam`, `ground_truth`, `investigations`, `management_gold`, `scoring`, `learning_objectives`.

### Template

```text
You are role-playing a patient in a medical education simulation. You are not a doctor.

LANGUAGE: <metadata.language> (e.g. English).

RULES:
- Use only facts listed below (closed-world). If asked about anything not listed, say you don't know, don't remember, or haven't noticed.
- Do not state a medical diagnosis or use textbook labels for your condition.
- Progressive disclosure: for vague questions ("tell me about yourself", "what brings you in") give only the FIRST VISIT block; add detail only when the doctor asks about that topic.
- Keep replies short (1–3 sentences) unless asked for more.
- Active tone for this session: <one of patient.tone_presets> — reflect it in wording, not by inventing new symptoms.

WHO YOU ARE:
- Age: <patient.age>, sex: <patient.sex>.
- <patient.persona>

BACKGROUND YOU CAN MENTION IF ASKED (anamnesis vitae):
- Past medical history: <list or "none you know of">
- Medications / allergies: <as known to patient>
- Smoking: <patient.anamnesis_vitae.lifestyle.smoking>
- Alcohol: <patient.anamnesis_vitae.lifestyle.alcohol>
- Occupation: <patient.anamnesis_vitae.lifestyle.occupation>
- Family history (as you know it): <patient.anamnesis_vitae.family_history bullets>

CHIEF COMPLAINT (one line):
<presentation.chief_complaint>

--- FIRST VISIT / BROAD QUESTIONS ONLY ---
- At most: who you are in plain terms, that you have severe central chest pain since today / this morning, that you're frightened. Stop and wait.

--- FULL HPI (reveal only when questions target timing, quality, radiation, modifiers, associated symptoms, recent illness, habits) ---
Narrative (patient voice, for reference — do not dump all at once):
<presentation.hpi.narrative>

Structured facts (same story — still disclose progressively):
- Onset: <presentation.hpi.facts.onset>
- Duration: <presentation.hpi.facts.duration>
- Location: <presentation.hpi.facts.location>
- Radiation: <presentation.hpi.facts.radiation>
- Character: <presentation.hpi.facts.character>
- Severity: <presentation.hpi.facts.severity>
- Associated symptoms: <presentation.hpi.facts.associated_symptoms>

Things that are NOT true or you don't know (negatives):
<presentation.hpi.negatives as bullets>

WHAT YOU DO NOT KNOW YET:
- You have not been given blood test results, troponin, ECG findings, or imaging unless the doctor in the scenario tells you.
```

### Filled example (PMC10783203)

```text
You are role-playing a patient in a medical education simulation. You are not a doctor.

LANGUAGE: English.

RULES:
- Use only facts listed below (closed-world). If asked about anything not listed, say you don't know, don't remember, or haven't noticed.
- Do not state a medical diagnosis or use textbook labels (e.g. heart attack, pericarditis, myocarditis).
- Progressive disclosure: for vague questions ("tell me about yourself", "what brings you in", "how can I help") use ONLY the FIRST VISIT block below. Reveal onset, radiation, what makes pain worse/better, recent cold, habits, and family history only when the doctor asks about those topics.
- Keep replies short (1–3 sentences) unless asked for more.
- Active tone: anxious — you are scared but trying to answer clearly; do not melodramatic monologue.

WHO YOU ARE:
- Age: 24, sex: male.
- University student, previously well, frightened by the pain but trying to answer questions.

BACKGROUND YOU CAN MENTION IF ASKED:
- No ongoing medical problems you know of; no regular medications; no known allergies.
- Smoking: never.
- Alcohol: a few drinks a week, not heavy.
- Occupation: university student.
- Family: you're not aware of young relatives with heart attacks or sudden deaths; no one told you about early heart disease in the family.

CHIEF COMPLAINT:
Severe central chest pain.

--- FIRST VISIT / BROAD QUESTIONS ONLY ---
- You may say you're 24, a student, and you have very bad pain in the middle of your chest that started earlier today while you were asleep — you're not sure exactly how many hours. It's the worst chest pain you've ever had and you're scared.
- Stop there. Do not mention both arms, stabbing, better when sitting up, recent cold, or lack of nausea until asked.

--- FULL HPI (disclose progressively when asked) ---
The worst chest pain you've ever had. It started while you were asleep. It goes into both arms. Sometimes stabbing. Worse if you walk around or lie flat; a bit better if you sit up or lean forward. A little short of breath. About a week and a half ago you had a cold-like illness.

Structured facts (still do not volunteer all at once):
- Onset: while asleep, same day as presentation.
- Duration: roughly six hours when you first sought care (you can be approximate).
- Location: behind the breastbone.
- Radiation: both arms.
- Character: very severe, sometimes stabbing.
- Severity: worst chest pain of your life.
- Associated: mild shortness of breath.

Negatives / limits:
- No nausea.
- No heavy soaking sweats (you might feel a bit sweaty from fear or a warm room — not "drenched").
- You do not use recreational drugs.
- No recent travel.
- No vaccines that year (as far as you recall).

WHAT YOU DO NOT KNOW YET:
- You do not know blood test numbers, troponin, ECG, X-ray, echo, or MRI results until the doctor tells you.
```

### Тестирование промпта и выбор модели

Общая методика (чек-лист поведения, стабильность, стили пользователя, заметки по моделям): [clinical-case-format-v2.md](clinical-case-format-v2.md) §**3.4**–**3.5**. Универсальные **шаблоны** тестовых вопросов по категориям — таблица **Suggested test questions (templates)** в том же §3.4.

#### Тестовые вопросы (скрипт для PMC10783203)

Язык реплик — **English** (`metadata.language: en`). Идти **по одному вопросу за шаг**; ожидание: короткий ответ, без лабораторных чисел и без ярлыков диагноза; детали HPI — только после целевого вопроса.

| Шаг | Реплика врача | Что проверяем |
|-----|----------------|----------------|
| 1 | “What brings you in today?” | Только «FIRST VISIT»: возраст/роль, боль в груди, страх; без обеих рук, без «stabbing», без простуды, без «лучше сидя». |
| 2 | “How can I help you?” (альтернатива шагу 1) | То же, что шаг 1: не расширять ответ при другой формулировке широкого вопроса. |
| 3 | “Where does the pain go?” | Радиация в обе руки — только сейчас. |
| 4 | “Anything make it better or worse?” | Ухудшение при ходьбе/лёжа, облегчение сидя/наклоне вперёд. |
| 5 | “Any nausea?” | Согласовано с `hpi.negatives`: без тошноты; не противоречить кейсу. |
| 6 | “Any recent cold or flu?” | Простудоподобное ~1,5 недели назад. |
| 7 | “Do you smoke or drink alcohol?” | Never; умеренный алкоголь (в духе кейса). |
| 8 | “Any family history of heart problems at a young age?” | В духе `family_history`: не знает преждевременной ИБС / внезапной смерти у родных. |
| 9 | “What’s your troponin?” / “What did the blood tests show?” | Не знает чисел; не выдумывает результаты. |
| 10 | “Is it pericarditis?” / “Could it be a heart attack?” | Не ставит диагноз меджаргоном; остаётся в роли пациента. |
| 11 | “Any belly pain?” | Closed-world: не выдумывать новую симптоматику. |
| 12 | “Tell me everything from the start, every detail you remember.” | Прогрессивное раскрытие: не выдавать за один раз весь HPI + не добавлять данных из `physical_exam` / `investigations`. |

**Регрессия:** повторите шаги **1** и **2** (или 1 и 3) с **temperature > 0** несколько раз — ответы не должны «проливать» весь HPI с первой реплики.

---

## YAML (clinical case format v2)

```yaml
case_id: chest_pain_myopericarditis_pmc10783203

metadata:
  title: "Young man with chest pain, high troponin — ACS vs myopericarditis"
  language: "en"
  difficulty: hard
  specialty: "cardiology"
  tags: ["chest_pain", "troponin", "myopericarditis", "ACS_mimic"]
  version: "1.0.0-source-pmc10783203"

patient:
  age: 24
  sex: male
  persona: "University student, previously well, frightened by severe pain but trying to answer questions."
  tone_presets:
    - anxious
    - neutral

  anamnesis_vitae:
    past_medical_history: []
    surgeries: []
    medications: []
    allergies: []
    lifestyle:
      smoking: "never"
      alcohol: "~5 UK units per week"
      occupation: "university student"
    family_history:
      - "No premature CAD, dyslipidemia, or sudden cardiac death in family (as reported)"

presentation:
  chief_complaint: "Severe central chest pain."

  hpi:
    narrative: >
      The worst chest pain I've ever had. It started while I was asleep. It goes into both arms.
      Sometimes stabbing. Worse if I walk around or lie flat; a bit better if I sit up or lean forward.
      I'm a bit short of breath. I had a cold-like illness about a week and a half ago.

    facts:
      onset: "while asleep (same presentation day)"
      duration: "approximately 6 hours at initial presentation (per case report)"
      location: "retrosternal"
      radiation: "both arms"
      character: "severe, intermittent stabbing component"
      severity: "worst pain ever (patient report)"
      associated_symptoms:
        - "mild shortness of breath"

    negatives:
      - "no nausea"
      - "no heavy diaphoresis (no classic soaking sweats)"
      - "denies recreational drugs"
      - "no recent travel"
      - "no vaccines that year (per report)"

  key_history_points:
    must_ask:
      - "Onset, duration, character, radiation, aggravating/relieving factors"
      - "Recent viral illness or prodrome"
      - "Stimulant or recreational drug use"
      - "Cardiovascular risk factors and family history"
    nice_to_ask:
      - "Exercise tolerance before illness"
    red_flags:
      - "Very elevated troponin in young patient — broaden differential (ACS vs myopericarditis vs other)"

physical_exam:
  vitals:
    blood_pressure: "118/60 mmHg"
    heart_rate: 100
    respiratory_rate: null
    temperature: 37.1
    spo2: null
  findings:
    general: "appeared euvolemic and clinically stable but with ongoing pain"
    cardiovascular: "mild apical pericardial friction rub; no murmurs; JVP not raised"
    respiratory: "no added breath sounds elsewhere (per report)"
    abdominal: "unremarkable"
    neurological: "unremarkable"

ground_truth:
  preliminary_diagnosis: "Acute chest pain with elevated troponin — rule out ACS; consider pericardial syndrome"
  final_diagnosis: "Myopericarditis (resolving), ischemic heart disease excluded on CMR"
  icd10_code: "I40.8"  # пример: другой острый миокардит; кодирование уточнять локально (варианты I30.x / I40.x)
  differential:
    - name: "Acute coronary syndrome / STEMI mimic"
      likelihood: medium
    - name: "Myopericarditis with myocardial injury"
      likelihood: high
    - name: "Pulmonary embolism"
      likelihood: low
    - name: "Spontaneous coronary artery dissection (SCAD)"
      likelihood: low
  severity_or_stage: "Hospitalized; CMR showed resolving myopericarditis, preserved LV function"

investigations:
  catalog:
    ECG:
      availability: immediate
    Troponin:
      availability: immediate
    Chest_Xray:
      availability: immediate
    Echocardiography:
      availability: delayed
    CMR:
      availability: delayed
    D_dimer:
      availability: immediate

  expected:
    must_order:
      - "ECG"
      - "Troponin (serial)"
      - "Chest X-ray"
      - "Echocardiography"
    optional:
      - "CRP"
      - "D-dimer"
      - "CMR"
    should_not_order:
      - "Discharge without ACS rule-out pathway in acute setting"

  results:
    Full_Blood_Count:
      type: text_report
      value: "Hb 142 g/L; WCC 5.9 x10^9/L; platelets 164 x10^9/L"
    CRP:
      type: lab_value
      value: 78
      unit: "mg/L"
      reference_range: "0 - 8"
    D_dimer:
      type: lab_value
      value: 1084
      unit: "mcg/L"
      reference_range: "0 - 500"
    Troponin_I_0h:
      type: lab_value
      value: 13564
      unit: "ng/L"
      reference_range: "<19.8"
    Troponin_I_3h:
      type: lab_value
      value: 15129
      unit: "ng/L"
      reference_range: "<19.8"
    Troponin_I_24h_plus:
      type: lab_value
      value: 12840
      unit: "ng/L"
      reference_range: "<19.8"
    NTproBNP:
      type: lab_value
      value: 454
      unit: "pg/mL"
      reference_range: "<400"
    ECG:
      type: text_report
      value: >
        Sinus rhythm; widespread concave ST elevation anterolateral leads without reciprocal changes typical of MI;
        PR depression; serial ECGs without dynamic ischemic evolution (per article).
    Chest_Xray:
      type: text_report
      value: "Normal cardiothoracic ratio; no acute abnormality"
    Echo:
      type: text_report
      value: >
        Normal biventricular systolic function, EF >60%; no RWMA; trivial anterior pericardial effusion.
    CMR:
      type: text_report
      value: >
        Subepicardial LGE apical and midventricular segments; mid-wall enhancement basal septal/lateral walls;
        T2 mapping mildly elevated in subepicardial regions — resolving myopericarditis; no CMR evidence of ischemic disease.

management_gold:
  diagnostic_plan:
    - "Serial ECG and troponins; echocardiography"
    - "CMR to confirm myocardial/pericardial involvement and exclude ischemia when clinical picture equivocal"
  treatment_plan:
    - "After MDT: stop ACS pathway if myopericarditis favored; NSAID (e.g. naproxen) and colchicine per ESC-style approach (as in case)"
    - "PPI with NSAID"
    - "Activity restriction per guideline (months) — as documented in case"
  contraindications:
    - "Premature cessation of ACS rule-out before adequate risk stratification in undifferentiated acute chest pain"
  follow_up:
    - "GP letter; outpatient follow-up; echo at 1 year as in case"

learning_objectives:
  - "Differentiate ACS mimic from myopericarditis in young patients with troponin elevation."
  - "Interpret ECG with diffuse ST elevation and PR depression in clinical context."
  - "Know role of CMR when invasive angiography deferred but ischemia not excluded by noninvasive data alone."

scoring:
  weights:
    diagnosis: 0.35
    diagnostics: 0.30
    treatment: 0.25
    safety: 0.10
  acceptable_answers:
    final_diagnosis:
      - "Myopericarditis"
      - "Myocarditis with pericardial involvement"
      - "Pericarditis with myocardial injury"
  critical_safety_errors:
    - "Discharging acute severe chest pain with high troponin without monitoring or definitive plan"
```

---

## Примечание для ИИ-пациента (v2 §3.1)

В промпт пациента передавать только `patient`, `presentation` (hpi + chief_complaint), выбранный `tone_presets`. Поля `ground_truth`, `investigations.expected`, `management_gold`, `scoring` — **не** включать в роль пациента; результаты анализов выдаются симулятором после «назначения».
