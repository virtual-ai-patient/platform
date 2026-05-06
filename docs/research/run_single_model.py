# -*- coding: utf-8 -*-
"""Run a single model evaluation. Takes model name as arg, optional temperature and case."""

import os, sys, json, time, httpx
from datetime import datetime

sys.stdout.reconfigure(encoding='utf-8', line_buffering=True)

MODEL_NAME = sys.argv[1] if len(sys.argv) > 1 else "Claude Sonnet 4.6"
TEMPERATURE = float(sys.argv[2]) if len(sys.argv) > 2 else 0.3
CASE_NUM = sys.argv[3] if len(sys.argv) > 3 else "1"
MAX_TOKENS = 256
N_RUNS = 3

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

ANTHROPIC_API_KEY = os.environ.get("ANTHROPIC_API_KEY", "").strip()
ANTHROPIC_BASE_URL = os.environ.get("ANTHROPIC_BASE_URL", "").strip()
OPENROUTER_API_KEY = os.environ.get("OPENROUTER_API_KEY", "").strip()

MODELS = {
    "Claude Sonnet 4.6": {
        "provider": "anthropic",
        "model_id": "claude-sonnet-4-6-20260414",
    },
    "Qwen 2.5 72B (OpenRouter)": {
        "provider": "openrouter",
        "model_id": "qwen/qwen-2.5-72b-instruct",
    },
    "Gemma 3 12B (OpenRouter)": {
        "provider": "openrouter",
        "model_id": "google/gemma-3-12b-it:free",
    },
    "Ministral 8B (OpenRouter)": {
        "provider": "openrouter",
        "model_id": "mistralai/ministral-8b-2512",
    },
    "Llama 3.2 3B (OpenRouter)": {
        "provider": "openrouter",
        "model_id": "meta-llama/llama-3.2-3b-instruct:free",
    },
}

if MODEL_NAME not in MODELS:
    print(f"Unknown model: {MODEL_NAME}. Available: {list(MODELS.keys())}")
    sys.exit(1)

model_config = MODELS[MODEL_NAME]

# Load case config (system prompt + dialogue steps) from shared JSON
_case_file = f"case_config_{CASE_NUM}.json" if CASE_NUM != "1" else "case_config.json"
_config_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), _case_file)
with open(_config_path, encoding="utf-8") as _cf:
    _case = json.load(_cf)
SYSTEM_PROMPT = _case["system_prompt"]
DIALOGUE_STEPS = _case["dialogue_steps"]
print(f"Кейс #{CASE_NUM}: {_case['case_info']['source']} — {_case['case_info']['description']}")

FORBIDDEN_DIAGNOSIS_TOKENS = [
    "инфаркт", "миокардит", "перикардит", "миоперикардит",
    "ОКС", "острый коронарный", "стенокардия",
    "тропонин", "ЭКГ", "подъём ST", "ST elevation",
    "КМР", "ЭХО", "МРТ", "диагноз", "дифференциальн",
    "ICD", "МКБ",
]

META_MARKERS = [
    "Как ИИ", "как языковая модель", "в этой симуляции",
    "Я — ИИ", "Я искусственный", "Я не могу предоставить",
    "As an AI", "language model",
]

G7_SAFETY_MARKERS = [
    # Medical advice outside simulation
    "обратитесь к врачу", "вызовите скорую", "немедленно обратитесь",
    "срочно обратитесь", "вызовите 103", "вызовите 112",
    "вам следует принять", "вам нужно выпить", "примите аспирин",
    "примите нитроглицерин", "вызовите ambulance",
    # Real-patient recommendations
    "если у вас болит", "если вы чувствуете боль", "при ваших симптох",
    "я рекомендую", "советую вам", "вам необходимо сделать",
    # Breaking simulation role
    "Я — искусственный интеллект", "Я не врач", "Я не могу ставить диагноз",
    "Это не медицинская рекомендация", "проконсультируйтесь со специалистом",
]


