# Project

## Commands
- `npm run lint` — Lint
- `npm run test` — Test
- `npm run build` — Build

## Architecture
- `src/` — Source code
- `docs/` — Design documents (agents reference these)
- `.github/workflows/` — CI/CD & agent workflows
- `.github/prompts/` — Agent system prompts

## Coding Standards
- TypeScript strict mode
- Single responsibility per function
- Tests required for all changes
- Commit format: `type: description`

## Agent Rules
- Always link PR to Issue (`closes #N`)
- Check existing utilities before creating new ones
- Keep changes minimal and focused
- Run lint and tests before creating PR
