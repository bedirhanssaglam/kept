#!/usr/bin/env bash
# Flutter on a phone or simulator.
#
# Simulator (talks to localhost):
#   ./scripts/mobile.sh
#   ./scripts/mobile.sh <device-id>
#
# A real phone must reach this computer, not localhost:
#   SERVER_URL=http://<lan-ip>:8080/ ./scripts/mobile.sh <device-id>
#
# The live Cloud API:
#   SERVER_URL=https://kept-vows.api.serverpod.space/ ./scripts/mobile.sh <device-id>
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"
require_flutter

DEVICE="${1:-}"
if [[ -z "${DEVICE}" ]]; then
  DEVICE="$(first_mobile_device || true)"
fi

if [[ -z "${DEVICE}" ]]; then
  echo "No simulator or emulator was selected."
  echo
  flutter devices
  echo
  echo "Pass a device id: ./scripts/mobile.sh <device-id>"
  echo "On a real phone, also set SERVER_URL to this computer's LAN address."
  exit 1
fi

SERVER_URL="${SERVER_URL:-http://127.0.0.1:8080/}"
echo "Running on ${DEVICE}"
echo "API ${SERVER_URL}"

cd "${ROOT}/kept_flutter"
exec flutter run \
  -d "${DEVICE}" \
  -t lib/main.dart \
  --dart-define="SERVER_URL=${SERVER_URL}"
