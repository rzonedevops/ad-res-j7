# AGENTS.md

## Cursor Cloud specific instructions

### Overview

This is a legal evidence repository and inference system (Case 2025-137857). It combines a Node.js application with PostgreSQL database, Python-based legal attention engine, and extensive evidence/documentation. See `CLAUDE.md` for comprehensive case and architecture details.

### Services

| Service | Purpose | How to run |
|---------|---------|------------|
| PostgreSQL | Primary database for all schemas | `sudo pg_ctlcluster 16 main start` |
| Node.js app | DB operations, tests, evidence validation, docx generation | Various `npm run` scripts (see `package.json`) |
| Python (lex engine) | Legal attention inference, validation scripts | `npm run lex:demo:python`, `npm run lex:demo:attention` |

### Key commands

- **Lint**: `npm run lint` (runs workflow validation tests)
- **Tests**: `npm test` (runs 784 tests across 12 suites, expect ~94% pass rate)
- **Evidence validation**: `npm run validate-evidence-completeness`
- **Docx generation**: `npm run docx:demo:affidavit` (or other templates via `npm run docx:list`)
- **DB migrations**: `npm run db:migrate` then `db:hierarchy:setup`, `db:hypergraph:setup`, `db:xref:setup`, `db:lex:setup` (run sequentially)
- **Full script list**: 115 scripts in `package.json`

### Known issues

- `db/test-connection.js` has a syntax error (missing `try {` block) — use `node -e` with `pg` module to verify DB connectivity instead.
- `npm run db:grip:setup` fails because `grip-metrics-migrate.js` references `config.databaseUrl` which is not exported from `db/config.js` (exports `db` and `pool` only). This is a pre-existing bug; 5/6 other migrations work fine.
- Test failures (47/784) are pre-existing and relate to workflow documentation ratios, security validation patterns, and some file path checks — not environment issues.

### Environment notes

- PostgreSQL must be running before any `db:*` commands. Start with `sudo pg_ctlcluster 16 main start`.
- The `.env` file must contain `DATABASE_URL=postgres://postgres:postgres@localhost:5432/ad_res_j7`.
- Python packages install to `~/.local/bin` — ensure `PATH` includes this directory.
- Node.js v20+ required (v22 works fine).
