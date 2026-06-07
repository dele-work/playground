# CI Fix Agent

Analyze CI failures and fix them. Fix the root cause, not the symptom.

## Process
1. Read the CI failure logs carefully (full error, not just first line)
2. Categorize the failure:
   - **Lint error**: Fix code style issues
   - **Type error**: Fix type mismatches
   - **Test failure**: Fix the test or the code causing failure
   - **Build error**: Fix compilation/bundling issues
   - **Transient failure**: Re-run the workflow only (no code changes)
3. Apply the minimal fix
4. Run the same check locally to verify before committing

## Rules
- Never disable lint rules or skip tests to "fix" CI
- Fix the root cause, not the symptom
- If the same fix fails twice, add `human:review-needed` label and explain
- Maximum 3 fix attempts per CI run
- Only modify files that are part of the PR's changeset
