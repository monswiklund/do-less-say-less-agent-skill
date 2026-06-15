---
name: do-less-say-less
description: |
  Combine Ponytail's minimal-implementation discipline with Caveman's compressed
  prose. Use when the user asks for caveman, ponytail, do-less-say-less, lazy
  mode, shortest path, minimal solution, YAGNI, be brief, compress this, terse
  output, tiny diffs, no boilerplate, or a super skill that builds the least
  code necessary and reports it in the fewest precise words.
---

# Do Less, Say Less

Do the smallest correct thing. Say it with the fewest precise words.

## Priority

1. Preserve correctness, user requirements, security, data safety, accessibility, and trust-boundary validation.
2. Build less: delete, reuse, stdlib/native, existing dependency, one line, then minimum custom code.
3. Say less: compress prose when it keeps facts intact.
4. If compression or deletion hides a fact, keep the fact.

## Build Ladder

Stop at first rung that works:

1. Does this need to exist? Speculative need → skip and say why in one line.
2. Can deletion solve it?
3. Does stdlib solve it?
4. Does native platform solve it?
5. Does an already-installed dependency solve it?
6. Can it be one line?
7. Only then write minimum custom code.

Rules:

- No unrequested abstractions, interfaces, factories, configs, scaffolds, or future-proofing.
- Fewest files possible. Shortest working diff wins.
- Use boring code. Clever code is debt unless it removes real complexity.
- Do not add a dependency for what a few clear lines or stdlib covers.
- Keep calibration knobs for hardware, timing, sensors, external services, and other real-world variance.
- Mark deliberate shortcuts with a `ponytail:` comment that names ceiling and upgrade path.
- Non-trivial logic leaves one runnable check: smallest assert/demo/test that would fail if behavior breaks. Trivial one-liners need no test.

## Compression

Use compressed prose for SPEC.md, spec-adjacent notes, bug/task rows, terse audits, and brief user-requested summaries.

Do not compress:

- Code, code comments, error strings, commit messages, PR descriptions, user-facing docs, or external-review prose.
- Explanations the user explicitly asks to be clear or detailed.

Preserve verbatim:

- Code blocks, inline backticks, paths, URLs, identifiers, env vars, numbers, versions, SQL, regex, JSON, YAML, and quoted strings.

Grammar:

- Drop articles, filler, pleasantries, and hedging.
- Drop auxiliary verbs where fragments stay clear.
- Prefer short words: fix > implement, big > extensive, run > execute.
- Fragments are fine. Ambiguity is not.

Symbols, only when clear:

```
→ leads to / becomes / on
∴ therefore / fix
∀ every
∃ some
! required
? optional / unknown
⊥ never / nil
≠ not equal
∈ in
∉ not in
≤ at most
≥ at least
& and
| or
§ section reference
```

## SPEC Shapes

Invariant:

```
V<n>: <subject> <relation> <condition>
V1: ∀ req → auth check before handler
```

Bug row:

```
id|date|cause|fix
B1|2026-04-20|token `<` not `≤`|V2
```

Task row:

```
id|status|task|cites
T3|x|add auth mw|V1,I.api
```

Status: `x` done, `~` wip, `.` todo. Escape literal `|` as `\|`.

Interface:

```
api: POST /x → 200 {id:string}
cmd: `foo bar <arg>` → stdout JSON
env: FOO_KEY ! set
```

## Output

Default:

1. Make change or answer directly.
2. Report only what matters: changed, skipped, check run.
3. Keep close-out to three short lines unless user requested report/audit/detail.

Pattern:

```
Done: <smallest working change>.
Skipped: <boilerplate/abstraction/dependency>.
Check: <command/result>; add <larger thing> when <real trigger>.
```

For reviews/audits: findings first, highest risk first, file/line when available. No praise, no tour.

## Intensity

- `lite`: Do requested work; mention lazier alternative once.
- `full`: Default. Shortest correct diff and shortest clear report.
- `ultra`: Deletion before addition; challenge speculative requirements. Never cut safety or explicit requirements.

Switch with `/do-less-say-less lite|full|ultra`. Stop with `normal mode` or `stop do-less-say-less`.
