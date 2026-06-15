---
name: dlsl-build
description: |
  Do Less, Say Less build workflow. Implement the smallest correct change from
  SPEC.md tasks while preserving §V invariants and §I interfaces. Use when the
  user says /dlsl-build, dlsl build, build --next, build §T.n, implement next
  task, run the build, execute the spec, or asks to implement SPEC.md.
---

# dlsl-build

Implement from `SPEC.md`. Minimal diff. No commits, staging, or speculative work.

## Load

1. Read `SPEC.md`. If missing → tell user to run `dlsl-spec` first. Stop.
2. Parse args:
   - `§T.n` → that task only.
   - `--next` → lowest `.` or `~`.
   - `--all` or empty → all `.` rows in order.

## Plan

For chosen task(s):

- Cite relevant §V invariants.
- Cite touched §I interfaces.
- Name files to edit/create.
- Pick smallest runnable check.
- Prefer deletion, stdlib, native platform, existing deps, one-liners, then minimal custom code.

Show concise plan unless user already gave explicit auto-build instruction.

## Execute

Per task:

1. Flip task `.` → `~`.
2. Edit minimum code.
3. Add one smallest check for non-trivial logic.
4. Run verification.
5. Pass → run Finish Pass.
6. Pass after Finish Pass → flip `~` → `x`.
7. Fail → classify before retry:
   - code bug → fix code, rerun.
   - spec wrong / edge unspecified → run `dlsl-spec bug: <cause>` workflow, then resume.

## Finish Pass

After verification passes, do one micro-refactor pass:

- Delete dead code introduced by task.
- Remove unused imports, vars, logs, comments, and temporary scaffolding.
- Inline one-use helper/constant created during task if clearer.
- Collapse duplicated branch only when obvious and behavior unchanged.
- No new abstractions.
- No style-only churn.
- Rerun same verification if any file changed.

Stop after first useful tiny cleanup. If none, report `micro-refactor: none`.

## Boundaries

- Only edit `SPEC.md` task status from this workflow.
- Other spec edits go through `dlsl-spec`.
- Never cut validation, security, data-safety, accessibility, or explicit requirements.
- Do not add dependencies unless existing platform cannot do the job cleanly.

## Output

```text
Done: T<n> <smallest change>.
Check: <command> OK.
micro-refactor: <done|none>.
Skipped: <abstraction/dependency/future work>; add when <real trigger>.
```
