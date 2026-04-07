# 4. Безопасность: Web UI, API, бот

## Web UI LightRAG (вход по паролю)

| Переменная | Назначение |
|------------|------------|
| `AUTH_ACCOUNTS` | `логин:пароль` (несколько через запятую; для продакшена можно bcrypt — см. `env.example` в апстриме) |
| `TOKEN_SECRET` | Случайная длинная строка для JWT; **нельзя** оставлять дефолт из примеров |
| `TOKEN_EXPIRE_HOURS` | Опционально, например `48` |

Если заданы `AUTH_ACCOUNTS`, **`TOKEN_SECRET` обязателен** — иначе сервер не стартует.

## Публичные пути без логина

| Переменная | Типичное значение |
|------------|-------------------|
| `WHITELIST_PATHS` | `/health` — только healthcheck для Render |

Узкий whitelist снижает риск открытого доступа к API без ключа.

## API LightRAG

| Переменная | Назначение |
|------------|------------|
| `LIGHTRAG_API_KEY` | Секрет; клиенты передают заголовок **`X-API-Key: <значение>`** |

Telegram-бот должен использовать **тот же** ключ в своём `LIGHTRAG_API_KEY`.

## Генерация секретов (локально, не коммитить вывод)

В форке есть скрипт:

```powershell
cd <путь-к-клону-LightRAG>
powershell -File scripts/generate-render-secrets.ps1
```

Подробнее: [Render-auth.md](../Render-auth.md).

## Ограничение доступа к боту

Переменная **`ALLOWED_TELEGRAM_USER_IDS`** в сервисе бота — whitelist числовых user id. Команда `/whoami` показывает ваш id.

## При утечке

Ротировать: `TOKEN_SECRET`, `LIGHTRAG_API_KEY`, токен Telegram у BotFather.
