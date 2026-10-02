#!/usr/bin/env bash
# Local stack: API, web, and a booted simulator when one exists.
# Ctrl-C stops every process this script started.
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"
require_flutter
require serverpod

PIDS=()
cleanup() {
  local pid
  for pid in "${PIDS[@]:-}"; do
    kill "${pid}" 2>/dev/null || true
  done
}
trap cleanup EXIT INT TERM

LOG_DIR="$(mktemp -d "${TMPDIR:-/tmp}/kept.XXXXXX")"

echo "Starting the API. Log: ${LOG_DIR}/api.log"
(
  cd "${ROOT}/kept_server"
  serverpod start --no-flutter --no-tui
) >"${LOG_DIR}/api.log" 2>&1 &
PIDS+=("$!")

wait_for_api "http://127.0.0.1:8080/"

DEVICE="$(first_mobile_device || true)"
if [[ -n "${DEVICE}" ]]; then
  echo "Starting mobile on ${DEVICE}. Log: ${LOG_DIR}/mobile.log"
  (
    cd "${ROOT}/kept_flutter"
    flutter run -d "${DEVICE}" -t lib/main.dart \
      --dart-define=SERVER_URL=http://127.0.0.1:8080/
  ) >"${LOG_DIR}/mobile.log" 2>&1 &
  PIDS+=("$!")
else
  echo "No booted simulator. Start one, then run ./scripts/mobile.sh"
fi

echo
echo "API   http://127.0.0.1:8080/"
echo "Web   http://127.0.0.1:7357"
echo "Press Ctrl-C to stop."
echo

cd "${ROOT}/kept_flutter"
flutter run \
  -d web-server \
  --web-hostname 127.0.0.1 \
  --web-port 7357 \
  -t lib/main.dart
