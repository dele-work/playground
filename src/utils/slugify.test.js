const { test } = require('node:test');
const assert = require('node:assert/strict');
const slugify = require('./slugify');

test('converts basic title to slug', () => {
  assert.equal(slugify('Hello World'), 'hello-world');
});

test('trims whitespace and replaces underscores', () => {
  assert.equal(slugify('  Foo_Bar  Baz '), 'foo-bar-baz');
});

test('removes special characters', () => {
  assert.equal(slugify("What's New in 2026!?"), 'whats-new-in-2026');
});

test('strips leading and trailing hyphens', () => {
  assert.equal(slugify('---hello---'), 'hello');
});

test('collapses multiple spaces into one hyphen', () => {
  assert.equal(slugify('a   b'), 'a-b');
});

test('throws TypeError for non-string input', () => {
  assert.throws(() => slugify(42), TypeError);
  assert.throws(() => slugify(null), TypeError);
  assert.throws(() => slugify(undefined), TypeError);
});
