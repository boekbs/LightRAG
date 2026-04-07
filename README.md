# LightRAG (Cloud-only Fork)

This fork is trimmed for cloud deployment on Render.
Local setup artifacts and local-install docs were removed intentionally.

## Repositories

- Server fork: `boekbs/LightRAG` (this repo)
- Upstream source: `HKUDS/LightRAG`
- Telegram bot (separate repo): `boekbs/lightrag-telegram-bot`

## Cloud deployment docs

- [PROJECT.md](PROJECT.md)
- [env.render.example](env.render.example)
- [docs/Render-fork.md](docs/Render-fork.md)
- [docs/Render-auth.md](docs/Render-auth.md)
- [docs/Render-persistence.md](docs/Render-persistence.md)

## Minimal Render checklist

1. Deploy LightRAG service from this repo.
2. Set LLM and embedding env vars (DeepSeek + OpenAI embeddings in `env.render.example`).
3. Enable auth:
   - `AUTH_ACCOUNTS`
   - `TOKEN_SECRET`
   - `LIGHTRAG_API_KEY`
4. Attach Persistent Disk and set:
   - `WORKING_DIR=/var/data/rag_storage`
   - `INPUT_DIR=/var/data/inputs`
5. Deploy telegram bot from `boekbs/lightrag-telegram-bot` with:
   - `TELEGRAM_TOKEN`
   - `OPENAI_API_KEY`
   - `LIGHTRAG_URL`
   - `LIGHTRAG_API_KEY` (same as server)
   - `ALLOWED_TELEGRAM_USER_IDS`

## Notes

- This fork is not intended for local installation.
- If you need upstream local setup materials, use `HKUDS/LightRAG` directly.
