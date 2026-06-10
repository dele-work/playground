# スキル

汎用開発向けの再利用可能なドメイン知識スキルです。Claude Code が名前と
説明から自動で発見するため、関連タスクの作業時に呼び出されます。
[ECC](https://github.com/affaan-m/ECC) から汎用性の高いもの
(言語非依存+コア TS/JS/Web)だけを選別して導入しました。ECC の
ニッチ/業界特化スキル(医療、DeFi、物流、暗号資産など)は意図的に除外
しています。

各スキルは `<name>/SKILL.md`(フロントマター: `name`, `description`,
`origin`)です。

> SKILL.md 本文は AI が直接読み込むため英語で記述しています(言語ポリシーは
> `CONTRIBUTING.md` 参照)。この README は人間向けの索引です。

## 言語非依存

| スキル | 使いどころ |
|--------|-----------|
| [`coding-standards`](./coding-standards/SKILL.md) | 命名・可読性・イミュータビリティの基本規約 |
| [`error-handling`](./error-handling/SKILL.md) | 型付きエラー、リトライ、サーキットブレーカー、ユーザー向けメッセージ |
| [`api-design`](./api-design/SKILL.md) | REST リソース命名、ステータスコード、ページネーション、バージョニング |
| [`tdd-workflow`](./tdd-workflow/SKILL.md) | テストファーストでカバレッジ80%以上を目指す開発 |
| [`e2e-testing`](./e2e-testing/SKILL.md) | Playwright E2E、Page Object Model、CI 連携、flaky テスト対策 |
| [`security-review`](./security-review/SKILL.md) | 認証、入力処理、シークレット、エンドポイント、機微な機能 |
| [`architecture-decision-records`](./architecture-decision-records/SKILL.md) | アーキテクチャ上の意思決定の ADR 記録 |
| [`database-migrations`](./database-migrations/SKILL.md) | スキーマ/データ移行、ロールバック、ゼロダウンタイム |
| [`docker-patterns`](./docker-patterns/SKILL.md) | Dockerfile、Compose、コンテナセキュリティ、ネットワーク |
| [`deployment-patterns`](./deployment-patterns/SKILL.md) | CI/CD、ヘルスチェック、ロールバック、本番準備 |
| [`codebase-onboarding`](./codebase-onboarding/SKILL.md) | 未知のコードベースの把握とスターター CLAUDE.md 作成 |
| [`github-ops`](./github-ops/SKILL.md) | `gh` CLI による Issue/PR/CI/リリース運用 |
| [`verification-loop`](./verification-loop/SKILL.md) | 完了宣言前の検証 |
| [`mcp-server-patterns`](./mcp-server-patterns/SKILL.md) | MCP サーバー構築(tools/resources/prompts、Zod) |
| [`documentation-lookup`](./documentation-lookup/SKILL.md) | ライブラリ/API の一次ドキュメント参照 |

## TypeScript / JavaScript / Web

| スキル | 使いどころ |
|--------|-----------|
| [`frontend-patterns`](./frontend-patterns/SKILL.md) | React/Next.js の状態管理、パフォーマンス、UI ベストプラクティス |
| [`backend-patterns`](./backend-patterns/SKILL.md) | API/サーバーサイド設計、DB 最適化(Node/Express/Next) |
| [`react-patterns`](./react-patterns/SKILL.md) | React 18/19 の hooks 規律、RSC 境界、Suspense |
| [`react-testing`](./react-testing/SKILL.md) | RTL + Vitest/Jest、MSW、axe による a11y アサーション |
| [`react-performance`](./react-performance/SKILL.md) | レンダリング最適化、メモ化、プロファイリング |
