#!/usr/bin/env bash
# PreToolUse フック: ステージ済み変更にシークレットらしき内容があれば
# git commit / git push をブロックする。
#
# 自己完結(依存は git + 標準 coreutils のみ)。発想は ECC のシークレット
# 検出フックを踏襲しつつ、GitHub Actions パイプラインとローカルセッションの
# 両方で動くよう依存なしで書き直したもの。
#
# フックプロトコル: stdin からツールコール JSON を読む。exit 0 = 許可。
# exit 2 = ブロック(stderr が Claude に渡り、修正を促す)。
# ※ stderr のメッセージは Claude に渡るため英語(CONTRIBUTING.md 参照)。
set -euo pipefail

payload="$(cat 2>/dev/null || true)"

# git commit / git push の Bash コマンドのみ対象。
case "$payload" in
  *"git commit"*|*"git push"*) ;;
  *) exit 0 ;;
esac

# ステージ済みの内容を検査。無ければワーキングツリー全体の diff に
# フォールバック。
diff="$(git diff --cached 2>/dev/null || true)"
[ -z "$diff" ] && diff="$(git diff 2>/dev/null || true)"
[ -z "$diff" ] && exit 0

# シグナルの強いシークレットパターンのみ。誤検知を避けるため保守的に保つ。
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
