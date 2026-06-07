---
description: Security scan of the project — delegates to the security-reviewer agent and the security-review skill, plus dependency and secret checks.
argument-hint: "[path | blank for whole project]"
---

# Security Scan

Run a security review of the project (or `$ARGUMENTS` path) and turn findings
into a prioritized remediation plan. Adapted from ECC's `/security-scan`, with
the external AgentShield dependency removed in favor of this repo's own assets.

## Steps

1. **Delegate** to the `security-reviewer` agent
   (`.claude/agents/security-reviewer.md`) and apply the `security-review` skill
   checklist (`.claude/skills/security-review/SKILL.md`).
2. **Dependencies** — run the package manager's audit:
   ```bash
   npm audit --audit-level=high   # or: pnpm audit / yarn audit
   ```
3. **Secrets** — scan tracked content for likely secrets (the pre-commit hook
   `.claude/hooks/secret-scan.sh` enforces this on commit; run a broader sweep here).
4. **Agent/hook/permission surfaces** — review `.claude/settings.json` permissions,
   `.claude/hooks/*`, and any MCP configs for: broad permissions, executable hooks,
   unpinned `npx`, and prompts that handle untrusted input without defenses.

## Output

For each CRITICAL/HIGH finding return: file path, severity, why it matters, exact
remediation, and whether it is safe to auto-fix. Group lower-confidence findings
(docs/examples/templates) separately. Use scanner/audit output as fact; keep
follow-up judgment separate. Do not invent findings.

## Reference

- Agent: `.claude/agents/security-reviewer.md`
- Skill: `.claude/skills/security-review/SKILL.md`
- Rules: `.claude/rules/security.md`
