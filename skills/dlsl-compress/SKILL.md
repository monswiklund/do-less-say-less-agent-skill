---
name: dlsl-compress
description: |
  Do Less, Say Less file compressor. Rewrite memory files, agent instructions,
  SPEC.md-adjacent notes, project notes, TODOs, or long markdown into Caveman
  style while preserving code blocks, inline code, paths, URLs, identifiers,
  numbers, versions, JSON, YAML, SQL, regex, and quoted strings exactly. Use
  when the user says /dlsl-compress, caveman-compress, compress this file,
  shrink memory, reduce tokens, or make this shorter without losing facts.
---

# dlsl-compress

Compress file content. Preserve facts. Do not compress code.

## Scope

Good targets:

- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, memory files.
- `SPEC.md` and spec notes.
- Project notes, TODOs, runbooks, prompt docs.
- Long markdown that agent reads often.

Bad targets unless user explicitly asks:

- Source code.
- Legal docs.
- User-facing polished docs.
- Commit messages or PR descriptions.

## Preserve Byte-Exact

Never change:

- Code blocks.
- Inline backticks.
- Paths.
- URLs.
- Identifiers, env vars, API names, CLI commands.
- Numbers and versions.
- Error strings.
- SQL, regex, JSON, YAML.
- Quoted strings.

## Rewrite

- Drop articles, filler, pleasantries, hedging.
- Drop auxiliary verbs where fragments stay clear.
- Use short synonyms.
- Keep user's language. Compress style, not language.
- Use `→`, `&`, `!`, `?`, `≤`, `≥` only when unambiguous.
- If cut loses fact, keep fact.

## Check

Before writing:

1. Identify protected spans.
2. Rewrite unprotected prose only.
3. Verify protected spans unchanged.

After writing:

```text
compressed: <file>
saved: ~<N>% words/chars
preserved: code/paths/URLs/ids
```

If unsure about a protected span, leave it unchanged.
