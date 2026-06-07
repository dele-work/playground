# AI Agent Pipeline Playground

## Commands
- `npm run lint` — Lint
- `npm run test` — Test
- `npm run build` — Build

## Architecture
- `src/` — Source code
- `docs/` — Design documents (agents reference these)
- `.github/workflows/` — CI/CD & agent workflows
- `.github/prompts/` — Agent system prompts
- `.claude/settings.json` — Agent permission config
- `.claude/rules/` — Path-scoped rules

## Coding Standards
- TypeScript strict mode
- Single responsibility per function
- Tests required for all changes
- Commit format: `type: description`

## Agent Rules
- Always link PR to Issue (`closes #N`)
- Check existing utilities before creating new ones
- Keep changes minimal and focused
- Run lint and tests before committing
- Never include secrets, API keys, or credentials in output

## CI-Specific Instructions
When running in CI (GitHub Actions):
- Do NOT report: minor style issues, TODO comments, missing docs (linters handle these)
- DO report: security vulnerabilities, logic errors, data leaks, breaking changes
- Focus on what matters: business logic correctness, API contract compliance
