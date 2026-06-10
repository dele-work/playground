# エージェント一覧

このリポジトリは `.claude/agents/` に専門サブエージェントを同梱しています。
各エージェントは YAML フロントマター(`name`, `description`, `tools`, `model`)
付きの Markdown ファイルで、その後に動作指示が続きます。
[ECC](https://github.com/affaan-m/ECC) を本リポジトリのパイプライン向けに
取捨選択・調整したものです。

> エージェント定義本文は AI が直接読み込むため英語で記述しています
> (言語ポリシーは `CONTRIBUTING.md` 参照)。

## パイプライン中核

| エージェント | モデル | 役割 |
|-------------|--------|------|
| [`planner`](.claude/agents/planner.md) | opus | 複雑な機能・リファクタを実行可能なフェーズに分解する実装計画 |
| [`tdd-guide`](.claude/agents/tdd-guide.md) | sonnet | テストファースト(RED→GREEN→REFACTOR)を強制、カバレッジ80%以上 |
| [`code-reviewer`](.claude/agents/code-reviewer.md) | sonnet | 品質・セキュリティの汎用レビュー(確信度ベースのフィルタリング) |
| [`typescript-reviewer`](.claude/agents/typescript-reviewer.md) | sonnet | TS/JS の型安全性・async の正しさ・イディオム |
| [`security-reviewer`](.claude/agents/security-reviewer.md) | sonnet | OWASP Top 10、シークレット、インジェクション、危険な暗号利用 |
| [`build-error-resolver`](.claude/agents/build-error-resolver.md) | sonnet | ビルド/型エラーの最小修正(リファクタリングはしない) |

## 汎用開発

| エージェント | モデル | 役割 |
|-------------|--------|------|
| [`architect`](.claude/agents/architect.md) | opus | システム設計、スケーラビリティ、技術的意思決定 |
| [`code-explorer`](.claude/agents/code-explorer.md) | sonnet | 既存コードの実行パス追跡とアーキテクチャの把握 |
| [`refactor-cleaner`](.claude/agents/refactor-cleaner.md) | sonnet | デッドコード・重複の検出と安全な削除(knip, depcheck, ts-prune) |
| [`code-simplifier`](.claude/agents/code-simplifier.md) | sonnet | 挙動を変えずにコードを簡潔化 |
| [`silent-failure-hunter`](.claude/agents/silent-failure-hunter.md) | sonnet | 握りつぶされたエラー、不適切なフォールバックの検出 |
| [`type-design-analyzer`](.claude/agents/type-design-analyzer.md) | sonnet | 型設計のカプセル化・不変条件のレビュー |
| [`comment-analyzer`](.claude/agents/comment-analyzer.md) | sonnet | コメントの正確性とコメント腐敗リスクのレビュー |
| [`pr-test-analyzer`](.claude/agents/pr-test-analyzer.md) | sonnet | PR のテストカバレッジ品質・挙動網羅性の評価 |
| [`performance-optimizer`](.claude/agents/performance-optimizer.md) | sonnet | ボトルネック検出、実行時間/バンドル/メモリの最適化 |
| [`database-reviewer`](.claude/agents/database-reviewer.md) | sonnet | SQL・スキーマ・マイグレーションのレビューとクエリ最適化 |
| [`doc-updater`](.claude/agents/doc-updater.md) | haiku | ドキュメントとコードマップをコードに追従させる |
| [`python-reviewer`](.claude/agents/python-reviewer.md) | sonnet | PEP 8、Pythonic イディオム、型ヒント、セキュリティ |

## パイプラインでの使われ方

| ワークフローステージ | プロンプト | 委譲先 |
|---------------------|-----------|--------|
| implement | `.github/prompts/implement.md` | `planner`, `tdd-guide` |
| review | `.github/prompts/review.md` | `code-reviewer`, `typescript-reviewer`, `security-reviewer` |
| fix-ci | `.github/prompts/fix-ci.md` | `build-error-resolver` |

各エージェントをいつ呼ぶか・並列実行の方法は `.claude/rules/agents.md` を
参照してください。
