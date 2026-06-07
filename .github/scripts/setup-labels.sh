#!/bin/bash
# GitHub ラベルのセットアップスクリプト
# Usage: REPO=owner/repo bash .github/scripts/setup-labels.sh

set -euo pipefail

REPO="${REPO:?REPO environment variable required (e.g., owner/repo)}"

gh label create "claude:requirements" --repo "$REPO" --color "d4c5f9" --description "要件定義エージェント起動" --force
gh label create "claude:implement" --repo "$REPO" --color "0e8a16" --description "実装エージェント起動" --force
gh label create "claude:review" --repo "$REPO" --color "1d76db" --description "レビューエージェント起動" --force
gh label create "claude:fix-ci" --repo "$REPO" --color "e11d48" --description "CI修正エージェント起動" --force
gh label create "claude:auto-merge" --repo "$REPO" --color "0075ca" --description "自動マージ" --force
gh label create "claude:full-auto" --repo "$REPO" --color "6f42c1" --description "フルオートパイプライン" --force
gh label create "claude:full-auto(auto-merge)" --repo "$REPO" --color "6f42c1" --description "フルオートパイプライン（自動マージ付き）" --force
gh label create "human:review-needed" --repo "$REPO" --color "fbca04" --description "人間のレビューが必要" --force

echo "All labels created."
