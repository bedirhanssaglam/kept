#!/usr/bin/env bash
# Local API, database, and web server. Does not launch Flutter.
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"
require dart
require serverpod

cd "${ROOT}/kept_server"
exec serverpod start --no-flutter "$@"
