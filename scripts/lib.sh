#!/usr/bin/env bash
# Shared setup for the Kept scripts. Sourced, not executed.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Normal Flutter install (not FVM). Override with KEPT_FLUTTER_ROOT if needed.
KEPT_FLUTTER_ROOT="${KEPT_FLUTTER_ROOT:-${HOME}/development/flutter}"
if [[ -x "${KEPT_FLUTTER_ROOT}/bin/flutter" ]]; then
  export PATH="${KEPT_FLUTTER_ROOT}/bin:${PATH}"
fi

# Serverpod CLI from `dart install` (macOS default path).
if [[ -d "${HOME}/Library/Application Support/Dart/install/bin" ]]; then
  export PATH="${HOME}/Library/Application Support/Dart/install/bin:${PATH}"
fi
# Linux / other installs of `dart install`.
if [[ -d "${HOME}/.dart/install/bin" ]]; then
  export PATH="${HOME}/.dart/install/bin:${PATH}"
fi

require() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing '$1'. See the README prerequisites." >&2
    exit 1
  fi
}

# Serverpod 4.0.3 needs Flutter 3.44.4+ (Dart 3.12.2+).
require_flutter() {
  require flutter
  require dart
  local flutter_bin
  flutter_bin="$(command -v flutter)"
  if [[ "${flutter_bin}" == *"/fvm/"* ]]; then
    echo "Flutter on PATH comes from FVM (${flutter_bin})." >&2
    echo "Kept uses a standard Flutter SDK. Install stable Flutter 3.44.4+ and either:" >&2
    echo "  export PATH=\"\${HOME}/development/flutter/bin:\$PATH\"  (before FVM in your shell)" >&2
    echo "  or set KEPT_FLUTTER_ROOT to that SDK directory." >&2
    exit 1
  fi
  # Avoid `head` closing the pipe early — that can empty flutter --version.
  local flutter_ver dart_ver
  flutter_ver="$(flutter --version 2>/dev/null | sed -nE 's/^Flutter ([0-9]+\.[0-9]+\.[0-9]+).*/\1/p' | sed -n '1p')"
  dart_ver="$(dart --version 2>/dev/null | sed -nE 's/.*version: ([0-9]+\.[0-9]+\.[0-9]+).*/\1/p' | sed -n '1p')"
  if [[ -z "${dart_ver}" ]]; then
    dart_ver="$(flutter --version 2>/dev/null | sed -nE 's/^Tools • Dart ([0-9]+\.[0-9]+\.[0-9]+).*/\1/p' | sed -n '1p')"
  fi

  if [[ -z "${flutter_ver}" ]] || [[ -z "${dart_ver}" ]]; then
    echo "Could not read Flutter / Dart versions. Install Flutter 3.44.4+ from https://docs.flutter.dev/get-started/install" >&2
    exit 1
  fi

  if ! python3 - "${flutter_ver}" "${dart_ver}" <<'PY'
import sys

def parse(v):
    return tuple(int(p) for p in v.split("."))

flutter_ver, dart_ver = sys.argv[1], sys.argv[2]
ok = parse(flutter_ver) >= (3, 44, 4) and parse(dart_ver) >= (3, 12, 2)
if not ok:
    print(
        f"Kept needs Flutter 3.44.4+ and Dart 3.12.2+ (Serverpod 4.0.3).\n"
        f"Found Flutter {flutter_ver}, Dart {dart_ver}.\n"
        f"Upgrade Flutter: https://docs.flutter.dev/get-started/install",
        file=sys.stderr,
    )
sys.exit(0 if ok else 1)
PY
  then
    exit 1
  fi
}

wait_for_api() {
  local url="${1:-http://127.0.0.1:8080/}"
  echo "Waiting for the API at ${url}"
  local _i
  for _i in $(seq 1 90); do
    if curl -sf -o /dev/null "${url}"; then
      echo "API is up."
      return 0
    fi
    sleep 1
  done
  echo "The API did not answer on ${url}." >&2
  return 1
}

first_mobile_device() {
  flutter devices --machine 2>/dev/null | python3 -c '
import json, sys
try:
    devices = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for device in devices:
    platform = device.get("targetPlatform") or ""
    # Prefer a booted simulator / emulator.
    if device.get("emulator") and (
        platform.startswith("ios") or "android" in platform
    ):
        print(device.get("id", ""))
        break
'
}
