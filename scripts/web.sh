#!/usr/bin/env bash
# Flutter web against the local API (http://127.0.0.1:8080/).
# Start scripts/backend.sh first, unless you run scripts/all.sh.
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"
require_flutter

cd "${ROOT}/kept_flutter"
exec flutter run \
  -d web-server \
  --web-hostname 127.0.0.1 \
  --web-port 7357 \
  -t lib/main.dart \
  "$@"
