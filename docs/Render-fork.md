# Render: свой форк LightRAG

Форк: **https://github.com/boekbs/LightRAG** (аккаунт `boekbs`).

## Локальный репозиторий

- `origin` → твой форк (`boekbs/LightRAG`), ветка `main` с ним связана.
- `upstream` → оригинал [HKUDS/LightRAG](https://github.com/HKUDS/LightRAG).

Подтянуть обновления с апстрима:

```powershell
cd "C:\My documents\LightRAG"
git fetch upstream
git merge upstream/main
git push origin main
```

## Render Dashboard

1. Сервис **LightRAG** → **Settings** → **Build & Deploy**.
2. **Repository** → **Edit** → выбрать **`boekbs/LightRAG`** (подключить GitHub при запросе).
3. Branch: **`main`**, сохранить. При необходимости **Manual Deploy**.

Дальше любые `git push` в `main` форка запускают деплой (если включён auto-deploy).
