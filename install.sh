#!/usr/bin/env sh
set -eu

skill_name="do-less-say-less"
bundle_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
src_dir="$bundle_dir/$skill_name"

usage() {
  cat <<'EOF'
Usage:
  sh install.sh --all
  sh install.sh --codex
  sh install.sh --codex-legacy
  sh install.sh --claude
  sh install.sh --antigravity
  sh install.sh --antigravity-cli
  sh install.sh --codex-project /path/to/repo
  sh install.sh --claude-project /path/to/repo
  sh install.sh --antigravity-project /path/to/repo
  sh install.sh --antigravity-cli-project /path/to/repo

Targets:
  Codex user:             ~/.agents/skills
  Codex legacy user:      ~/.codex/skills
  Claude Code user:       ~/.claude/skills
  Antigravity desktop:    ~/.agents/skills
  Antigravity CLI user:   ~/.gemini/antigravity-cli/skills
  Codex project:          <repo>/.agents/skills
  Claude Code project:    <repo>/.claude/skills
  Antigravity project:    <repo>/.agents/skills
  Antigravity CLI project:<repo>/.agent/skills
EOF
}

copy_skill() {
  dest_root=$1
  dest_dir="$dest_root/$skill_name"

  if [ ! -d "$src_dir" ]; then
    printf 'Missing skill folder: %s\n' "$src_dir" >&2
    exit 1
  fi

  mkdir -p "$dest_root"
  rm -rf "$dest_dir"
  mkdir -p "$dest_dir"
  (cd "$src_dir" && tar cf - .) | (cd "$dest_dir" && tar xf -)
  printf 'Installed %s -> %s\n' "$skill_name" "$dest_dir"
}

need_arg() {
  if [ "$#" -lt 2 ]; then
    printf 'Missing path for %s\n\n' "$1" >&2
    usage >&2
    exit 1
  fi
}

if [ "$#" -eq 0 ]; then
  usage
  exit 0
fi

: "${HOME:?HOME is not set}"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --all)
      copy_skill "$HOME/.agents/skills"
      copy_skill "$HOME/.claude/skills"
      copy_skill "$HOME/.gemini/antigravity-cli/skills"
      shift
      ;;
    --codex)
      copy_skill "$HOME/.agents/skills"
      shift
      ;;
    --codex-legacy)
      copy_skill "$HOME/.codex/skills"
      shift
      ;;
    --claude)
      copy_skill "$HOME/.claude/skills"
      shift
      ;;
    --antigravity)
      copy_skill "$HOME/.agents/skills"
      shift
      ;;
    --antigravity-cli)
      copy_skill "$HOME/.gemini/antigravity-cli/skills"
      shift
      ;;
    --codex-project)
      need_arg "$@"
      copy_skill "$2/.agents/skills"
      shift 2
      ;;
    --claude-project)
      need_arg "$@"
      copy_skill "$2/.claude/skills"
      shift 2
      ;;
    --antigravity-project)
      need_arg "$@"
      copy_skill "$2/.agents/skills"
      shift 2
      ;;
    --antigravity-cli-project)
      need_arg "$@"
      copy_skill "$2/.agent/skills"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n\n' "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
done
