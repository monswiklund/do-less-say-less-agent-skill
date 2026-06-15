#!/usr/bin/env sh
set -eu

bundle_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
skills_dir="$bundle_dir/skills"

usage() {
  cat <<'EOF'
Usage:
  sh install.sh --all
  sh install.sh --all --no-init
  sh install.sh --all --codex-legacy --allow-duplicates
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
  Codex user:              ~/.agents/skills
  Codex legacy user:       ~/.codex/skills
  Claude Code user:        ~/.claude/skills
  Antigravity desktop:     ~/.agents/skills
  Antigravity CLI user:    ~/.gemini/antigravity-cli/skills
  Codex project:           <repo>/.agents/skills
  Claude Code project:     <repo>/.claude/skills
  Antigravity project:     <repo>/.agents/skills
  Antigravity CLI project: <repo>/.agent/skills

Notes:
  Do not combine --all and --codex-legacy unless your Codex only reads ~/.codex.
  Modern Codex/Antigravity desktop read ~/.agents/skills; installing both causes duplicate skill rows.
EOF
}

install_init_block() {
  target_file=$1
  rel_prefix=$2
  tmp_file="${target_file}.tmp.$$"

  mkdir -p "$(dirname "$target_file")"
  if [ -f "$target_file" ]; then
    awk '
      /<!-- dlsl-begin -->/ {skip=1; next}
      /<!-- dlsl-end -->/ {skip=0; next}
      !skip {print}
    ' "$target_file" > "$tmp_file"
  else
    : > "$tmp_file"
  fi

  {
    printf '\n<!-- dlsl-begin -->\n'
    printf '# Do Less, Say Less\n\n'
    printf '@%s/skills/do-less-say-less/SKILL.md\n' "$rel_prefix"
    printf '@%s/skills/dlsl-compress/SKILL.md\n' "$rel_prefix"
    printf '@%s/skills/dlsl-commit/SKILL.md\n' "$rel_prefix"
    printf '@%s/skills/dlsl-spec/SKILL.md\n' "$rel_prefix"
    printf '@%s/skills/dlsl-build/SKILL.md\n' "$rel_prefix"
    printf '@%s/skills/dlsl-check/SKILL.md\n' "$rel_prefix"
    printf '@%s/skills/dlsl-review/SKILL.md\n' "$rel_prefix"
    printf '@%s/skills/dlsl-debt/SKILL.md\n\n' "$rel_prefix"
    printf 'ACTIVE EVERY RESPONSE until `normal mode`, `stop ponytail`, `stop caveman`, or `stop do-less-say-less`.\n'
    printf 'Default: smallest correct change; caveman runtime voice; one micro-refactor after green check.\n'
    printf '<!-- dlsl-end -->\n'
  } >> "$tmp_file"

  mv "$tmp_file" "$target_file"
  printf 'Init block -> %s\n' "$target_file"
}

copy_one_skill() {
  src_dir=$1
  dest_root=$2
  skill_name=$(basename "$src_dir")
  dest_dir="$dest_root/$skill_name"

  mkdir -p "$dest_root"
  rm -rf "$dest_dir"
  mkdir -p "$dest_dir"
  (cd "$src_dir" && tar cf - .) | (cd "$dest_dir" && tar xf -)
  printf 'Installed %s -> %s\n' "$skill_name" "$dest_dir"
}

copy_all_skills() {
  dest_root=$1

  if [ ! -d "$skills_dir" ]; then
    printf 'Missing skills folder: %s\n' "$skills_dir" >&2
    exit 1
  fi

  found=0
  for src_dir in "$skills_dir"/*; do
    [ -d "$src_dir" ] || continue
    [ -f "$src_dir/SKILL.md" ] || continue
    found=1
    copy_one_skill "$src_dir" "$dest_root"
  done

  if [ "$found" -eq 0 ]; then
    printf 'No skills found in %s\n' "$skills_dir" >&2
    exit 1
  fi
}

install_target() {
  skills_root=$1
  init_file=$2
  rel_prefix=$3

  copy_all_skills "$skills_root"
  if [ "$write_init" -eq 1 ]; then
    install_init_block "$init_file" "$rel_prefix"
  fi
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
write_init=1
has_all=0
has_codex_legacy=0
allow_duplicates=0
for arg in "$@"; do
  if [ "$arg" = "--no-init" ]; then
    write_init=0
  fi
  if [ "$arg" = "--all" ]; then
    has_all=1
  fi
  if [ "$arg" = "--codex-legacy" ]; then
    has_codex_legacy=1
  fi
  if [ "$arg" = "--allow-duplicates" ]; then
    allow_duplicates=1
  fi
done
if [ "$has_all" -eq 1 ] && [ "$has_codex_legacy" -eq 1 ] && [ "$allow_duplicates" -eq 0 ]; then
  printf 'Refusing --all + --codex-legacy: would duplicate Codex/Antigravity skill rows.\n' >&2
  printf 'Use --all for modern Codex, or --codex-legacy alone for old Codex.\n' >&2
  printf 'Override: --all --codex-legacy --allow-duplicates\n' >&2
  exit 1
fi

while [ "$#" -gt 0 ]; do
  case "$1" in
    --no-init)
      write_init=0
      shift
      ;;
    --allow-duplicates)
      allow_duplicates=1
      shift
      ;;
    --all)
      install_target "$HOME/.agents/skills" "$HOME/.agents/AGENTS.md" "."
      install_target "$HOME/.claude/skills" "$HOME/.claude/CLAUDE.md" "."
      install_target "$HOME/.gemini/antigravity-cli/skills" "$HOME/.gemini/antigravity-cli/GEMINI.md" "."
      shift
      ;;
    --codex)
      install_target "$HOME/.agents/skills" "$HOME/.agents/AGENTS.md" "."
      shift
      ;;
    --codex-legacy)
      install_target "$HOME/.codex/skills" "$HOME/.codex/AGENTS.md" "."
      shift
      ;;
    --claude)
      install_target "$HOME/.claude/skills" "$HOME/.claude/CLAUDE.md" "."
      shift
      ;;
    --antigravity)
      install_target "$HOME/.agents/skills" "$HOME/.agents/AGENTS.md" "."
      shift
      ;;
    --antigravity-cli)
      install_target "$HOME/.gemini/antigravity-cli/skills" "$HOME/.gemini/antigravity-cli/GEMINI.md" "."
      shift
      ;;
    --codex-project)
      need_arg "$@"
      install_target "$2/.agents/skills" "$2/AGENTS.md" ".agents"
      shift 2
      ;;
    --claude-project)
      need_arg "$@"
      install_target "$2/.claude/skills" "$2/CLAUDE.md" ".claude"
      shift 2
      ;;
    --antigravity-project)
      need_arg "$@"
      install_target "$2/.agents/skills" "$2/AGENTS.md" ".agents"
      shift 2
      ;;
    --antigravity-cli-project)
      need_arg "$@"
      install_target "$2/.agent/skills" "$2/GEMINI.md" ".agent"
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
