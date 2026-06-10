---
description: Fan a goal out across parallel subagents (optionally isolated worktrees), then consolidate the results.
---

# /parallel — automatic fan-out / fan-in

Split the goal in `$ARGUMENTS` into independent subtasks and execute them
concurrently. Use this when the work shards cleanly; if it does not, fall
back to `/ship` and say why.

## 1. Decompose

- List candidate subtasks, then check independence honestly: no shared files,
  no ordering constraints, no shared unstated decisions.
- Dependent pieces stay sequential — a wrong parallel split costs more than
  it saves. Shared decisions (naming, interfaces) are made **before** the
  fan-out and written into each subagent's prompt.

## 2. Fan out

- Launch all independent subtasks **in a single message** so they actually
  run concurrently.
- Read-only work (exploration, review, analysis) → plain subagents.
- Write work touching disjoint files → subagents with
  `isolation: "worktree"` so they cannot trample each other.
- Each prompt must be self-contained: goal, acceptance criteria, relevant
  rules from `.claude/rules/`, and the shared decisions from step 1. The
  subagent sees nothing of this conversation.

## 3. Fan in

- Collect results; integrate worktree changes one at a time, running
  `npm run verify` after each merge.
- Conflicts between two subagents' outputs are resolved here by you, the
  orchestrator — never by re-running both.
- Finish with the parallel review pass from `/ship` phase 4 on the combined
  diff, then a consolidated summary: what each lane produced, how it was
  verified, what was deferred.

## Anti-patterns

- Splitting a 5-minute task — orchestration overhead dominates; just do it.
- Two lanes editing the same file "carefully" — they will conflict; merge
  the lanes instead.
- Vague subagent prompts that assume conversation context.
