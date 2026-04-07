# 7. Репозитории и синхронизация с апстримом

## Состав

| Репозиторий | Назначение |
|-------------|------------|
| [boekbs/LightRAG](https://github.com/boekbs/LightRAG) | Форк сервера: cloud-only, документация Render |
| [boekbs/lightrag-telegram-bot](https://github.com/boekbs/lightrag-telegram-bot) | Telegram-бот |
| [HKUDS/LightRAG](https://github.com/HKUDS/LightRAG) | Апстрим (исходное ядро) |

## Клон и remotes (локальная разработка)

Обычно:

- `origin` → `boekbs/LightRAG`
- `upstream` → `HKUDS/LightRAG`

Подтянуть изменения апстрима:

```powershell
git fetch upstream
git merge upstream/main
git push origin main
```

После агрессивной очистки форка **merge может конфликтовать** — разрешайте вручную или cherry-pick нужные коммиты.

## Подключение к Render

См. [Render-fork.md](../Render-fork.md): Settings → Build & Deploy → репозиторий **boekbs/LightRAG**, ветка **main**.
