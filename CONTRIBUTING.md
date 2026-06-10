# コントリビューションガイド

このリポジトリは AI エージェントパイプラインの実験場です。人間と自律
パイプラインの両方が扱えるよう、以下のフォーマットに従ってください。

## ドキュメント言語ポリシー

基本は日本語、AI がランタイムで読み込むファイルのみ英語です。

| 種別 | 言語 | 理由 |
|------|------|------|
| README / AGENTS.md / 本ファイル / SECURITY.md / 各種インデックス | **日本語** | 読者は日本語の開発者 |
| スクリプト(hooks 等)内のコメント | **日本語** | メンテナンスするのは人間 |
| `CLAUDE.md`、`.claude/rules/` 本文、`.claude/agents/`、`.claude/skills/`、`.claude/commands/`、`.github/prompts/` | **英語** | AI のコンテキストに直接読み込まれるため、精度・性能を優先 |

コミットメッセージ・Issue・PR は日本語で構いません。

## コミット前に

- `npm install` のあと `npm run verify`(lint + test。lint は CI のゲート)。
- 変更は最小限・焦点を絞って。新規追加の前に既存のユーティリティ/ルールを確認。
- シークレット、API キー、認証情報は絶対に含めない。

## コミットメッセージ

`CLAUDE.md` に記載のとおり Conventional Commits 形式
(`commitlint.config.js` で強制):

```
<type>: <description>
```

type: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`,
`ci`, `build`, `revert`。ヘッダは100文字以内。(subject-case は強制しない —
日本語の subject を想定。)

## プルリクエスト

- PR は Issue にリンクする(`closes #N`)。
- レビュー依頼の前に CI がグリーンであることを確認。
- パイプラインがレビュー・CI修正・(ラベル次第で)マージを自動で行うことが
  あるため、各変更は独立してレビュー可能な単位にする。

## ファイルフォーマット

| コンポーネント | 場所 | フォーマット |
|---------------|------|-------------|
| エージェント | `.claude/agents/*.md` | Markdown + フロントマター(`name`, `description`, `tools`, `model`)。ファイル名は `name` と一致 |
| コマンド | `.claude/commands/*.md` | Markdown + フロントマター(`description`、任意で `argument-hint`) |
| ルール | `.claude/rules/*.md` | Markdown。パススコープのルールは `paths:` フロントマターを付ける |
| プロンプト | `.github/prompts/*.md` | パイプラインステージ用の Markdown システムプロンプト |
| ワークフロー | `.github/workflows/*.yml` | アクションはメジャーバージョンを固定。最小権限の `permissions` を設定 |

ファイル名: 小文字ハイフン区切り(例: `typescript-reviewer.md`)。

## 規約

`.claude/rules/` の常時適用ルールに従ってください — 特に `security.md`、
`coding-style.md`、`testing.md`、`code-review.md`。
