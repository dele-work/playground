# Agent Orchestration

This repository ships specialized subagents in `.claude/agents/`. Delegate to
them instead of doing everything inline — especially in the autonomous GitHub
Actions pipeline, where each stage maps to an agent.

## Available Agents

| Agent | Purpose | Use when | Pipeline stage |
|-------|---------|----------|----------------|
| `planner` | Implementation planning | Complex features, refactors | implement |
| `tdd-guide` | Test-driven development | New features, bug fixes | implement |
| `code-reviewer` | General code quality & security | After writing/modifying code | review |
| `typescript-reviewer` | TS/JS type-safety & idiom review | `.ts`/`.tsx`/`.js`/`.jsx` changes | review |
| `security-reviewer` | OWASP Top 10, secrets, injection | Auth/input/DB/API/secret changes | review |
| `build-error-resolver` | Minimal build/type-error fixes | CI build/type failures | fix-ci |

## Immediate (Proactive) Usage

No user prompt needed:

1. Complex feature request → `planner`
2. Code just written/modified → `code-reviewer` (+ `typescript-reviewer` for TS/JS)
3. Bug fix or new feature → `tdd-guide`
4. Security-sensitive change → `security-reviewer`
5. Build/type errors → `build-error-resolver`

## Parallel Execution

Run independent reviews in parallel rather than sequentially — e.g. launch
`code-reviewer`, `typescript-reviewer`, and `security-reviewer` concurrently on
the same diff, then consolidate findings by severity.

## Passing Context

When spawning a subagent, pass the relevant rules from `.claude/rules/` into the
agent's prompt so it reviews against this repository's conventions.
