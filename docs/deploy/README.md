# Развёртывание LightRAG + Telegram (Render) — набор документов

Эту папку можно **скопировать целиком** в другой проект Cursor (или в Wiki) — файлы самодостаточны и ссылаются друг на друга относительными путями.

## Оглавление

| № | Документ | Содержание |
|---|----------|------------|
| 1 | [01-overview-RU.md](01-overview-RU.md) | Цель cloud-only, архитектура, поток данных |
| 2 | [02-lightrag-render-RU.md](02-lightrag-render-RU.md) | Сервис LightRAG на Render: переменные окружения |
| 3 | [03-telegram-bot-render-RU.md](03-telegram-bot-render-RU.md) | Сервис Telegram-бота: переменные окружения |
| 4 | [04-security-RU.md](04-security-RU.md) | Web UI, API-ключ, ограничение доступа к боту |
| 5 | [05-persistence-RU.md](05-persistence-RU.md) | Persistent Disk, `WORKING_DIR`, `INPUT_DIR` |
| 6 | [06-operations-RU.md](06-operations-RU.md) | Чеклист деплоя, проверки, типовые ошибки |
| 7 | [07-repositories-RU.md](07-repositories-RU.md) | Репозитории, форк, синхронизация с апстримом |

## Шаблон переменных в репозитории

Корень форка: [env.render.example](../../env.render.example)

## Связанные документы (уже в `docs/`)

- [Render-fork.md](../Render-fork.md) — подключение репозитория к Render
- [Render-auth.md](../Render-auth.md) — скрипт секретов, отключение Login Free
- [Render-persistence.md](../Render-persistence.md) — диск подробнее
