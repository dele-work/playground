// Enforces the commit convention documented in CLAUDE.md (`type: description`).
// Adapted from ECC (affaan-m/ECC) commitlint.config.js. `subject-case` is
// disabled because this repo uses Japanese commit subjects, for which the
// Latin-case checks (sentence/start/upper-case) produce false positives.
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      ['feat', 'fix', 'docs', 'style', 'refactor', 'perf', 'test', 'chore', 'ci', 'build', 'revert']
    ],
    'subject-case': [0],
    'header-max-length': [2, 'always', 100]
  }
};
