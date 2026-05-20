#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_FILE="$REPO_DIR/skills.yaml"

if [[ ! -f "$SKILLS_FILE" ]]; then
  echo "Cannot find $SKILLS_FILE" >&2
  exit 1
fi

ALL_SKILLS=()
while IFS= read -r skill_id; do
  ALL_SKILLS+=("$skill_id")
done < <(awk '/^[[:space:]]*-[[:space:]]*id:/ { print $3 }' "$SKILLS_FILE")
if [[ "${#ALL_SKILLS[@]}" -eq 0 ]]; then
  echo "No skills found in $SKILLS_FILE" >&2
  exit 1
fi

# Determine which skills to install
SKILL_ARG="${2:-all}"
if [[ "$SKILL_ARG" == "all" ]]; then
  SKILLS=("${ALL_SKILLS[@]}")
else
  # Validate skill name
  FOUND=false
  for s in "${ALL_SKILLS[@]}"; do
    if [[ "$s" == "$SKILL_ARG" ]]; then
      FOUND=true
      break
    fi
  done
  if [[ "$FOUND" == false ]]; then
    echo "Unknown skill: $SKILL_ARG" >&2
    echo "Available skills: ${ALL_SKILLS[*]}" >&2
    exit 1
  fi
  SKILLS=("$SKILL_ARG")
fi

# Verify each skill directory exists
for SKILL in "${SKILLS[@]}"; do
  SKILL_DIR="$REPO_DIR/$SKILL"
  if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
    echo "Cannot find $SKILL_DIR/SKILL.md" >&2
    exit 1
  fi
done

TARGET="${1:-user-agents}"

install_skills() {
  local dest_base="$1"
  for SKILL in "${SKILLS[@]}"; do
    local src="$REPO_DIR/$SKILL"
    local dest="$dest_base/$SKILL"
    rm -rf "$dest"
    mkdir -p "$dest"
    cp -R "$src/." "$dest/"
    find "$dest" -type f -name ".DS_Store" -delete
    echo "  Installed $SKILL -> $dest"
  done
}

case "$TARGET" in
  openclaw)
    dest="$HOME/.openclaw/skills"
    mkdir -p "$dest"
    install_skills "$dest"
    ;;
  claude)
    dest="$HOME/.claude/skills"
    mkdir -p "$dest"
    install_skills "$dest"
    ;;
  user-agents)
    dest="$HOME/.agents/skills"
    mkdir -p "$dest"
    install_skills "$dest"
    ;;
  project-agents)
    dest=".agents/skills"
    mkdir -p "$dest"
    install_skills "$dest"
    ;;
  project-claude)
    dest=".claude/skills"
    mkdir -p "$dest"
    install_skills "$dest"
    ;;
  workspace-skills)
    dest="skills"
    mkdir -p "$dest"
    install_skills "$dest"
    ;;
  *)
    echo "Usage: ./install.sh [target] [skill]" >&2
    echo "" >&2
    echo "Targets:" >&2
    echo "  openclaw         Install to ~/.openclaw/skills/" >&2
    echo "  claude           Install to ~/.claude/skills/" >&2
    echo "  user-agents      Install to ~/.agents/skills/ (default)" >&2
    echo "  project-agents   Install to .agents/skills/" >&2
    echo "  project-claude   Install to .claude/skills/" >&2
    echo "  workspace-skills Install to skills/" >&2
    echo "" >&2
    echo "Skills (default: all):" >&2
    echo "  all                              Install all skills" >&2
    for s in "${ALL_SKILLS[@]}"; do
      echo "  $s" >&2
    done
    exit 1
    ;;
esac
