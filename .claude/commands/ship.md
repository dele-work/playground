---
description: One-shot vibe-coding pipeline — explore, plan, TDD, parallel review, verify, commit. Fully autonomous; no questions unless genuinely blocked.
---

# /ship — autonomous end-to-end delivery

Take the request in `$ARGUMENTS` from idea to verified commit in a single run.
This is the default entry point for vibe coding: the user describes *what*,
this command owns *how*. Do not stop to ask for approval between phases —
only ask when a decision is genuinely the user's to make (destructive action,
ambiguous product intent with materially different outcomes).

## Operating principles

- **Parallelize by default.** Whenever two pieces of work are independent
  (exploration of separate areas, the three review agents, doc updates vs.
  test runs), launch them as concurrent subagents in a single message.
- **Long tasks keep a ledger.** If the request will plausibly span many steps
  or risk context compaction, immediately record a checklist in
  `.claude/state/TASKS.md` (see `/long-task`) and tick items as you go.
- **Verification is non-negotiable.** Nothing ships without lint + tests
  passing locally. The Stop hook enforces lint, but run the full check
  yourself before committing.

## Pipeline

### 1. Understand (fast)

- Restate the goal in one sentence; extract acceptance criteria.
- Launch `code-explorer` to map the relevant existing code. If the request
  touches several distinct areas, launch one exploration per area **in
  parallel**.

### 2. Plan (proportional)

- Small change → a short inline plan is enough.
- Multi-file feature or refactor → delegate to `planner`, break into phases,
  and write the phases into `.claude/state/TASKS.md`.

### 3. Implement (TDD)

- Follow `tdd-guide` discipline: failing test → minimal implementation →
  refactor. Respect `.claude/rules/coding-style.md` and `testing.md`.
- Commit at meaningful checkpoints (`type: description`), not one giant
  commit at the end.

### 4. Review (parallel)

Launch concurrently on the final diff, in one message:

- `code-reviewer` — general quality
- `security-reviewer` — if the change touches input handling, auth, secrets,
  file/network access, or dependencies
- `typescript-reviewer` — if `.ts/.tsx/.js/.jsx` files changed

Consolidate findings by severity. Fix CRITICAL and HIGH before continuing;
note MEDIUM/LOW in the summary if intentionally skipped.

### 5. Verify & finish

- Run `npm run verify` (lint + tests). Fix until green.
- Final commit; push only if the user asked for a push/PR.
- Report: what shipped, how it was verified, anything intentionally deferred.

## Failure handling

- Build/type errors → delegate to `build-error-resolver`, then resume the
  pipeline where it stopped.
- Stuck after 3 distinct attempts on the same error → stop and report the
  diagnosis honestly instead of thrashing.
