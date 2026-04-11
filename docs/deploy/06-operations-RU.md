# 6. Эксплуатация: чеклист и типовые ошибки

## Перед деплоем

- [ ] На LightRAG заданы LLM и embedding (без Ollama).
- [ ] `AUTH_ACCOUNTS` + `TOKEN_SECRET` + `LIGHTRAG_API_KEY` согласованы.
- [ ] На боте: `LIGHTRAG_URL`, тот же `LIGHTRAG_API_KEY`, `TELEGRAM_TOKEN`, `OPENAI_API_KEY`.
- [ ] Диск подключён и `WORKING_DIR` / `INPUT_DIR` указывают **на том же mount path**.

## После деплоя

- [ ] `GET https://<lightrag-host>/health` — успех.
- [ ] Web UI: вход по логину/паролю из `AUTH_ACCOUNTS` (не «Login Free»).
- [ ] Загрузка тестового документа — статус Completed.
- [ ] Telegram: сообщение боту; при whitelist — ваш id в `ALLOWED_TELEGRAM_USER_IDS`.
- [ ] Open WebUI (если используете): см. [08-open-webui-render-RU.md](08-open-webui-render-RU.md) — `OLLAMA_BASE_URL` = origin LightRAG, диск `/app/backend/data`, при `LIGHTRAG_API_KEY` — заголовок `X-API-Key` в подключении Ollama.

## Типовые ошибки

| Симптом | Что проверить |
|---------|----------------|
| `Authentication Fails ... 401` при индексации | Ключ DeepSeek, `LLM_BINDING_HOST` (`https://api.deepseek.com/v1`) |
| Бот: «Ошибка сохранения… LIGHTRAG_URL и X-API-Key» | Совпадение `LIGHTRAG_API_KEY`, корректный `LIGHTRAG_URL` без `/webui`, сервис LightRAG live |
| `TOKEN_SECRET must be explicitly set` | Задан непустой `TOKEN_SECRET`, не дефолтный из примеров |
| Данные пропали после redeploy | `WORKING_DIR`/`INPUT_DIR` на Persistent Disk, не `./rag_storage` в контейнере |
| «Login Free» не исчезает | `AUTH_ACCOUNTS` и `TOKEN_SECRET` на LightRAG |
| Open WebUI: модели Ollama пустые / 404 | `OLLAMA_BASE_URL` без суффикса `/api/ollama`; проверка: `GET …/api/tags` |
| Open WebUI: 403 к LightRAG | В подключении Ollama добавить header `X-API-Key` = `LIGHTRAG_API_KEY` |

## Логи

- Render → сервис → **Logs** для обоих сервисов при воспроизведении ошибки.
