#!/bin/bash
# GitHub ラベルのセットアップスクリプト
# Usage: REPO=owner/repo GH_TOKEN=xxx bash .github/scripts/setup-labels.sh

set -euo pipefail

REPO="${REPO:?REPO environment variable required (e.g., owner/repo)}"

# エージェント用ラベル
declare -A LABELS=(
  ["claude:requirements"]="d4c5f9:要件定義エージェント起動"
  ["claude:implement"]="0e8a16:実装エージェント起動"
  ["claude:review"]="1d76db:レビューエージェント起動"
  ["claude:fix-ci"]="e11d48:CI修正エージェント起動"
  ["claude:auto-merge"]="0075ca:自動マージ"
  ["claude:full-auto"]="6f42c1:フルオートパイプライン"
  ["claude:full-auto(auto-merge)"]="6f42c1:フルオートパイプライン（自動マージ付き）"
  ["human:review-needed"]="fbca04:人間のレビューが必要"
)

for LABEL in "${!LABELS[@]}"; do
  IFS=':' read -r COLOR DESC <<< "${LABELS[$LABEL]}"
  gh label create "$LABEL" \
    --repo "$REPO" \
    --color "$COLOR" \
    --description "$DESC" \
    --force 2>/dev/null || true
  echo "Created/updated label: $LABEL"
done

echo "All labels created."
