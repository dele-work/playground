# Skills

Reusable, domain-knowledge skills for general development. Claude Code surfaces
these by name/description; invoke them when working on related tasks. Curated and
adapted from [ECC](https://github.com/affaan-m/ECC) — only broadly-useful,
language-agnostic (plus core TS/JS/web) skills were imported; ECC's niche/vertical
skills (healthcare, defi, logistics, crypto, etc.) were intentionally left out.

Each skill is a `<name>/SKILL.md` with frontmatter (`name`, `description`, `origin`).

## Language-agnostic

| Skill | Use when |
|-------|----------|
| [`coding-standards`](./coding-standards/SKILL.md) | Baseline naming/readability/immutability conventions |
| [`error-handling`](./error-handling/SKILL.md) | Typed errors, retries, circuit breakers, user-facing messages |
| [`api-design`](./api-design/SKILL.md) | REST resource naming, status codes, pagination, versioning |
| [`tdd-workflow`](./tdd-workflow/SKILL.md) | Writing features/bugfixes test-first toward 80%+ coverage |
| [`e2e-testing`](./e2e-testing/SKILL.md) | Playwright E2E, Page Object Model, CI integration, flaky tests |
| [`security-review`](./security-review/SKILL.md) | Auth, input handling, secrets, endpoints, sensitive features |
| [`architecture-decision-records`](./architecture-decision-records/SKILL.md) | Recording architectural decisions as ADRs |
| [`database-migrations`](./database-migrations/SKILL.md) | Schema/data migrations, rollbacks, zero-downtime |
| [`docker-patterns`](./docker-patterns/SKILL.md) | Dockerfiles, Compose, container security, networking |
| [`deployment-patterns`](./deployment-patterns/SKILL.md) | CI/CD, health checks, rollback, production readiness |
| [`codebase-onboarding`](./codebase-onboarding/SKILL.md) | Mapping an unfamiliar codebase + starter CLAUDE.md |
| [`github-ops`](./github-ops/SKILL.md) | Issue/PR/CI/release ops via the `gh` CLI |
| [`verification-loop`](./verification-loop/SKILL.md) | Verifying work before declaring it complete |
| [`mcp-server-patterns`](./mcp-server-patterns/SKILL.md) | Building MCP servers (tools/resources/prompts, Zod) |
| [`documentation-lookup`](./documentation-lookup/SKILL.md) | Finding authoritative library/API docs |

## TypeScript / JavaScript / Web

| Skill | Use when |
|-------|----------|
| [`frontend-patterns`](./frontend-patterns/SKILL.md) | React/Next.js state, performance, UI best practices |
| [`backend-patterns`](./backend-patterns/SKILL.md) | API/server-side architecture, DB optimization (Node/Express/Next) |
| [`react-patterns`](./react-patterns/SKILL.md) | React 18/19 hooks discipline, RSC boundaries, Suspense |
| [`react-testing`](./react-testing/SKILL.md) | RTL + Vitest/Jest, MSW, axe a11y assertions |
| [`react-performance`](./react-performance/SKILL.md) | Render optimization, memoization, profiling |
