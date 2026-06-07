# Rules

Always-follow guidelines for this repository. Claude Code loads these
automatically; the autonomous pipeline references them through `CLAUDE.md` and
the agent prompts. Adapted and trimmed from [ECC](https://github.com/affaan-m/ECC)
to fit this repo (an AI-agent GitHub Actions pipeline).

## Index

| Rule | Scope | Summary |
|------|-------|---------|
| [security.md](./security.md) | all | Secrets, input validation, untrusted-input defense, response protocol |
| [code-review.md](./code-review.md) | all | When/how to review, severity model, checklist |
| [coding-style.md](./coding-style.md) | all | KISS/DRY/YAGNI, immutability, file size, naming |
| [testing.md](./testing.md) | all | 80% coverage, TDD loop, AAA structure |
| [development-workflow.md](./development-workflow.md) | all | Research → plan → TDD → review → commit |
| [git-workflow.md](./git-workflow.md) | all | Conventional commit format, PR workflow |
| [performance.md](./performance.md) | all | Model selection, context-window management |
| [patterns.md](./patterns.md) | all | Repository pattern, API response envelope |
| [agents.md](./agents.md) | all | The subagents in `.claude/agents/` and when to use them |
| [typescript.md](./typescript.md) | `*.ts,*.tsx,*.js,*.jsx` | Type safety, async correctness, validation |

Path-scoped rules declare their scope via a `paths:` YAML frontmatter block.
