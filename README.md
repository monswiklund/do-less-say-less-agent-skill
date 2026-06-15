# Do Less, Say Less Agent Skill

Portable agent skill bundle for Codex, Claude Code, Google Antigravity, and Antigravity CLI.

The reusable skill is in:

```text
do-less-say-less/SKILL.md
```

## Install

From this folder:

```sh
sh install.sh --all
```

That installs the skill to:

```text
~/.agents/skills/do-less-say-less                  # Codex and Antigravity desktop
~/.claude/skills/do-less-say-less                  # Claude Code
~/.gemini/antigravity-cli/skills/do-less-say-less  # Antigravity CLI
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

Invoke explicitly:

```text
$do-less-say-less
/do-less-say-less
```

Or ask with trigger phrases such as:

```text
ponytail
caveman
minimal solution
shortest path
be brief
do less, say less
```

Restart the target app if it does not notice the new skill immediately.
