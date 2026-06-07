# Playground — 自律AI開発パイプライン

GitHub Actions と Claude Code Action を使った自律AI開発パイプラインの実験リポジトリです。

## 概要

Issueを起点に、要件定義・実装・レビュー・マージまでをAIエージェントが自動で進めます。

```
Issue → 要件定義 → 実装 → CI修正 → レビュー → マージ
```

## ラベルとワークフロー

| ラベル | ワークフロー | 動作 |
|--------|-------------|------|
| `claude:implement` | claude-implement.yml | IssueからPRを自動生成 |
| `claude:requirements` | claude-requirements.yml | Issueの要件を整理・明確化 |
| `claude:review` | claude-review.yml | PRを自動レビュー |
| `claude:full-auto` | claude-full-auto-pipeline.yml | CI修正→レビュー→(マージ)を全自動実行 |
| `claude:full-auto(auto-merge)` | 同上 | 上記に加えて自動マージ |
| `human:review-needed` | — | 人間のレビューが必要な状態 |

## エージェントのルール

各エージェントは `.github/prompts/` のプロンプトに従って動作します。

- `implement.md` — 実装エージェント
- `requirements.md` — 要件定義エージェント
- `review.md` — レビューエージェント
- `fix-ci.md` — CI修正エージェント

## ディレクトリ構成

```
.github/
  workflows/   # GitHub Actions ワークフロー
  prompts/     # エージェント用システムプロンプト
  scripts/     # セットアップスクリプト
src/           # ソースコード (TypeScript)
docs/          # 設計ドキュメント
```

## コマンド

```bash
npm run lint   # リント
npm run test   # テスト
npm run build  # ビルド
```

## コーディング規約

- TypeScript strict mode
- 関数は単一責任
- 変更にはテスト必須
- コミットメッセージ: `type: description`
