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
- Папка **`telegram-bot\`** — копия кода бота; отдельный git-репозиторий **lightrag-telegram-bot** (не submodule).

## Облако (типично Render)

- **LightRAG** (Docker) — бэкенд и Web UI.
- **lightrag-telegram-bot** (Python) — long polling + health на `PORT`.

Конфигурация моделей и ключей — через **Environment** в Render, не в git. Шаблон переменных для облака без Ollama: **`env.render.example`**.

## Доп. документы

- [docs/Render-fork.md](docs/Render-fork.md) — форк, Render, синхронизация с HKUDS.
