#!/usr/bin/env bash
# Stop フック: エージェントがターンを終える前の自動検証ループ。
#
# このセッションでファイルが変更されたのに lint が落ちている場合、終了を
# ブロックし(exit 2)、失敗内容を Claude に差し戻して修正させてから
# 終了させる。「コミット前に lint を実行する」をエージェントが覚えておく
# ルールから、ハーネスが自動で強制する仕組みに変える。
#
# ループガード: ペイロードに stop_hook_active=true がある場合は、この
# フック自身が起こした継続の中にいる — 2連続でブロックしてはならない。
#
# ※ stderr のメッセージは Claude に渡るため英語(CONTRIBUTING.md 参照)。
set -uo pipefail

payload="$(cat 2>/dev/null || true)"
case "$payload" in
  *'"stop_hook_active":true'*|*'"stop_hook_active": true'*) exit 0 ;;
esac

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

# このセッションで何も変わっていない → 検証するものがない。
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
[ -z "$(git status --porcelain 2>/dev/null)" ] && exit 0

# ツールチェーン未準備(新しいコンテナで install 実行中など)→ うるさく
# 失敗するのではなくスキップする。
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
