# Feature: LLM-based communication evaluation

Evaluate how well the learner's conversation with the virtual patient
matches medical communication norms (open-ended questions, empathy,
structured history-taking, closing the loop, avoidance of leading
questions). Runs as an LLM-as-judge over the persisted chat log of a
session and surfaces a per-criterion breakdown in the debrief.

| # | Task | Side |
|---|---|---|
| 01 | LLM-based communication evaluation API | Backend |
| 02 | Communication evaluation panel in debrief | Frontend |

Dependency: 02 depends on 01.
