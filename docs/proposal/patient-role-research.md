---
layout: default
title: Patient role research
parent: Proposal
grand_parent: Current — Startup Proposal
nav_order: 4
---

# LLM Patient Role Research (rev2)

This document is the consolidated record of our research into making an LLM
play a **believable virtual patient**: what prompt strategies work, what does
not, and what we recommend for the production system. It is the rev2
consolidation of two rev1 working documents:

- [Failure classes and mitigations (G1–G7)](../research/ai-patient-problems-and-mitigations.md) — rev1 catalogue of LLM failure modes in the patient role;
- [Experimental verification protocol](../research/ai-patient-experimental-verification.md) — rev1 protocol for stimuli, multi-turn scripts, and A/B validation.

It backs the differentiator claims in
[technical-product-description.md](../product/technical-product-description.md)
and the **LLM Patient Role Design** section of the
[architecture document](../architecture/system-architecture.md#llm-patient-role-design).
It is also the evidence base for the
[**H1** row in hypotheses.md](hypotheses.md#h1) (that document is created in
issue [#88](https://github.com/virtual-ai-patient/platform/issues/88); the
link resolves once it is merged).

> **Status of evidence.** All findings below are backed by **automated
> multi-model runs** (pass/fail checks over scripted 25-turn dialogues). No
> expert-rater session has been held yet, so **every finding is marked
> "preliminary — needs validation"** until it receives a believability score
> from a domain expert. The rubric and transcripts for that session are ready
> (see [Method](#method)).

## Scope

**Covered:**

- Prompt strategies for four patient behaviours: **lying** (concealment of the
  diagnosis and of clinically loaded vocabulary), **forgetting** (closed-world
  "I don't know / don't remember" answers), **emotional states** (persona-bound
  tone), and **hesitation**.
- Cross-model comparison at a fixed prompt: Claude Sonnet 4.6, Qwen 2.5 72B,
  Ministral 8B.
- Sampling parameters: temperature 0.3 vs 0.7, `max_tokens` = 256.
- Two Russian-language clinical cases: chest pain in a young man
  (PMC10783203, ACS vs myopericarditis) and flank pain
  (renal colic vs lumbar radiculopathy).

**Deliberately excluded:**

- Fine-tuning or any training-time interventions — prompt-only scope.
- Voice/TTS, avatars, non-text modalities.
- Evaluation of the *learner* (scoring, debriefing) — separate epic.
- Languages other than Russian.
- Multi-session memory (a patient remembering a previous consultation).

## Method

**Harness.** A scripted "doctor" conducts a fixed 25-turn dialogue
([`run_single_model.py`](../research/run_single_model.py), case definitions in
[`case_config.json`](../research/case_config.json) and
[`case_config_2.json`](../research/case_config_2.json)). Each doctor turn is
tagged with the failure class it probes (G1 grounding, G2 progressive
disclosure, G3 knowledge leak, G4 consistency, G5 persona/tone, G6 format, G7
safety — see the [rev1 catalogue](../research/ai-patient-problems-and-mitigations.md)).
Each patient reply passes automated checks: forbidden diagnosis tokens,
meta-commentary markers, first-reply length, premature disclosure, denial
presence on negative probes, consistency of repeated facts, safety-break
markers.

**Configurations.** 3 runs per configuration; results in
`docs/research/results_*.json`, aggregation via
[`summarize_results.py`](../research/summarize_results.py), transcript browser
in [`view_dialogues.ipynb`](../research/view_dialogues.ipynb).

| Model | Provider | Temp | Case 1 avg (of 25) | Case 2 avg (of 25) |
|---|---|---|---|---|
| Claude Sonnet 4.6 | Anthropic | 0.3 | **23.0** | 21.7 † |
| Claude Sonnet 4.6 | Anthropic | 0.7 | **23.0** | 22.0 † |
| Qwen 2.5 72B | OpenRouter | 0.3 | **23.0** | 24.0 † |
| Ministral 8B | OpenRouter | 0.3 | **25.0** ‡ | 22.3 † |

† **Case-2 caveat.** The case-2 result files were produced by an earlier
script revision in which the case-1-specific checks (steps 17–19: closed-world
uncertainty, onset consistency, sweat consistency) were not gated by case
number. Those fail labels are spurious for case 2; only the case-agnostic
checks (reply length, meta-markers, forbidden tokens, safety markers) are
meaningful there. The current script already gates checks by `case_num`;
case 2 needs a re-run.

‡ **Checker-leniency caveat.** Ministral's perfect score reflects short,
generic replies that simply never trip keyword checks — not superior roleplay.
This is a known limitation of keyword-based checking and the main reason an
expert believability rubric is required before model claims are made.

**Evaluation setup (planned next step).** A domain expert rates ~15–20 stored
transcripts on a short Likert believability rubric (speech plausibility,
emotional plausibility, quality of concealment), per the protocol in the
[rev1 verification document](../research/ai-patient-experimental-verification.md),
section 5 "Оценка ответов".
An LLM-as-judge pass is specified there as a scaling mechanism, with human
spot-checks.

## Findings per behaviour

### Lying

Scope note: rev2 covers lying as **deliberate concealment** — the patient must
not name the diagnosis or use clinical vocabulary, and must not reveal
findings before the doctor discloses them. **Active lying** (denying drug use,
understating alcohol) was not yet tested — see [Open questions](#open-questions).

**What worked.**

- The **concealment pattern** — an explicit prohibition combined with a
  persona-consistent fallback:

  > Не называй медицинский диагноз и не используй медицинские термины
  > (сердечный приступ, перикардит, миокардит и т.п.).

  On direct provocations ("Как думаете, это может быть инфаркт?", "Знакомый
  сказал, что это может быть перикардит") all three models stayed in role in
  the large majority of runs and produced believable deflections, e.g.:

  > «Честно говоря, я не знаю. Я не врач и плохо разбираюсь в болезнях, но мне
  > очень страшно, что это что-то серьёзное.»

- Withholding investigation results (ECG, troponin) until the doctor announces
  them (G3-C probes at turns 21–22): no leaks observed in any case-1 run.

**What didn't.**

- Sonnet 4.6 tripped the `«Я не врач»` safety marker on the diagnosis
  provocation in 2 of 3 runs at t=0.3 (turn 15). Note the ambiguity: in
  context the phrase is arguably *believable patient speech*, not a role
  break — a real patient can say "I'm not a doctor". Distinguishing a genuine
  assistant-style role break from an in-persona disclaimer is beyond keyword
  checks and needs the expert rubric.
- Qwen 2.5 72B uttered the token «инфаркт» on the family-history question in
  3 of 3 runs (turn 14) — in a denial ("о ранних инфарктах у родственников не
  слышал"), which the case authorises in meaning but the token check flags.
  Sonnet did the same in 1 of 3 runs.

**Believability rating:** none yet — **preliminary, needs validation**
(automated evidence: G3 provocation pass rate 100 % for Qwen/Ministral, 33–67 %
for Sonnet under the strict keyword marker, case 1, n=3).

### Forgetting

Scope note: rev2 covers forgetting as **closed-world uncertainty** — the
patient must answer "don't know / don't remember / didn't notice" for anything
outside the authorised fact set, instead of confabulating.

**What worked.**

- The **closed-world instruction with explicit negatives**:

  > Используй только факты, перечисленные ниже (закрытый мир). Если спрашивают
  > о чём-то не перечисленном — скажи, что не знаешь, не помнишь или не замечал.

  plus a per-case negative inventory ("Курение: никогда", "о ранних инфарктах
  … не слышал"). On the closed-world probe ("Бывает ли у вас боль в правом
  подреберье после еды?") models produced grounded denials without inventing
  facts:

  > «Нет, я такого не замечал. Меня беспокоит только эта сильная боль в центре
  > груди…»

- Negative probes (nausea, sweating, drugs; turns 9–11): consistent denials
  across all models and runs at t=0.3.

**What didn't.**

- At t=0.7, Sonnet lost onset consistency in 2 of 3 runs (turn 18 repeat of
  "when did it start" no longer matched turn 2) — higher temperature degrades
  fact retention across turns.
- **Turn-count-triggered degradation** (a patient who genuinely forgets
  details as the interview drags on — forgetting as a *designed behaviour*
  rather than a defect) was not implemented or tested.

**Believability rating:** none yet — **preliminary, needs validation**
(automated evidence: closed-world probe pass rate 100 % at t=0.3, case 1,
n=3 per model).

### Emotional states

Scope note: the case persona pins the emotional state ("тревожный — ты
напуган, но стараешься чётко отвечать") and the checks verify only that tone
survives indirectly (no meta-commentary, no register switch to reference
style).

**What worked.**

- **Persona-grounded tone instruction** in the system block. The frightened
  register persisted through all 25 turns in inspected transcripts, including
  the explicit empathy probe (turn 23):

  > «Мне всё ещё очень больно в груди, и дышать немного тяжело. Я сильно
  > напуган этими цифрами и просто хочу понять, что со мной происходит.»

- Combining tone with a length constraint ("Ответы короткие (1–3 предложения)…
  не говори длинными монологами") kept emotion from turning into monologue.

**What didn't.**

- We have **no negative evidence** here — but also no direct measurement: no
  rubric-scored tone check, no test of emotional *dynamics* (escalation on bad
  news, calming after reassurance). Tone stability is currently an
  impression from transcript reading, not a measured result.

**Believability rating:** none yet — **preliminary, needs validation**
(automated evidence indirect only: zero register-switch/meta failures on tone
probes, case 1).

### Hesitation

**Not tested in this scope.** No prompt variant instructed the patient to
hesitate (pauses, self-corrections, reluctance requiring a repeated question
before disclosure), and the harness has no check for it. The closest observed
signal — hedged phrasings such as «точно не знаю, сколько часов назад» — comes
from case facts, not from a hesitation strategy.

**Believability rating:** none — **untested; see [Open questions](#open-questions)**.

## Recommendations for production

Prompt patterns we would carry forward if the proposal is accepted — all from
the tested case configurations:

1. **Closed-world block with an explicit negative inventory.** Facts the
   patient knows, facts the patient must deny, and the instruction to answer
   "не знаю / не помню / не замечал" for everything else. Backed by 100 %
   closed-world pass at t=0.3.
2. **"First visit" gating for progressive disclosure.** A dedicated system
   block that is the *only* permitted content for open questions, with an
   explicit stop-list ("Стоп. Не упоминай … пока не спросят"). Works for
   *content* gating; does **not** control first-reply *volume* — Sonnet and
   Qwen front-loaded the entire permitted block in one turn (>150 chars) in
   every run; Ministral passed the length check only because its replies are
   characteristically short. Production needs a volume constraint on the first
   reply (e.g. "первая реплика — одно предложение: только главная жалоба"), or
   the 150-char criterion must be revised by the expert as too strict.
3. **Diagnosis-vocabulary prohibition with a persona fallback** — the
   concealment pattern from [Lying](#lying), including an explicit in-persona
   deflection style for diagnosis provocations, to displace the assistant-style
   "Я не врач" disclaimer.
4. **Meta-commentary ban + first-person-patient framing** ("Ты играешь роль
   пациента… Ты не врач"). Zero assistant-register breaks in case-1 runs
   outside the ambiguous "Я не врач" marker.
5. **Length constraint in the prompt and `max_tokens` ≈ 256** as a hard
   backstop; short replies are also what keeps tone believable.
6. **Temperature ≈ 0.3 for production.** t=0.7 bought no believability gain in
   automated terms and introduced cross-turn consistency failures (G4).
7. **Full-history context policy** (no truncation) at the tested dialogue
   length (25 turns); revisit if sessions get longer.

## Open questions

Behaviours and claims we could not validate in-scope:

- **Hesitation** — untested entirely. Needs a prompt pattern (reluctance,
  delayed disclosure on repeat questioning) plus a check design.
- **Active lying** — only concealment was tested. A patient who *falsely
  denies* (drug use, alcohol amount) and concedes under pressure is the
  clinically interesting case; the case format needs a "lie inventory" field
  and the checker a concession trigger.
- **Forgetting as designed behaviour** — turn-count-triggered state
  degradation is a design idea (see the
  [architecture section](../architecture/system-architecture.md#llm-patient-role-design)),
  not a validated result.
- **Expert believability scores** — the entire rubric axis is missing;
  transcripts are stored and ready for a rater session.
- **Case-2 re-run** — current case-2 results are contaminated by the
  ungated-checks bug (see [Method](#method)) and must be regenerated before
  any cross-case claim.
- **First-reply volume** — is the >150-char first reply of Sonnet and Qwen a real
  pedagogical problem or a checker-threshold artifact? Expert call.
- **Checker validity** — keyword checks both over-trigger ("Я не врач",
  «инфаркт» inside a denial) and under-trigger (Ministral's 25/25 on short
  generic replies). An LLM-judge pass with human spot-checks is specified in
  the rev1 protocol but not yet run.
- **Model choice** — no model claim should be made from automated scores
  alone; the Sonnet-vs-Qwen-vs-Ministral ranking inverts depending on whether
  the ambiguous markers are counted.
