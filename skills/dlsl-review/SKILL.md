---
name: dlsl-review
description: |
  Do Less, Say Less complexity review. Find over-engineering in a diff, file,
  or repo: code to delete, stdlib/native replacements, unneeded dependencies,
  speculative abstractions, wrappers, factories, and dead flexibility. Use when
  the user says /dlsl-review, review for over-engineering, what can we delete,
  simplify review, find bloat, audit this codebase, or is this over-engineered.
---

# dlsl-review

Review complexity only. Apply no fixes unless user explicitly asks.

## Scope

- Diff if present.
- Named files if user names files.
- Whole repo if user asks audit/find bloat.

## Hunt

Find:

- `delete:` dead code, unused flexibility, speculative feature.
- `stdlib:` hand-rolled thing standard library ships.
- `native:` dependency/code replaced by platform feature.
- `yagni:` one-implementation interface, one-product factory, config nobody sets, wrapper with one caller.
- `shrink:` same logic, fewer lines.

Never flag:

- Trust-boundary validation.
- Security/data-safety handling.
- Accessibility basics.
- One small smoke/assert check for non-trivial logic.
- Explicitly requested behavior.

## Output

Findings first, ranked by biggest useful cut:

```text
<file>:L<line>: <tag> <what>. <replacement>.
```

End:

```text
net: -<N> lines, -<M> deps possible.
```

Nothing to cut:

```text
Lean already. Ship.
```
