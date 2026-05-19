#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/wechat-vertical-mini-account"

if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
  echo "Cannot find $SKILL_DIR/SKILL.md" >&2
  exit 1
fi

TARGET="${1:-user-agents}"

case "$TARGET" in
  openclaw)
    mkdir -p "$HOME/.openclaw/skills"
    rm -rf "$HOME/.openclaw/skills/wechat-vertical-mini-account"
    cp -R "$SKILL_DIR" "$HOME/.openclaw/skills/"
    echo "Installed to ~/.openclaw/skills/wechat-vertical-mini-account"
    ;;
  claude)
    mkdir -p "$HOME/.claude/skills"
    rm -rf "$HOME/.claude/skills/wechat-vertical-mini-account"
    cp -R "$SKILL_DIR" "$HOME/.claude/skills/"
    echo "Installed to ~/.claude/skills/wechat-vertical-mini-account"
    ;;
  user-agents)
    mkdir -p "$HOME/.agents/skills"
    rm -rf "$HOME/.agents/skills/wechat-vertical-mini-account"
    cp -R "$SKILL_DIR" "$HOME/.agents/skills/"
    echo "Installed to ~/.agents/skills/wechat-vertical-mini-account"
    ;;
  project-agents)
    mkdir -p ".agents/skills"
    rm -rf ".agents/skills/wechat-vertical-mini-account"
    cp -R "$SKILL_DIR" ".agents/skills/"
    echo "Installed to .agents/skills/wechat-vertical-mini-account"
    ;;
  project-claude)
    mkdir -p ".claude/skills"
    rm -rf ".claude/skills/wechat-vertical-mini-account"
    cp -R "$SKILL_DIR" ".claude/skills/"
    echo "Installed to .claude/skills/wechat-vertical-mini-account"
    ;;
  workspace-skills)
    mkdir -p "skills"
    rm -rf "skills/wechat-vertical-mini-account"
    cp -R "$SKILL_DIR" "skills/"
    echo "Installed to skills/wechat-vertical-mini-account"
    ;;
  *)
    echo "Usage: ./install.sh [openclaw|claude|user-agents|project-agents|project-claude|workspace-skills]" >&2
    exit 1
    ;;
esac