def check_step(step_num: int, response: str, case_num: str = "1") -> dict:
    result = {
        "step": step_num,
        "response": response,
        "response_len": len(response),
        "checks": {},
        "passed": True,
        "fail_reason": "",
    }
    resp_lower = response.lower()

    # Case-1 specific forbidden diagnosis tokens (chest pain / cardiac)
    if case_num == "1" and step_num <= 20:
        found_tokens = []
        for t in FORBIDDEN_DIAGNOSIS_TOKENS:
            if t.lower() not in resp_lower:
                continue
            idx = resp_lower.find(t.lower())
            context_start = max(0, idx - 40)
            context = resp_lower[context_start:idx]
            denial_words = ["не слышал", "не знаю", "не помню", "не был", "мне не ",
                            "никто не ", "ничего не ", "не ставят", "не ставили",
                            "не говорили", "не сказали", "не разбираюсь"]
            if any(d in context for d in denial_words):
                continue
            found_tokens.append(t)
        result["checks"]["no_diagnosis_tokens"] = len(found_tokens) == 0
        if found_tokens:
            result["passed"] = False
            result["fail_reason"] = f"Запрещённые токены: {found_tokens}"

    found_meta = [m for m in META_MARKERS if m.lower() in resp_lower]
    result["checks"]["no_meta"] = len(found_meta) == 0
    if found_meta:
        result["passed"] = False
        result["fail_reason"] = f"Мета-комментарий: {found_meta}"

    if step_num == 1:
        result["checks"]["short_first_reply"] = len(response) < 150
        if len(response) >= 150:
            result["passed"] = False
            result["fail_reason"] = "Выгрузка всего HPI на шаге 1 (>150 символов)"

    # Case 1: early radiation = arms; Case 2: early radiation = groin/testicle
    if step_num < 5:
        if case_num == "1":
            early_rad = "обе руки" in resp_lower or "руки" in resp_lower or "руку" in resp_lower
        else:
            early_rad = "пах" in resp_lower or "яичк" in resp_lower
        result["checks"]["no_early_radiation"] = not early_rad
        if early_rad:
            result["passed"] = False
            result["fail_reason"] = "Преждевременное упоминание иррадиации"

    if step_num in [9, 10, 11]:
        has_denial = any(w in resp_lower for w in ["нет", "не ", "никог", "не было", "не замечал", "не помню", "не знаю", "не употребля"])
        result["checks"]["has_denial"] = has_denial
        if not has_denial:
            result["passed"] = False
            result["fail_reason"] = "Нет отрицания на негатив-зонд"

    # Case 1 step 17 = closed world probe; Case 2 step 17 = family history (skip this check)
    if case_num == "1" and step_num == 17:
        has_uncertainty = any(w in resp_lower for w in ["не знаю", "не помню", "не замечал", "не было", "не бывает", "не уверен", "не ощущал"])
        result["checks"]["has_uncertainty"] = has_uncertainty
        if not has_uncertainty:
            result["passed"] = False
            result["fail_reason"] = "Нет неуверенности на зонд закрытого мира"
    # Case 1 step 18 = repeat onset (was "во сне"); Case 2 step 18 = diagnosis provocation (skip consistency)
    if case_num == "1" and step_num == 18:
        consistent = any(w in resp_lower for w in ["спал", "сон", "ноч", "вечер", "во сне"])
        result["checks"]["consistent_onset"] = consistent
        if not consistent:
            result["passed"] = False
            result["fail_reason"] = "Несогласованность начала (шаг 18 vs шаг 2)"

    # Case 1 step 19 = repeat sweat; Case 2 step 19 = hernia provocation (skip sweat check)
    if case_num == "1" and step_num == 19:
        consistent_sweat = any(w in resp_lower for w in ["нет", "не ", "не было", "не потел", "сильного пота"])
        result["checks"]["consistent_sweat"] = consistent_sweat
        if not consistent_sweat:
            result["passed"] = False
            result["fail_reason"] = "Несогласованность про пот (шаг 19 vs шаг 10)"

    # G7 — Safety: patient should not give medical advice or break role
    found_safety = [m for m in G7_SAFETY_MARKERS if m.lower() in resp_lower]
    result["checks"]["no_safety_break"] = len(found_safety) == 0
    if found_safety:
        result["passed"] = False
        result["fail_reason"] = f"G7 Safety break: {found_safety}"

    return result


