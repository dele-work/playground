# Contributing

This repository is an AI-agent pipeline playground. Contributions follow the
formats below so both humans and the autonomous pipeline can work with them.

## Before committing

- `npm install` then `npm run lint` (Markdown lint must pass — it is the CI gate).
- Keep changes minimal and focused; check existing utilities/rules before adding new ones.
- Never include secrets, API keys, or credentials.

## Commit messages

Conventional commits, as documented in `CLAUDE.md` and enforced by
`commitlint.config.js`:

```
<type>: <description>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`,
`ci`, `build`, `revert`. Header ≤ 100 chars; subject not in Title/Sentence/UPPER case.

## Pull requests

- Link the PR to its Issue (`closes #N`).
- Ensure CI is green before requesting review.
- The pipeline may review, fix CI, and (with the right label) merge automatically;
  write changes so each is independently reviewable.

## File formats

| Component | Location | Format |
|-----------|----------|--------|
| Agents | `.claude/agents/*.md` | Markdown + frontmatter (`name`, `description`, `tools`, `model`); filename matches `name` |
| Commands | `.claude/commands/*.md` | Markdown + frontmatter (`description`, optional `argument-hint`) |
| Rules | `.claude/rules/*.md` | Markdown; path-scoped rules add a `paths:` frontmatter block |
| Prompts | `.github/prompts/*.md` | Markdown system prompts for pipeline stages |
| Workflows | `.github/workflows/*.yml` | Pin action majors; set least-privilege `permissions` |

File naming: lowercase with hyphens (e.g. `typescript-reviewer.md`).

## Conventions

Follow the always-on rules in `.claude/rules/` — especially `security.md`,
`coding-style.md`, `testing.md`, and `code-review.md`.
