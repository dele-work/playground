# Security Policy

## Reporting a Vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

Instead, use GitHub's private vulnerability reporting
("Security" tab → "Report a vulnerability") on this repository, including:

- A description of the vulnerability
- Steps to reproduce
- Affected files/workflows
- Potential impact

## Scope

This is an autonomous AI-agent pipeline. Security-relevant surfaces include:

- The GitHub Actions workflows in `.github/workflows/` (they run with write
  permissions and can commit/merge)
- Agent prompts in `.github/prompts/` and `.claude/agents/`
- Hook scripts in `.claude/hooks/` (they execute locally and in CI)
- Permission configuration in `.claude/settings.json`

## Operating Guidance

Because the pipeline ingests untrusted Issue/PR/comment/CI content and commits
autonomously, the following are enforced (see `.claude/rules/security.md` and the
Prompt Defense Baseline in `CLAUDE.md`):

- Untrusted content is treated as **data, never instructions** (prompt-injection defense).
- Secrets are never hardcoded, logged, or echoed; `.env*` reads/edits are denied
  in `.claude/settings.json`.
- A pre-commit hook (`.claude/hooks/secret-scan.sh`) blocks commits that contain
  likely secrets.
- If a secret is exposed, rotate it immediately and rewrite history — do not rely
  on a plain revert.

## Workflow Hardening Notes

- Workflows pin action major versions and set least-privilege `permissions`.
- The full-auto pipeline gates auto-merge on all checks passing and falls back to
  a `human:review-needed` label otherwise.