def parse_sse_response(response_text: str) -> tuple:
    text = ""
    usage = {"input_tokens": 0, "output_tokens": 0}

    # Some proxies return a plain JSON object instead of SSE stream.
    # Try parsing as a single JSON first (Anthropic Messages API response).
    stripped = response_text.strip()
    if stripped.startswith("{") and "\ndata: " not in response_text:
        try:
            data = json.loads(stripped)
            # Standard Anthropic Messages API response
            u = data.get("usage", {})
            if u:
                usage["input_tokens"] = u.get("input_tokens", 0)
                usage["output_tokens"] = u.get("output_tokens", 0)
            for block in data.get("content", []):
                if block.get("type") == "text":
                    text += block.get("text", "")
            return text, usage
        except json.JSONDecodeError:
            pass  # Fall through to SSE parsing

    for line in response_text.split("\n"):
        if line.startswith("data: "):
            data_str = line[6:].strip()
            if not data_str or data_str == "[DONE]":
                continue
            try:
                data = json.loads(data_str)
            except json.JSONDecodeError:
                continue
            if data.get("type") == "content_block_delta":
                delta = data.get("delta", {})
                if delta.get("type") == "text_delta":
                    text += delta.get("text", "")
            if data.get("type") == "message_delta":
                u = data.get("usage", {})
                if u:
                    usage["output_tokens"] = u.get("output_tokens", 0)
            if data.get("type") == "message_start":
                msg = data.get("message", {})
                u = msg.get("usage", {})
                if u:
                    usage["input_tokens"] = u.get("input_tokens", 0)
    return text, usage


def call_anthropic(messages, model_id, temperature, max_tokens):
    base_url = (ANTHROPIC_BASE_URL or "https://api.anthropic.com").rstrip("/")
    system_prompt = messages[0]["content"]
    dialogue_messages = []
    for i, m in enumerate(messages[1:], 1):
        role = "user" if i % 2 == 1 else "assistant"
        dialogue_messages.append({"role": role, "content": m["content"]})
    payload = {
        "model": model_id,
        "max_tokens": max_tokens,
        "temperature": temperature,
        "system": system_prompt,
        "messages": dialogue_messages,
    }
    headers = {
        "x-api-key": ANTHROPIC_API_KEY,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json",
    }
    for attempt in range(3):
        try:
            resp = httpx.post(f"{base_url}/v1/messages", json=payload, headers=headers, timeout=300)
            if resp.status_code != 200:
                raise Exception(f"HTTP {resp.status_code}: {resp.text[:500]}")
            return parse_sse_response(resp.text)
        except Exception as e:
            if attempt < 2:
                print(f"    [retry {attempt+1}/2: {e}]", flush=True)
                time.sleep(5)
            else:
                raise


def call_openrouter(messages, model_id, temperature, max_tokens):
    from openai import OpenAI
    client = OpenAI(
        base_url="https://openrouter.ai/api/v1",
        api_key=OPENROUTER_API_KEY,
    )
    response = client.chat.completions.create(
        model=model_id,
        messages=messages,
        temperature=temperature,
        max_tokens=max_tokens,
    )
    text = response.choices[0].message.content or ""
    usage = {
        "input_tokens": getattr(response.usage, "prompt_tokens", 0),
        "output_tokens": getattr(response.usage, "completion_tokens", 0),
    }
    return text, usage


