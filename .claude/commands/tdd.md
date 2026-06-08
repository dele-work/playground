---
description: Test-driven development workflow — write a failing test first, then minimal code to pass, then refactor. Enforces 80%+ coverage.
argument-hint: "[feature or bug description]"
---

# TDD

Drive the change test-first. Input: $ARGUMENTS

Delegate to the `tdd-guide` agent when available; otherwise run inline.

## Loop

1. **RED** — Write a failing test that describes the expected behavior.
2. **Verify it fails** — Run the test suite (`npm test`) and confirm the new
   test fails for the right reason.
3. **GREEN** — Write the minimal implementation to make it pass.
4. **Verify it passes** — Re-run the suite.
5. **REFACTOR** — Remove duplication and improve names; tests must stay green.
6. **Coverage** — Verify 80%+ (branches, functions, lines, statements).

## Edge cases to cover

Null/undefined, empty collections, invalid types, boundary values, error paths
(network/DB failures), concurrency, large inputs, and special characters.

## Anti-patterns to avoid

- Testing implementation details instead of behavior
- Tests that depend on each other (shared state)
- Assertions that don't actually verify anything
- Not mocking external dependencies

See `.claude/rules/testing.md` for the full conventions.
