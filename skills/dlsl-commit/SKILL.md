---
name: dlsl-commit
description: |
  Do Less, Say Less commit helper. Draft or create terse Conventional Commit
  messages with a subject at 50 characters or less, focusing on why over what,
  without verbose bodies unless needed. Use when the user says /dlsl-commit,
  caveman-commit, write commit message, make commit message, or asks for a
  minimal conventional commit.
---

# dlsl-commit

Write commit message only unless user explicitly asks to commit.

## Rules

- Conventional Commit type: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`.
- Subject ≤ 50 chars.
- Imperative mood.
- Why over what when possible.
- No filler.
- Body only when subject cannot carry risk/context.
- Preserve issue IDs, paths, APIs, and error strings verbatim.

## Flow

1. Read diff/status.
2. Identify user-visible reason.
3. Draft one best message.
4. If user asked to commit, run normal git flow only after scope clear.

## Output

```text
fix: prevent CSV export corruption
```

With body only if needed:

```text
fix: escape SMS CSV fields

Store names may contain separators/newlines.
Quote fields before export.
```

## Boundary

Commit messages use normal concise English, not heavy Caveman symbols. Git history must stay readable.
