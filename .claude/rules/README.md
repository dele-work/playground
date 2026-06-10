# ルール

このリポジトリで常時適用されるガイドラインです。Claude Code が自動で
読み込み、自律パイプラインは `CLAUDE.md` とエージェントプロンプト経由で
参照します。[ECC](https://github.com/affaan-m/ECC) を本リポジトリ
(AI エージェント GitHub Actions パイプライン)向けに調整・削減したものです。

> 各ルールの本文は AI のコンテキストに直接読み込まれるため英語で記述して
> います(言語ポリシーは `CONTRIBUTING.md` 参照)。この README は人間向けの
> 索引です。

## 索引

| ルール | 適用範囲 | 概要 |
|--------|---------|------|
| [security.md](./security.md) | 全体 | シークレット、入力検証、信頼できない入力への防御、インシデント対応 |
| [code-review.md](./code-review.md) | 全体 | レビューのタイミングと方法、重大度モデル、チェックリスト |
| [coding-style.md](./coding-style.md) | 全体 | KISS/DRY/YAGNI、イミュータビリティ、ファイルサイズ、命名 |
| [testing.md](./testing.md) | 全体 | カバレッジ80%、TDD ループ、AAA 構造 |
| [development-workflow.md](./development-workflow.md) | 全体 | 調査 → 計画 → TDD → レビュー → コミット |
| [git-workflow.md](./git-workflow.md) | 全体 | Conventional Commits 形式、PR ワークフロー |
| [performance.md](./performance.md) | 全体 | モデル選択、コンテキストウィンドウ管理 |
| [patterns.md](./patterns.md) | 全体 | Repository パターン、API レスポンスエンベロープ |
| [agents.md](./agents.md) | 全体 | `.claude/agents/` のサブエージェントと使いどころ |
| [typescript.md](./typescript.md) | `*.ts,*.tsx,*.js,*.jsx` | 型安全性、async の正しさ、バリデーション |

パススコープのルールは `paths:` YAML フロントマターで適用範囲を宣言します。
