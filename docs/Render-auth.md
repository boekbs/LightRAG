# Отключить «Login Free» в Web UI на Render

1. Сгенерируй секреты (локально, не коммить вывод):

   ```powershell
   cd "C:\My documents\LightRAG"
   powershell -File scripts/generate-render-secrets.ps1
   ```

2. **Render → сервис LightRAG → Environment** — добавь или обнови:

   | Variable | Описание |
   |----------|----------|
   | `AUTH_ACCOUNTS` | `admin:твой_надёжный_пароль` (или несколько через запятую; см. `env.example` для bcrypt) |
   | `TOKEN_SECRET` | из скрипта |
   | `LIGHTRAG_API_KEY` | из скрипта (случайная строка) |
   | `WHITELIST_PATHS` | ` /health` (только health без авторизации) |
   | `TOKEN_EXPIRE_HOURS` | опционально, например `48` |

3. **Render → lightrag-telegram-bot → Environment** — задай **`LIGHTRAG_API_KEY`** тем же значением, что в шаге 2.

4. **Save** → **Manual Deploy** обоих сервисов (или хотя бы LightRAG).

После деплоя в браузере откроется форма логина; «Login Free» исчезнет. API для бота остаётся через заголовок `X-API-Key`.

Подробнее переменные: [env.render.example](../env.render.example).
