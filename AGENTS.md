# Agents

This repository ships specialized Claude Code subagents in `.claude/agents/`.
Each is a Markdown file with YAML frontmatter (`name`, `description`, `tools`,
`model`) followed by its operating instructions. Adapted from
[ECC](https://github.com/affaan-m/ECC) and trimmed to this repo's pipeline.

| Agent | Model | Purpose |
|-------|-------|---------|
| [`planner`](.claude/agents/planner.md) | opus | Break complex features/refactors into actionable, phased plans |
| [`tdd-guide`](.claude/agents/tdd-guide.md) | sonnet | Enforce write-tests-first (RED→GREEN→REFACTOR), 80%+ coverage |
| [`code-reviewer`](.claude/agents/code-reviewer.md) | sonnet | General quality/security review with confidence-based filtering |
| [`typescript-reviewer`](.claude/agents/typescript-reviewer.md) | sonnet | TS/JS type-safety, async correctness, idiomatic patterns |
| [`security-reviewer`](.claude/agents/security-reviewer.md) | sonnet | OWASP Top 10, secrets, injection, unsafe crypto |
| [`build-error-resolver`](.claude/agents/build-error-resolver.md) | sonnet | Minimal build/type-error fixes, no refactoring |

## How the pipeline uses them

| Workflow stage | Prompt | Delegates to |
|----------------|--------|--------------|
| implement | `.github/prompts/implement.md` | `planner`, `tdd-guide` |
| review | `.github/prompts/review.md` | `code-reviewer`, `typescript-reviewer`, `security-reviewer` |
| fix-ci | `.github/prompts/fix-ci.md` | `build-error-resolver` |

See `.claude/rules/agents.md` for when to invoke each agent and how to run them
in parallel.
