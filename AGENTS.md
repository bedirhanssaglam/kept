# Kept — Flutter & Serverpod

Accountability product for the Serverpod **Build Something Real** hackathon.

## Product

**Kept**: public vow rooms + daily keep/break check-ins + live member board.
Not a chat/social feed. Not an AI coach.

Core paths:
- Server: `kept_server/lib/src/vows/`
- Flutter: `kept_flutter/lib/features/` + `lib/data/vow_repository.dart`

The user starts the server and Flutter app with `serverpod start`. NEVER start the server yourself. Use Serverpod MCP tools when the project is open and `serverpod start` is running.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload.

ALWAYS use the MCP server instead of the command line when available:
- `create_migration` / `apply_migrations`
- `tail_server_logs` / `tail_flutter_logs`
- `hot_reload` / `hot_restart`
- `spawn_flutter_app`

NEVER edit generated code (`kept_server/lib/src/generated/`, `kept_client`).

Checklist after changes:
- `dart analyze`
- `dart format`
- migrations via MCP if models changed
- `hot_restart` if needed
- check logs
