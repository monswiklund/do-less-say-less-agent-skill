---
name: dlsl-spec
description: |
  Do Less, Say Less spec workflow. Create, distill, amend, or backprop bugs
  into SPEC.md with Caveman-style compression and Ponytail-style minimal scope.
  Use when the user says /dlsl-spec, dlsl spec, spec this idea, write a spec,
  new spec, distill spec from code, amend SPEC.md, add invariants, or bug
  reports. Sole mutator of SPEC.md in this skill family.
---

# dlsl-spec

Mutate `SPEC.md` only. Keep spec in English. No commits, staging, or unrelated files.

## Format

Use compressed precise prose:

- Drop filler, articles, hedging, pleasantries.
- Keep identifiers, paths, code, numbers, versions, quoted strings verbatim.
- Use symbols only when clear: `→`, `∴`, `∀`, `∃`, `!`, `?`, `⊥`, `≠`, `≤`, `≥`, `&`, `|`, `§`.
- If compression loses fact, keep fact.

Canonical shapes:

```text
V<n>: <subject> <relation> <condition>
api: POST /x → 200 {id:string}
cmd: `foo bar <arg>` → stdout JSON
env: FOO_KEY ! set
```

Task rows:

```text
id|status|task|cites
T1|.|smallest task|V1,I.api
```

Status: `x` done, `~` wip, `.` todo. Escape literal `|` as `\|`.

Bug rows:

```text
id|date|cause|fix
B1|2026-06-15|cause|V2
```

## Dispatch

1. No `SPEC.md` and user gives idea → create new spec.
2. No `SPEC.md` and user says `from-code` / distill → infer spec from repo.
3. `SPEC.md` exists and user says `bug:` → append §B and possible §V.
4. `SPEC.md` exists and user says amend/add/update → targeted amend.
5. Ambiguous existing spec request → ask one concise question.

## New Spec

Create root `SPEC.md`:

```text
# SPEC

## §G Goal
...

## §C Constraints
...

## §I Interfaces
...

## §V Invariants
...

## §T Tasks
id|status|task|cites
...

## §B Bugs
id|date|cause|fix
```

Rules:

- Goal = one line.
- Constraints = stated/implied only.
- Interfaces = external surfaces only.
- Invariants = recurrence-preventing truths.
- Tasks = smallest ordered build steps. No speculative work.

## Distill

Read repo. Infer:

- §G from README/package/main entry.
- §C from stack/config.
- §I from public APIs/CLIs/env/files.
- §V from tests/assertions/security boundaries.
- §T from TODOs, missing checks, obvious gaps.

Mark uncertainty with `?`.

## Backprop

For `bug: <description>`:

1. Find root cause.
2. Append §B row for every bug.
3. Add §V only if invariant would catch recurrence.
4. Add/update §T only when fix needs behavior work.
5. Show diff.

## Amend

Only edit named section. Never rewrite unrelated sections.

## Output

Show changed spec or diff. End with next command hint:

```text
next: dlsl-build --next | dlsl-check --all
```
