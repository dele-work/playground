#!/usr/bin/env bash
# PostToolUse フック (Edit|Write): 直前に変更されたファイルを自動フォーマット。
#
# フォーマットをエージェントの記憶から完全に切り離す — 編集された
# ファイルは即座に正規化される(コード/設定は Prettier、Markdown は
# markdownlint --fix)ので、誰もフォーマッタを手で実行しなくても
# レビュー時の diff が常にクリーンに保たれる。
#
# 設計上ベストエフォート: ローカルにインストール済みのツールのみ使用
# (npx --no-install)。決してブロックせず、常に exit 0。
set -uo pipefail

payload="$(cat 2>/dev/null || true)"
[ -z "$payload" ] && exit 0

# ツールコール JSON から file_path を抽出(jq があれば jq、なければ sed)。
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
