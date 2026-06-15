# Do Less, Say Less Agent Skills

Portable skill pack for Codex, Claude Code, Google Antigravity, and Antigravity CLI.

## Skills

```text
skills/do-less-say-less/  # core behavior: smallest correct thing, fewest precise words
skills/dlsl-spec/         # create/amend/backprop SPEC.md
skills/dlsl-build/        # implement smallest task from SPEC.md
skills/dlsl-check/        # read-only SPEC.md drift checker
skills/dlsl-review/       # over-engineering review
skills/dlsl-debt/         # ponytail shortcut ledger
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

Older Codex setups that still scan `~/.codex/skills`:

```sh
sh install.sh --codex-legacy
```

## Use

Explicit invocations:

```text
$do-less-say-less
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
spec this idea
build --next
check drift
review for over-engineering
ponytail debt
```

Restart the target app if it does not notice new skills immediately.
