# Kept

Public vows. Shared accountability.

Join a promise like “drink 1L of water” or “no cigarettes today”. Check in every day. The room shows who **kept** it and who **broke** it — live.

Built for the Serverpod **Build Something Real** hackathon.

## Product rules (MVP)

- Discover public vow rooms
- Create a vow (title + daily rule + category)
- Join + daily check-in: kept / broke
- Live board via Serverpod streams
- No chat feed, no AI coach, no streaks spam

## Stack

| Package | Role |
|---|---|
| `kept_server` | Serverpod 4 backend |
| `kept_client` | Generated client |
| `kept_flutter` | Flutter app (mobile + web) |

## Architecture

Server models are grouped under `lib/src/models/` (`vows/room`, `vows/chat`, `vows/feed`, `vows/check_in`, `vows/profile`, `auth`). Endpoints live in `lib/src/endpoints/`.

Flutter follows a feature `view` layout plus shared `product` code. Copy is `easy_localization` JSON (`assets/translations`, English fallback, Turkish when the device language is Turkish). Screens that talk to the server read `vowRepositoryProvider` (Riverpod).

```
kept_flutter/lib/
  product/            theme, components, language, service, providers
  features/<name>/view
```

## Run

Requires Flutter **3.44.4+** (pinned **3.47.4** via FVM).

```bash
export PATH="$HOME/fvm/versions/3.47.4/bin:$HOME/.pub-cache/bin:$PATH"
cd ~/kept
serverpod start
```

Open the project folder in Cursor for Serverpod MCP + hot reload.

Email auth codes appear in the Serverpod CLI during development.

## Demo script

1. Open Discover — seeded vows appear  
2. Sign in → join “Drink 1 liter of water”  
3. Tap **I kept it**  
4. Second browser/device: same room updates live  
5. Other user taps **I broke it** — board stats move
