---
description: Run or resume a long-horizon task with a persistent ledger that survives context compaction, session restarts, and ephemeral containers.
---

# /long-task — durable long-horizon execution

Manage work that is too big for one sitting. The ledger at
`.claude/state/TASKS.md` is the single source of truth for progress: it is
committed with the work, so a fresh session (or a fresh container) can pick
up exactly where the last one stopped. The SessionStart hook surfaces open
ledger items automatically at the start of every session.

## Usage

`/long-task [start <goal> | resume | status | finish]`

If `$ARGUMENTS` is empty: `resume` when a ledger with open items exists,
otherwise ask for the goal.

## Ledger format

```markdown
# Long Task: <goal in one line>

Started: <date> | Branch: <branch>

## Plan
- [x] 1. <phase — done items keep their entry, never delete>
- [ ] 2. <next phase, concrete enough to act on without other context>
- [ ] 3. …

## Notes for resumption
- <decisions made and WHY — the next session has no memory of this one>
- <dead ends already tried, so they are not retried>
- <exact next action, e.g. "continue at src/foo.ts:42, test X still red">
```

## start

1. Break the goal into phases with `planner` (each phase ≤ ~1 hour of work,
   independently verifiable).
2. Write the ledger, commit it (`chore: start long task — <goal>`).
3. Begin executing phases (see Execution loop).

## resume

1. Read the ledger. Trust it over memory — re-derive nothing already noted.
2. Run `git log --oneline -5` and `git status` to confirm the recorded state
   matches reality; reconcile the ledger if it does not.
3. Continue with the first unchecked item.

## Execution loop (every phase)

1. Implement the phase (TDD; parallel subagents where work is independent).
2. Verify: `npm run verify` green.
3. Tick the item, update **Notes for resumption** with decisions and the
   exact next action.
4. Commit work + ledger together — the ledger must never describe a state
   that is not in git.
5. Context running low or session ending → make the notes self-sufficient,
   commit, stop cleanly. Otherwise continue to the next phase without asking.

## status

Report: open vs. done items, current branch state, whether ledger and git
agree, and the recorded next action.

## finish

All items checked → run the full review/verify pass (as in `/ship` phase 4–5),
summarize the outcome, then delete the ledger in the final commit.
