# 2. Сервис LightRAG на Render

Сервис типа **Web Service**, образ из репозитория **boekbs/LightRAG** (ветка `main`).

## Базовые переменные

| Переменная | Пример / значение |
|------------|-------------------|
| `HOST` | `0.0.0.0` |
| `PORT` | `9621` (Render подставляет свой `PORT` — проверьте в настройках сервиса) |

## LLM (DeepSeek, OpenAI-совместимый)

| Переменная | Значение |
|------------|----------|
| `LLM_BINDING` | `openai` |
| `LLM_BINDING_HOST` | `https://api.deepseek.com/v1` |
| `LLM_BINDING_API_KEY` | ключ с [platform.deepseek.com](https://platform.deepseek.com) |
| `LLM_MODEL` | `deepseek-chat` |

## Эмбеддинги (OpenAI)

Отдельно от Whisper; нужен ключ **`sk-...`** с [platform.openai.com](https://platform.openai.com).

| Переменная | Значение |
|------------|----------|
| `EMBEDDING_BINDING` | `openai` |
| `EMBEDDING_BINDING_HOST` | `https://api.openai.com/v1` |
| `EMBEDDING_BINDING_API_KEY` | `sk-...` |
| `EMBEDDING_MODEL` | `text-embedding-3-small` |
| `EMBEDDING_DIM` | `1536` |
| `EMBEDDING_TOKEN_LIMIT` | `8192` |
| `EMBEDDING_SEND_DIM` | `false` |

## Важно

- Не задавать **Ollama** и адреса `localhost:11434` — в облаке Ollama нет.
- Полный шаблон: [env.render.example](../../env.render.example)

## Дальше

- Безопасность Web UI и API: [04-security-RU.md](04-security-RU.md)
- Диск и пути данных: [05-persistence-RU.md](05-persistence-RU.md)
