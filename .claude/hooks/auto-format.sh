#!/usr/bin/env bash
# PostToolUse hook (Edit|Write): auto-format the file that was just modified.
#
# Keeps formatting out of the agent's head entirely — every edited file is
# normalized immediately (Prettier for code/config, markdownlint --fix for
# Markdown), so review diffs stay clean without anyone running a formatter.
#
# Best-effort by design: uses locally installed tools only (npx --no-install),
# never blocks, always exits 0.
set -uo pipefail

payload="$(cat 2>/dev/null || true)"
[ -z "$payload" ] && exit 0

# Extract file_path from the tool-call JSON (jq if present, sed fallback).
if command -v jq >/dev/null 2>&1; then
  file="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
else
  file="$(printf '%s' "$payload" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)"
fi
[ -z "$file" ] || [ ! -f "$file" ] && exit 0

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

case "$file" in
  *.md)
    npx --no-install markdownlint-cli2 --fix "$file" >/dev/null 2>&1 || true
    ;;
  *.ts|*.tsx|*.js|*.jsx|*.mjs|*.cjs|*.json|*.yml|*.yaml|*.css)
    npx --no-install prettier --write --log-level silent "$file" >/dev/null 2>&1 || true
    ;;
esac

exit 0
