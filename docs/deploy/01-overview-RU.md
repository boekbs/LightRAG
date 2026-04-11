# 1. Обзор: цель и архитектура

## Цель (cloud-only)

- **LightRAG** — сервер с Web UI и REST API на **Render** (Docker).
- **Telegram-бот** — отдельный сервис на **Render** (Python), репозиторий не внутри этого форка.
- Локальная установка в этом форке **не поддерживается** (удалены compose, k8s-setup и т.д.).

## Компоненты

| Компонент | Где | Роль |
|-----------|-----|------|
| LightRAG | Render, Docker | Индексация, граф знаний, запросы, Web UI |
| Open WebUI (опционально) | Render, Docker | Отдельный чат-UI; бэкенд Ollama → LightRAG `/api/chat` |
| Telegram-бот | Render, Python | Текст и голос → Whisper → API LightRAG |
| DeepSeek | Облако API | LLM для извлечения сущностей и ответов |
| OpenAI | Облако API | Эмбеддинги (индексация) и Whisper (голос в боте) |

## Поток данных

1. Пользователь пишет в Telegram (или загружает документ в Web UI).
2. Для голоса бот вызывает **OpenAI Whisper**, получает текст.
3. Текст уходит в LightRAG: `POST /documents/text` или `POST /query` с заголовком **`X-API-Key`**.
4. LightRAG использует **DeepSeek** (LLM) и **OpenAI** (embeddings) по переменным окружения.

## Дальше

- Переменные сервера: [02-lightrag-render-RU.md](02-lightrag-render-RU.md)
- Open WebUI + LightRAG (Ollama API): [08-open-webui-render-RU.md](08-open-webui-render-RU.md)
- Переменные бота: [03-telegram-bot-render-RU.md](03-telegram-bot-render-RU.md)
