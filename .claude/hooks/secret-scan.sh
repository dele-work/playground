#!/usr/bin/env bash
# PreToolUse hook: block git commit/push if staged changes contain likely secrets.
#
# Self-contained (no dependencies beyond git + standard coreutils). Adapted in
# spirit from ECC's secret-detection hooks, but rewritten to be dependency-free
# so it works inside the GitHub Actions pipeline and local sessions alike.
#
# Hook protocol: reads the tool-call JSON on stdin. Exit 0 = allow.
# Exit 2 = block; stderr is shown to Claude so it can fix the issue.
set -euo pipefail

payload="$(cat 2>/dev/null || true)"

# Only act on git commit / git push Bash commands.
case "$payload" in
  *"git commit"*|*"git push"*) ;;
  *) exit 0 ;;
esac

# Inspect staged content; fall back to the full working diff.
diff="$(git diff --cached 2>/dev/null || true)"
[ -z "$diff" ] && diff="$(git diff 2>/dev/null || true)"
[ -z "$diff" ] && exit 0

# High-signal secret patterns. Keep conservative to avoid false positives.
patterns='(sk-[A-Za-z0-9]{20,})|(AKIA[0-9A-Z]{16})|(ghp_[A-Za-z0-9]{36})|(github_pat_[A-Za-z0-9_]{40,})|(xox[baprs]-[A-Za-z0-9-]{10,})|(-----BEGIN [A-Z ]*PRIVATE KEY-----)|((api[_-]?key|secret|password|token)["'"'"'[:space:]]*[:=]["'"'"'[:space:]]*[A-Za-z0-9/_+\-]{16,})'

hits="$(printf '%s\n' "$diff" | grep -aiEn "$patterns" || true)"

if [ -n "$hits" ]; then
  {
    echo "BLOCKED: possible secret detected in staged/working changes."
    echo "Do not commit credentials. Move them to environment variables and"
    echo "rotate anything that may have been exposed. Matching lines:"
    echo "$hits" | head -10
  } >&2
  exit 2
fi

exit 0
