# Проект: LightRAG + Telegram (boekbs)

Краткое описание того, из каких репозиториев собрана экосистема и как она связана.

## Репозитории

| Компонент | GitHub | Роль |
|-----------|--------|------|
| **Сервер RAG + Web UI** | [boekbs/LightRAG](https://github.com/boekbs/LightRAG) | Форк [HKUDS/LightRAG](https://github.com/HKUDS/LightRAG): индексация, граф знаний, REST API, веб-интерфейс |
| **Telegram-бот** | [boekbs/lightrag-telegram-bot](https://github.com/boekbs/lightrag-telegram-bot) | Текст и голос → OpenAI Whisper → API LightRAG |
| **Апстрим (ядро)** | [HKUDS/LightRAG](https://github.com/HKUDS/LightRAG) | Оригинальный проект; обновления: `git fetch upstream` → merge → `git push origin` |

## Локальная папка

- **`C:\My documents\LightRAG`** — клон форка **boekbs/LightRAG** (`origin`), с привязкой **`upstream`** → HKUDS.
- Код Telegram-бота ведётся в отдельном репозитории **lightrag-telegram-bot** (не в этом репо).

## Облако (типично Render)

- **LightRAG** (Docker) — бэкенд и Web UI.
- **lightrag-telegram-bot** (Python) — long polling + health на `PORT`.

Конфигурация моделей и ключей — через **Environment** в Render, не в git. Шаблон переменных для облака без Ollama: **`env.render.example`**.

## Доп. документы

- [docs/deploy/README.md](docs/deploy/README.md) — **развёртывание по шагам** (отдельные файлы для другого Cursor)
- [docs/Current-Implementation-RU.md](docs/Current-Implementation-RU.md) — оглавление на эти файлы
- [docs/Render-fork.md](docs/Render-fork.md) — форк, Render, синхронизация с HKUDS.
- [docs/Render-auth.md](docs/Render-auth.md) — отключить «Login Free», API-ключ для бота.
- [docs/Render-persistence.md](docs/Render-persistence.md) — диск Render, чтобы индекс не слетал после деплоя.