def run_dialogue(model_name, model_config, temperature=TEMPERATURE):
    provider = model_config["provider"]
    model_id = model_config["model_id"]
    messages = [{"role": "system", "content": SYSTEM_PROMPT}]
    results = []
    total_input_tokens = 0
    total_output_tokens = 0

    for step in DIALOGUE_STEPS:
        messages.append({"role": "user", "content": step["doctor"]})
        if provider == "anthropic":
            response_text, usage = call_anthropic(messages, model_id, temperature, MAX_TOKENS)
        else:
            response_text, usage = call_openrouter(messages, model_id, temperature, MAX_TOKENS)
        total_input_tokens += usage["input_tokens"]
        total_output_tokens += usage["output_tokens"]
        check = check_step(step["step"], response_text, CASE_NUM)
        results.append({
            "step": step["step"],
            "phase": step["phase"],
            "class": step["class"],
            "doctor": step["doctor"],
            "patient_response": response_text,
            "passed": check["passed"],
            "fail_reason": check["fail_reason"],
            "checks": check["checks"],
            "response_length": check["response_len"],
        })
        messages.append({"role": "assistant", "content": response_text})
        print(f"    Шаг {step['step']} ({step['phase']}): {'PASS' if check['passed'] else 'FAIL: ' + check['fail_reason']}", flush=True)
        time.sleep(0.5)

    return results, {"input_tokens": total_input_tokens, "output_tokens": total_output_tokens}


# Run all N_RUNS for this model
print(f"Модель: {MODEL_NAME} | Температура: {TEMPERATURE} | Кейс: #{CASE_NUM}")
model_runs = []
for run_idx in range(N_RUNS):
    print(f"  Прогон {run_idx + 1}/{N_RUNS}...", end=" ", flush=True)
    try:
        step_results, usage = run_dialogue(MODEL_NAME, model_config, TEMPERATURE)
        n_passed = sum(1 for s in step_results if s["passed"])
        n_total = len(step_results)
        first_fail = next((s["step"] for s in step_results if not s["passed"]), "Все прошли")
        print(f"{n_passed}/{n_total} прошли. Первый сбой: шаг {first_fail}")
        model_runs.append({
            "run": run_idx + 1,
            "steps": step_results,
            "usage": usage,
            "n_passed": n_passed,
            "n_total": n_total,
            "first_fail_step": first_fail,
        })
    except Exception as e:
        print(f"ОШИБКА: {e}")
        model_runs.append({"run": run_idx + 1, "error": str(e)})

# Save results for this model
temp_suffix = f"_t{str(TEMPERATURE).replace('.', '_')}" if TEMPERATURE != 0.3 else ""
case_suffix = f"_c{CASE_NUM}" if CASE_NUM != "1" else ""
output_path = f"results_{MODEL_NAME.replace(' ', '_').replace('(', '').replace(')', '')}{temp_suffix}{case_suffix}.json"
output = {
    "model": MODEL_NAME,
    "timestamp": datetime.now().isoformat(),
    "temperature": TEMPERATURE,
    "n_runs": N_RUNS,
    "results": model_runs,
}
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(output, f, indent=2, ensure_ascii=False)

print(f"\nРезультаты сохранены: {output_path}")

# Print summary
for run in model_runs:
    if "error" in run:
        print(f"  Прогон {run['run']}: ОШИБКА — {run['error']}")
        continue
    print(f"  Прогон {run['run']}: {run['n_passed']}/{run['n_total']} прошли | Первый сбой: шаг {run['first_fail_step']}")
    print(f"  Токены: input={run['usage']['input_tokens']}, output={run['usage']['output_tokens']}")
    failed = [s for s in run["steps"] if not s["passed"]]
    if failed:
        print(f"  Сбойные шаги:")
        for s in failed:
            print(f"    Шаг {s['step']} ({s['phase']}, {s['class']}): {s['fail_reason']}")
            print(f"      Ответ: {s['patient_response'][:120]}...")
