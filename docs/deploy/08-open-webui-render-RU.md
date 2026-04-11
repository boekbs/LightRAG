# 8. Open WebUI на Render + LightRAG (Ollama-совместимый API)

Отдельный **Web Service** на Render с официальным образом Open WebUI. Чат идёт в LightRAG через Ollama-совместимые маршруты (`/api/tags`, `/api/chat`).

## Проверка вашего LightRAG (форк / прод)

Перед настройкой Open WebUI убедитесь, что список моделей отвечает (подставьте свой хост и ключ при необходимости):

```powershell
curl.exe -sS "https://YOUR-LIGHTRAG.onrender.com/api/tags"
```

Если задан `LIGHTRAG_API_KEY`:

```powershell
curl.exe -sS -H "X-API-Key: YOUR_KEY" "https://YOUR-LIGHTRAG.onrender.com/api/tags"
```

Ожидается JSON с полем `models` (например имя **`lightrag:latest`**, если не меняли `OLLAMA_EMULATING_MODEL_*`).

## Важно: `OLLAMA_BASE_URL`

Клиент Ollama обращается к **`{OLLAMA_BASE_URL}/api/tags`** и **`{OLLAMA_BASE_URL}/api/chat`**.

Задайте **только origin** (схема + хост), **без** пути `/api/ollama`:

| Правильно | Неправильно (частая ошибка) |
|-----------|----------------------------|
| `https://lightrag-38qw.onrender.com` | `https://lightrag-38qw.onrender.com/api/ollama` |

Второй вариант даёт запросы вида `.../api/ollama/api/tags`, что не соответствует монтированию роутера в этом форке ([`lightrag_server.py`](../../lightrag/api/lightrag_server.py): префикс `/api` для Ollama API).

Если ваш прод собран из **другой ветки форка** с иными путями — ориентируйтесь на живой `curl` и Swagger (`/docs`), а не только на этот документ.

## Деплой через Blueprint (рекомендуется)

1. В Render: **Blueprints** → подключить репозиторий форка.
2. Указать **Blueprint path**: `docs/deploy/render-open-webui.yaml`.
3. После создания сервиса в **Environment** задать **`OLLAMA_BASE_URL`** = `https://<ваш-lightrag>.onrender.com` (переменная помечена `sync: false` в шаблоне — Render запросит значение при применении).

Файл шаблона: [render-open-webui.yaml](render-open-webui.yaml).

## Деплой вручную (Dashboard)

1. **New** → **Web Service** → **Existing Image**.
2. Image URL: `ghcr.io/open-webui/open-webui:main`  
   Для продакшена лучше **закрепить тег релиза** (например `v0.x.x`), а не `main`.
3. **Instance type**: минимум **Standard (2 GB RAM)**. План **Starter (~512 MiB)** на полном образе `open-webui` часто падает с `Out of memory (used over 512Mi)` при первом старте (Alembic + приложение). **не включайте** горизонтальный скейлинг вместе с диском (у Render диск — один на инстанс).
4. **Disk**: добавить persistent disk, mount path **`/app/backend/data`**, размер по необходимости (например 10 GB).
5. **Health check path**: `/health`.
6. Переменные окружения — см. таблицу ниже.

## Переменные окружения Open WebUI

| Переменная | Пример / заметка |
|------------|------------------|
| `OLLAMA_BASE_URL` | `https://YOUR-LIGHTRAG.onrender.com` (только origin) |
| `WEBUI_SECRET_KEY` | Случайная строка (`openssl rand -base64 32` или **Generate** в Render) |
| `WEBUI_AUTH` | `False` — без логина (только на **чистом** томе `/app/backend/data`; иначе см. документацию Open WebUI) |
| `WEBUI_AUTH` | `True` — тогда создайте админа при первом входе и при необходимости отключите регистрацию (`ENABLE_SIGNUP=false`) |
| `UVICORN_WORKERS` | `1` на слабом плане (меньше RAM) |
| `SCARF_NO_ANALYTICS` | `true` |
| `DO_NOT_TRACK` | `true` |
| `ANONYMIZED_TELEMETRY` | `false` |

Опционально: `WEBUI_URL` — публичный URL вашего Open WebUI на Render (редиректы и ссылки).

## `LIGHTRAG_API_KEY` и Open WebUI

Если на LightRAG задан **`LIGHTRAG_API_KEY`**, запросы к `/api/tags` и `/api/chat` без заголовка **`X-API-Key`** получат **403**.

**Рекомендуется:** в Open WebUI после деплоя откройте настройки подключения к Ollama (**Admin** → **Settings** → **Connections** / **Admin Settings** — названия меняются между версиями) и добавьте **custom HTTP header**:

- Имя: `X-API-Key`
- Значение: тот же секрет, что и `LIGHTRAG_API_KEY` на сервисе LightRAG.

Не открывайте весь префикс `/api` через `WHITELIST_PATHS` на LightRAG ради Open WebUI — это ослабит защиту остального API.

## Проверка после деплоя Open WebUI

1. **Список моделей:** в интерфейсе Open WebUI обновите подключение Ollama / список моделей — должна появиться **`lightrag:latest`** (или имя из `OLLAMA_EMULATING_MODEL_NAME:TAG` на LightRAG).
2. **Чат:** выберите эту модель, задайте вопрос по вашей проиндексированной базе. Ответ идёт через [`OllamaAPI.chat`](../../lightrag/api/routers/ollama_api.py) в LightRAG.
3. **Не путать с RAG Open WebUI:** встроенные документы/эмбеддинги внутри Open WebUI — отдельная подсистема; для **вашей** базы знаний используется только чат с моделью LightRAG.

## Типовые проблемы при деплое

### `Out of memory (used over 512Mi)`

Полный образ Open WebUI на старте грузит Python, миграции SQLite, uvicorn — **512 MiB (Starter) обычно не хватает**.

**Что сделать:** в Render откройте сервис Open WebUI → **Settings** → **Instance type** → выберите **Standard (2 GB)** или выше → сохраните и дождитесь redeploy.

Если Blueprint снова выставит Starter при синхронизации, в репозитории в [render-open-webui.yaml](render-open-webui.yaml) указан `plan: standard`.

### `No open ports detected`

Часто **следствие долгого старта или OOM**: процесс не успевает слушать `PORT`, пока Render сканирует порт. После увеличения RAM сообщение обычно пропадает. Убедитесь, что приложение использует переменную **`PORT`**, которую задаёт Render (образ Open WebUI это делает).

### `CORS_ALLOW_ORIGIN IS SET TO '*'`

Предупреждение Open WebUI о продакшене. Для закрытия UI по домену позже задайте узкий `CORS_ALLOW_ORIGIN` по [документации Open WebUI](https://docs.openwebui.com/).

## Дальше

- Безопасность LightRAG: [04-security-RU.md](04-security-RU.md)
- Диск LightRAG: [05-persistence-RU.md](05-persistence-RU.md)
