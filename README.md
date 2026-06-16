# Do Less, Say Less Agent Skills

Portable skill pack for Codex, Claude Code, Google Antigravity, and Antigravity CLI.

## Skills

```text
skills/do-less-say-less/  # core behavior: smallest correct thing, fewest precise words
skills/dlsl-compress/     # shrink memory/docs, preserve code/paths/URLs
skills/dlsl-commit/       # tiny Conventional Commit messages
skills/dlsl-spec/         # create/amend/backprop SPEC.md
skills/dlsl-build/        # implement smallest task from SPEC.md
skills/dlsl-check/        # read-only SPEC.md drift checker
skills/dlsl-review/       # over-engineering review
skills/dlsl-debt/         # ponytail shortcut ledger
```

Core skill uses Caveman voice for normal status too:

```text
SMS diff + repo rules first → risks/checks only.
`npm run check` OK. `npm test` absent → find target test script.
```

## Install

From this folder:

```sh
sh install.sh --all
```

That installs all skills to:

```text
~/.agents/skills                         # Codex and Antigravity desktop
~/.claude/skills                         # Claude Code
~/.gemini/antigravity-cli/skills         # Antigravity CLI
```

It also writes an idempotent init block so the mode persists across turns:

```text
~/.agents/AGENTS.md
~/.codex/AGENTS.md                       # Codex persistence mirror; no duplicate skill dirs
~/.claude/CLAUDE.md
~/.gemini/antigravity-cli/GEMINI.md
```

The block includes direct rules, not only skill references, so long Codex chats can self-correct after context drift.

Copy skills only, no init block:

```sh
sh install.sh --all --no-init
```

Target one tool:

```sh
sh install.sh --codex
sh install.sh --claude
sh install.sh --antigravity
sh install.sh --antigravity-cli
```

Project-local installs:

```sh
sh install.sh --codex-project /path/to/repo
sh install.sh --claude-project /path/to/repo
sh install.sh --antigravity-project /path/to/repo
sh install.sh --antigravity-cli-project /path/to/repo
```

Project installs write `.agents/skills`, `.claude/skills`, or `.agent/skills`, plus a marker block in `AGENTS.md`, `CLAUDE.md`, or `GEMINI.md`.

Older Codex setups that still scan `~/.codex/skills`:

```sh
sh install.sh --codex-legacy
```

Do not combine `--all` and `--codex-legacy` on modern Codex/Antigravity desktop. Both scan roots can appear as `Personal`, causing duplicate rows. Installer refuses that combo unless forced:

```sh
sh install.sh --all --codex-legacy --allow-duplicates
```

## Use

Explicit invocations:

```text
$do-less-say-less
$dlsl-compress
$dlsl-commit
$dlsl-spec
$dlsl-build
$dlsl-check
$dlsl-review
$dlsl-debt
```

Trigger phrases also work:

```text
ponytail
caveman
minimal solution
shortest path
be brief
caveman-compress
write commit message
spec this idea
build --next
check drift
review for over-engineering
ponytail debt
```

Restart the target app if it does not notice new skills immediately.

## Heritage

This pack preserves the useful core of:

- Ponytail: YAGNI, deletion over addition, stdlib/native first, shortest correct diff, intensity levels.
- Ponytail finish pass: after green checks, one micro-refactor only; delete local waste, no new abstraction.
- Caveman: output compression, persistent terse voice, no filler/tool narration, preserve code/errors/paths, keep user language.

Inspired by and compatible with MIT-licensed skill patterns from `ponytail` and [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman).
