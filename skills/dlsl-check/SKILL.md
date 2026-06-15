---
name: dlsl-check
description: |
  Do Less, Say Less read-only drift and invariant checker. Compare SPEC.md to
  code and report violations, stale tasks, interface drift, and unverifiable
  claims without editing anything. Use when the user says /dlsl-check, dlsl
  check, check drift, audit the spec, verify invariants, check §V, check §I,
  check §T, or spec vs code.
---

# dlsl-check

Read-only. Report drift. Write nothing.

## Load

Read `SPEC.md`. If missing → `no spec, nothing to check.` Stop.

Args:

- `§V` → invariants only. Default.
- `§I` → interfaces.
- `§T` → task status.
- `--all` → all.

## Check

§V:

- Translate each invariant to verifiable code claim.
- Classify `HOLD`, `VIOLATE`, or `UNVERIFIABLE`.
- Include file:line evidence.

§I:

- Locate implementation.
- Classify `MATCH`, `DRIFT`, `MISSING`, or `EXTRA`.

§T:

- `x` → verify work exists.
- `~` → report in progress.
- `.` → report pending.
- `x` with no evidence → `STALE`.

## Report

Compressed, severity first:

```text
## §V drift
V2 VIOLATE: auth/mw.go:47 uses `<` not `≤`.
V5 UNVERIFIABLE: no test covers ∀ req path.

## §I drift
I.api DRIFT: POST /x returns `{result}` not `{id}`.

## §T drift
T3 STALE: status `x`, no middleware found.

## summary
2 violate. 1 drift. 1 stale.
next: dlsl-spec bug:<cause> | dlsl-build §T.n
```

## Boundaries

- No fixes.
- No spec edits.
- No score or grade.
- Complexity-only findings belong in `dlsl-review`.
