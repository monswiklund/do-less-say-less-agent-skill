---
name: dlsl-debt
description: |
  Do Less, Say Less debt ledger. Harvest `ponytail:` comments and deliberate
  shortcut markers into a concise report, optionally writing a ledger file when
  explicitly requested. Use when the user says /dlsl-debt, ponytail debt, dlsl
  debt, list shortcuts, what did we defer, debt ledger, or what did we mark to
  do later.
---

# dlsl-debt

Collect deliberate simplification markers. Default read-only.

## Scan

Use fast search, skip `.git`, `node_modules`, build output, vendored deps:

```sh
rg -n --hidden --glob '!.git' --glob '!node_modules' --glob '!dist' --glob '!build' '(^|[[:space:]])(#|//|--|/\*) ?ponytail:'
```

Fallback:

```sh
grep -rnE '(#|//|--) ?ponytail:' .
```

## Parse

Convention:

```text
ponytail: <ceiling>, <upgrade trigger/path>
```

Tag entries with no upgrade trigger as `no-trigger`.

## Output

Group by file:

```text
<file>:<line> — <simplification>. ceiling: <limit>. upgrade: <trigger>.
```

End:

```text
<N> markers, <M> no-trigger.
```

Nothing found:

```text
No ponytail: debt. Clean ledger.
```

## Persist

Only if user asks to write/save ledger: create or update `PONYTAIL-DEBT.md`.
