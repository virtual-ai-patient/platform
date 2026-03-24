#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SPEC_PATH="${SCRIPT_DIR}/openapi.json"
TMP_DIR="${SCRIPT_DIR}/.openapi-tmp"
TARGET_DIR="${SCRIPT_DIR}/../lib/network"

if ! command -v openapi-generator >/dev/null 2>&1; then
  echo "openapi-generator is not installed. Install with: brew install openapi-generator"
  exit 1
fi

rm -rf "${TMP_DIR}"
mkdir -p "${TARGET_DIR}"

# Generate client from OpenAPI
openapi-generator generate \
  -i "${SPEC_PATH}" \
  -g dart-dio \
  -o "${TMP_DIR}" \
  --additional-properties=\
pubVersion=1.0.0,\
serializationLibrary=built_value,\
sourceFolder=network/src,\
pubName=openapi

(
  cd "${TMP_DIR}"
  dart pub get
  dart run build_runner build --delete-conflicting-outputs
)

rm -rf "${TARGET_DIR}/src" "${TARGET_DIR}/openapi.dart"
cp "${TMP_DIR}/lib/openapi.dart" "${TARGET_DIR}/openapi.dart"
mkdir -p "${TARGET_DIR}/src"
cp -R "${TMP_DIR}/lib/network/src/." "${TARGET_DIR}/src/"

python3 - "${TARGET_DIR}" <<'PY'
import sys
from pathlib import Path

target = Path(sys.argv[1])
for file in target.rglob("*.dart"):
    text = file.read_text()
    text = text.replace(
        "package:openapi/network/src/",
        "package:frontend/network/src/",
    )
    file.write_text(text)
PY

rm -rf "${TMP_DIR}"

echo "Generated client synced to ${TARGET_DIR}"
