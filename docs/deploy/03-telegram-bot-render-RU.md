# 3. Сервис Telegram-бота на Render

Отдельный репозиторий: **boekbs/lightrag-telegram-bot**. Отдельный **Web Service** на Render.

## Переменные окружения

| Переменная | Назначение |
|------------|------------|
| `TELEGRAM_TOKEN` | Токен от [@BotFather](https://t.me/BotFather) |
| `OPENAI_API_KEY` | Ключ OpenAI для **Whisper** (транскрипция голоса); формат `sk-...` |
| `LIGHTRAG_URL` | Базовый URL сервера LightRAG **без** `/webui`, например `https://your-lightrag.onrender.com` |
| `LIGHTRAG_API_KEY` | **Тот же** секрет, что `LIGHTRAG_API_KEY` на сервисе LightRAG (заголовок `X-API-Key`) |
| `ALLOWED_TELEGRAM_USER_IDS` | Числовые user id через запятую; если задано — бот отвечает только им |

## Узнать свой Telegram user id

После деплоя напишите боту команду **`/whoami`** — бот ответит числом; его добавьте в `ALLOWED_TELEGRAM_USER_IDS`.

## Согласованность с LightRAG

- URL должен быть доступен из интернета (HTTPS).
- Если на LightRAG включён `LIGHTRAG_API_KEY`, в боте **обязательно** тот же ключ, иначе сохранение и запросы вернут ошибку.

## Дальше

- Безопасность: [04-security-RU.md](04-security-RU.md)
- Проверки после деплоя: [06-operations-RU.md](06-operations-RU.md)
