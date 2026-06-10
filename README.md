# Playground — 自律AI開発パイプライン

GitHub Actions と Claude Code Action を使った自律AI開発パイプラインの実験リポジトリです。

## 概要

Issueを起点に、要件定義・実装・レビュー・マージまでをAIエージェントが自動で進めます。

```
Issue → 要件定義 → 実装 → CI修正 → レビュー → マージ
```

## ローカル開発体験(vibe coding)

Claude Code でこのリポジトリを開くと、以下が**自動で**機能します。
ユーザーが意識する必要はありません。

| 仕組み | トリガー | 効果 |
|--------|---------|------|
| セッションブリーフィング | セッション開始時 | ブランチ・未コミット変更・直近コミット・進行中タスクを自動把握。依存が無ければ `npm install` をバックグラウンド実行 |
| 自動フォーマット | ファイル編集のたび | Prettier / markdownlint --fix を即適用。diff が常にクリーン |
| 終了時検証ループ | エージェントの応答完了時 | 変更があるのに lint が落ちていたら自動で差し戻し、直してから終了 |
| シークレットスキャン | `git commit` / `git push` 前 | 資格情報らしき差分を検出してブロック |

### オーケストレーションコマンド

| コマンド | 用途 |
|---------|------|
| `/ship <要求>` | 探索→計画→TDD→**並列レビュー**→検証→コミットを一発実行 |
| `/long-task` | `.claude/state/TASKS.md` の永続台帳で、コンテキスト圧縮やセッション再開をまたいで長期タスクを継続 |
| `/parallel <ゴール>` | 独立サブタスクをサブエージェント(必要なら worktree 隔離)へ自動ファンアウトし、統合 |

長期タスクの台帳は作業と一緒にコミットされるため、別のマシン・別のセッション
からでも `claude` を起動するだけで続きから再開できます。

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
.claude/
  agents/      # 専門サブエージェント(AGENTS.md 参照)
  commands/    # スラッシュコマンド(/ship, /long-task, /parallel など)
  hooks/       # 自動化フック(ブリーフィング/フォーマット/検証/秘密検出)
  rules/       # 常時適用ルール
  skills/      # ドメイン知識スキル
  state/       # 長期タスク台帳(コミット対象)
src/           # ソースコード (TypeScript)
docs/          # 設計ドキュメント
```

## コマンド

```bash
npm run lint     # リント
npm run format   # フォーマット (Prettier)
npm run test     # テスト
npm run verify   # lint + test(コミット前に実行)
npm run build    # ビルド
```

## ドキュメント言語ポリシー

人間向けドキュメントは日本語、AI がランタイムで読み込むファイル
(`CLAUDE.md`、rules 本文、agents、skills、commands、prompts)は精度優先で
英語です。詳細は `CONTRIBUTING.md` を参照してください。

## コーディング規約

- TypeScript strict mode
- 関数は単一責任
- 変更にはテスト必須
- コミットメッセージ: `type: description`
