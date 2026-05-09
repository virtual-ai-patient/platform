#!/usr/bin/env bash
# Seed clinical cases via the public API (POST /cases) as an educator.
#
# Prerequisites: backend running; educator user exists (e.g. compose-seeded).
#
# Usage:
#   ./scripts/seed_clinical_cases.sh
#   BACKEND_BASE_URL=http://localhost:8000 EDUCATOR_PASSWORD=secret ./scripts/seed_clinical_cases.sh
#
# Docker (API inside network — from host use published port):
#   ./scripts/seed_clinical_cases.sh
#
# Environment (optional; defaults match .env.example):
#   BACKEND_BASE_URL   default http://localhost:8000
#   EDUCATOR_USERNAME  default educator
#   EDUCATOR_PASSWORD  default changeme

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ -f "$REPO_ROOT/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$REPO_ROOT/.env"
  set +a
fi

BASE_URL="${BACKEND_BASE_URL:-http://localhost:8000}"
BASE_URL="${BASE_URL%/}"
USER_NAME="${EDUCATOR_USERNAME:-educator}"
PASSWORD="${EDUCATOR_PASSWORD:-changeme}"

CASE_FILES=(
  "$SCRIPT_DIR/case_seed/seed_em_stemi_001.json"
  "$SCRIPT_DIR/case_seed/seed_peds_otitis_002.json"
  "$SCRIPT_DIR/case_seed/seed_neuro_stroke_003.json"
  "$SCRIPT_DIR/case_seed/seed_im_dka_004.json"
  "$SCRIPT_DIR/case_seed/seed_draft_review_005.json"
  "$SCRIPT_DIR/case_seed/case_001.json"
  "$SCRIPT_DIR/case_seed/case_002.json"
  "$SCRIPT_DIR/case_seed/case_003.json"
)

for f in "${CASE_FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Missing fixture: $f" >&2
    exit 1
  fi
done

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required" >&2
  exit 1
fi
if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required (to parse login JSON)" >&2
  exit 1
fi

LOGIN_JSON="$(curl -sS -X POST "$BASE_URL/auth/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "username=$USER_NAME" \
  --data-urlencode "password=$PASSWORD" \
  --data-urlencode "grant_type=password" \
  --data-urlencode "scope=")"

TOKEN="$(printf '%s' "$LOGIN_JSON" | python3 -c "import sys, json; d=json.load(sys.stdin); print(d.get('access_token',''))")"

if [[ -z "$TOKEN" ]]; then
  echo "Login failed for user '$USER_NAME' at $BASE_URL/auth/login" >&2
  printf '%s\n' "$LOGIN_JSON" >&2
  exit 1
fi

TMP_BODY="$(mktemp)"
trap 'rm -f "$TMP_BODY"' EXIT

created=0
skipped=0

for f in "${CASE_FILES[@]}"; do
  code="$(curl -sS -o "$TMP_BODY" -w "%{http_code}" \
    -X POST "$BASE_URL/cases" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d @"$f")"

  case "$code" in
    201)
      cid="$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['case_id'])" "$f" 2>/dev/null || basename "$f")"
      echo "OK  created $cid"
      created=$((created + 1))
      ;;
    409)
      cid="$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['case_id'])" "$f" 2>/dev/null || basename "$f")"
      echo "SKIP exists $cid"
      skipped=$((skipped + 1))
      ;;
    *)
      echo "ERR $(basename "$f") HTTP $code" >&2
      cat "$TMP_BODY" >&2
      exit 1
      ;;
  esac
done

echo "Done. Created $created, skipped $skipped."
