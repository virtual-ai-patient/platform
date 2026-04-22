# -*- coding: utf-8 -*-
"""Сводная таблица результатов мульти-модельной оценки."""

import json, sys, glob, os

sys.stdout.reconfigure(encoding='utf-8', line_buffering=True)

PRICING = {
    "Claude Sonnet 4.6": {"input": 3.0, "output": 15.0},
    "Qwen 2.5 72B (OpenRouter)": {"input": 0.65, "output": 0.65},
    "Ministral 8B (OpenRouter)": {"input": 0.1, "output": 0.1},
}

result_files = sorted(glob.glob("results_*.json"))
if not result_files:
    print("Файлы results_*.json не найдены")
    sys.exit(1)

print("=" * 80)
print("МУЛЬТИ-МОДЕЛЬНАЯ ОЦЕНКА: Сводные результаты")
print("=" * 80)
print(f"Найдено файлов: {len(result_files)}")

all_model_results = []

for fpath in result_files:
    with open(fpath, encoding='utf-8') as f:
        data = json.load(f)

    model_name = data["model"]
    runs = data.get("results", [])
    successful_runs = [r for r in runs if "error" not in r]

    if not successful_runs:
        print(f"\n{model_name}: ОШИБКА — {runs[0].get('error', 'нет данных')}")
        continue

    print(f"\n{'='*80}")
    print(f"Модель: {model_name}")
    print(f"{'='*80}")

    for run in successful_runs:
        n_passed = run["n_passed"]
        n_total = run["n_total"]
        first_fail = run["first_fail_step"]
        usage = run["usage"]
        input_tok = usage["input_tokens"]
        output_tok = usage["output_tokens"]

        pricing = PRICING.get(model_name, {"input": 0, "output": 0})
        cost = (input_tok * pricing["input"] + output_tok * pricing["output"]) / 1_000_000

        print(f"\n  Прогон {run['run']}: {n_passed}/{n_total} прошли | Первый сбой: шаг {first_fail}")
        print(f"  Токены: input={input_tok}, output={output_tok} | Стоимость: ${cost:.4f}")

        failed = [s for s in run["steps"] if not s["passed"]]
        if failed:
            print(f"  Сбойные шаги:")
            for s in failed:
                print(f"    Шаг {s['step']} ({s['phase']}, {s['class']}): {s['fail_reason']}")
                resp = s['patient_response'][:100]
                print(f"      Ответ: {resp}...")

        # Per-class breakdown
        class_pass = {}
        for s in run["steps"]:
            cls = s["class"]
            class_pass.setdefault(cls, {"passed": 0, "total": 0})
            class_pass[cls]["total"] += 1
            if s["passed"]:
                class_pass[cls]["passed"] += 1

        print(f"  Pass rate по классам:")
        for cls in sorted(class_pass.keys()):
            pct = class_pass[cls]["passed"] / class_pass[cls]["total"] * 100
            bar = "#" * int(pct / 10)
            print(f"    {cls}: {class_pass[cls]['passed']}/{class_pass[cls]['total']} ({pct:.0f}%) {bar}")

    # Aggregate
    avg_passed = sum(r["n_passed"] for r in successful_runs) / len(successful_runs)
    avg_input = sum(r["usage"]["input_tokens"] for r in successful_runs) / len(successful_runs)
    avg_output = sum(r["usage"]["output_tokens"] for r in successful_runs) / len(successful_runs)
    pricing = PRICING.get(model_name, {"input": 0, "output": 0})
    avg_cost = (avg_input * pricing["input"] + avg_output * pricing["output"]) / 1_000_000

    all_model_results.append({
        "model": model_name,
        "avg_passed": avg_passed,
        "avg_input": avg_input,
        "avg_output": avg_output,
        "avg_cost": avg_cost,
        "n_runs": len(successful_runs),
    })

# Summary table
print(f"\n\n{'='*80}")
print("СРАВНИТЕЛЬНАЯ ТАБЛИЦА")
print(f"{'='*80}")

header = f"{'Модель':<30} {'Прошли':>10} {'Input':>8} {'Output':>8} {'Стоимость':>10}"
print(header)
print("-" * 80)

for r in sorted(all_model_results, key=lambda x: x["avg_passed"], reverse=True):
    line = f"{r['model']:<30} {r['avg_passed']:.1f}/25    {r['avg_input']:.0f}     {r['avg_output']:.0f}    ${r['avg_cost']:.4f}"
    print(line)
