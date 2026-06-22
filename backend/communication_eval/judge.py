import json
import re

from pydantic import ValidationError

from core.provider import AIProvider
from exceptions.auth_exceptions import JudgeError
from models.db import ActionLog

from communication_eval.judge_schemas import (
    CRITERION_NAMES,
    JudgeOutput,
    compute_total_score,
)

JUDGE_MARKER = "COMMUNICATION_JUDGE_V1"


def build_transcript(logs: list[ActionLog]) -> str:
    chat_logs = [log for log in logs if log.role in ("user", "assistant")]
    if not chat_logs:
        return "(No doctor-patient dialogue recorded.)"

    lines: list[str] = []
    for index, log in enumerate(chat_logs, start=1):
        speaker = "Doctor" if log.role == "user" else "Patient"
        lines.append(f"{index}. {speaker}: {log.content}")
    return "\n".join(lines)


def build_system_prompt() -> str:
    criteria_list = ", ".join(CRITERION_NAMES)
    return f"""{JUDGE_MARKER}
You are a medical communication skills evaluator. Score ONLY the doctor's communication style.
Do NOT provide clinical advice, diagnoses, or treatment recommendations.

Evaluate the transcript against these criteria: {criteria_list}.
Each criterion score must be an integer from 0 to 5.

Respond with JSON only, matching this schema:
{{
  "criteria": [
    {{
      "criterion": "<one of the criterion names>",
      "score": <0-5>,
      "rationale": "<brief explanation>",
      "quote": "<short verbatim excerpt from the transcript>"
    }}
  ]
}}

Include exactly one entry per criterion. Use temperature-neutral, consistent scoring."""


def build_user_prompt(transcript: str) -> str:
    return (
        f"Score the following doctor-patient transcript.\n\nTRANSCRIPT:\n{transcript}"
    )


def _strip_json_fences(raw: str) -> str:
    text = raw.strip()
    if text.startswith("```"):
        text = re.sub(r"^```(?:json)?\s*", "", text, flags=re.IGNORECASE)
        text = re.sub(r"\s*```$", "", text)
    return text.strip()


async def run_judge(
    logs: list[ActionLog],
    provider: AIProvider,
) -> tuple[JudgeOutput, float]:
    transcript = build_transcript(logs)
    messages = [
        {"role": "system", "content": build_system_prompt()},
        {"role": "user", "content": build_user_prompt(transcript)},
    ]

    try:
        raw = await provider.complete(
            messages,
            temperature=0.0,
            json_mode=True,
        )
    except Exception as exc:
        raise JudgeError("LLM provider failed during communication evaluation") from exc

    try:
        payload = json.loads(_strip_json_fences(raw))
        result = JudgeOutput.model_validate(payload)
    except (json.JSONDecodeError, ValidationError, ValueError) as exc:
        raise JudgeError("LLM returned invalid communication evaluation JSON") from exc

    return result, compute_total_score(result.criteria)
