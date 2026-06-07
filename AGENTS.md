# Agents

This repository ships specialized Claude Code subagents in `.claude/agents/`.
Each is a Markdown file with YAML frontmatter (`name`, `description`, `tools`,
`model`) followed by its operating instructions. Adapted from
[ECC](https://github.com/affaan-m/ECC) and trimmed to this repo's pipeline.

## Pipeline core

| Agent | Model | Purpose |
|-------|-------|---------|
| [`planner`](.claude/agents/planner.md) | opus | Break complex features/refactors into actionable, phased plans |
| [`tdd-guide`](.claude/agents/tdd-guide.md) | sonnet | Enforce write-tests-first (RED→GREEN→REFACTOR), 80%+ coverage |
| [`code-reviewer`](.claude/agents/code-reviewer.md) | sonnet | General quality/security review with confidence-based filtering |
| [`typescript-reviewer`](.claude/agents/typescript-reviewer.md) | sonnet | TS/JS type-safety, async correctness, idiomatic patterns |
| [`security-reviewer`](.claude/agents/security-reviewer.md) | sonnet | OWASP Top 10, secrets, injection, unsafe crypto |
| [`build-error-resolver`](.claude/agents/build-error-resolver.md) | sonnet | Minimal build/type-error fixes, no refactoring |

## General development

| Agent | Model | Purpose |
|-------|-------|---------|
| [`architect`](.claude/agents/architect.md) | opus | System design, scalability, technical decision-making |
| [`code-explorer`](.claude/agents/code-explorer.md) | sonnet | Trace execution paths and map architecture of existing code |
| [`refactor-cleaner`](.claude/agents/refactor-cleaner.md) | sonnet | Find and safely remove dead code/duplication (knip, depcheck, ts-prune) |
| [`code-simplifier`](.claude/agents/code-simplifier.md) | sonnet | Simplify code for clarity while preserving behavior |
| [`silent-failure-hunter`](.claude/agents/silent-failure-hunter.md) | sonnet | Find swallowed errors, bad fallbacks, missing error propagation |
| [`type-design-analyzer`](.claude/agents/type-design-analyzer.md) | sonnet | Review type design for encapsulation and invariants |
| [`comment-analyzer`](.claude/agents/comment-analyzer.md) | sonnet | Review comments for accuracy and comment-rot risk |
| [`pr-test-analyzer`](.claude/agents/pr-test-analyzer.md) | sonnet | Assess PR test coverage quality and behavioral completeness |
| [`performance-optimizer`](.claude/agents/performance-optimizer.md) | sonnet | Find bottlenecks, optimize runtime/bundle/memory |
| [`database-reviewer`](.claude/agents/database-reviewer.md) | sonnet | SQL/schema/migration review and query optimization |
| [`doc-updater`](.claude/agents/doc-updater.md) | haiku | Keep docs and architectural codemaps current with the code |
| [`python-reviewer`](.claude/agents/python-reviewer.md) | sonnet | PEP 8, Pythonic idioms, type hints, security, performance |

## How the pipeline uses them

| Workflow stage | Prompt | Delegates to |
|----------------|--------|--------------|
| implement | `.github/prompts/implement.md` | `planner`, `tdd-guide` |
| review | `.github/prompts/review.md` | `code-reviewer`, `typescript-reviewer`, `security-reviewer` |
| fix-ci | `.github/prompts/fix-ci.md` | `build-error-resolver` |

See `.claude/rules/agents.md` for when to invoke each agent and how to run them
in parallel.
