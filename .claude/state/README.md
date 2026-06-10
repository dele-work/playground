# .claude/state

Durable state for long-horizon agent work.

- `TASKS.md` — the long-task ledger managed by `/long-task` (and `/ship` for
  large requests). Committed together with the work it describes, so progress
  survives context compaction, session restarts, and fresh containers. The
  SessionStart hook (`.claude/hooks/session-start.sh`) surfaces open items at
  the start of every session automatically.

Transient scratch files do not belong here — anything in this directory is
meant to be committed and read by a future session with no memory of the
current one.
