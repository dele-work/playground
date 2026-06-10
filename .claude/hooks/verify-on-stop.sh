#!/usr/bin/env bash
# Stop hook: automatic verification loop before the agent finishes a turn.
#
# If the session changed files but lint is failing, block the stop (exit 2)
# and hand the failure output back to Claude so it fixes the problem and only
# then finishes. This turns "run lint before committing" from a rule the agent
# must remember into something the harness enforces automatically.
#
# Loop guard: when the payload carries stop_hook_active=true we are already in
# a continuation triggered by this hook — never block twice in a row.
set -uo pipefail

payload="$(cat 2>/dev/null || true)"
case "$payload" in
  *'"stop_hook_active":true'*|*'"stop_hook_active": true'*) exit 0 ;;
esac

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

# Nothing changed this session → nothing to verify.
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
[ -z "$(git status --porcelain 2>/dev/null)" ] && exit 0

# Toolchain not ready (e.g. fresh container, install still running) → skip
# rather than fail noisily.
[ -f package.json ] || exit 0
[ -d node_modules ] || exit 0
command -v npm >/dev/null 2>&1 || exit 0

lint_out="$(npm run -s lint 2>&1)" && exit 0

{
  echo "Lint is failing on the files changed this session. Fix the issues"
  echo "below (try 'npm run lint:fix' first), then finish. First 30 lines:"
  printf '%s\n' "$lint_out" | head -30
} >&2
exit 2
