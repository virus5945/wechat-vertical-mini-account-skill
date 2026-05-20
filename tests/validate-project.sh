#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_FILE="$ROOT_DIR/skills.yaml"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

[[ -f "$SKILLS_FILE" ]] || fail "Missing skills.yaml"

skill_dirs=()
while IFS= read -r skill_id; do
  skill_dirs+=("$skill_id")
done < <(awk '/^[[:space:]]*-[[:space:]]*id:/ { print $3 }' "$SKILLS_FILE")
[[ "${#skill_dirs[@]}" -gt 0 ]] || fail "skills.yaml does not define any skill ids"

expected_skill_list="$(printf "%s\n" "${skill_dirs[@]}" | sort)"
actual_skill_list="$(find "$ROOT_DIR" -mindepth 2 -maxdepth 2 -name SKILL.md -print | sed "s#$ROOT_DIR/##; s#/SKILL.md##" | sort)"
[[ "$actual_skill_list" == "$expected_skill_list" ]] || fail "Skill directories do not match skills.yaml"

for skill in "${skill_dirs[@]}"; do
  [[ -f "$ROOT_DIR/$skill/SKILL.md" ]] || fail "Missing $skill/SKILL.md"

  frontmatter="$(
    awk '
      /^---$/ { block += 1; print; if (block == 2) exit; next }
      block == 1 { print }
    ' "$ROOT_DIR/$skill/SKILL.md"
  )"
  [[ "${#frontmatter}" -le 1024 ]] || fail "$skill frontmatter exceeds 1024 characters"

  name="$(
    awk '
      /^---$/ { block += 1; next }
      block == 1 && /^name:/ {
        sub(/^name:[[:space:]]*/, "")
        print
        exit
      }
    ' "$ROOT_DIR/$skill/SKILL.md"
  )"
  [[ "$name" == "$skill" ]] || fail "$skill frontmatter name does not match directory"
  [[ "$name" =~ ^[a-z0-9-]+$ ]] || fail "$skill name must use lowercase letters, numbers, and hyphens"

  description="$(
    awk '
      /^---$/ { block += 1; next }
      block == 1 && /^description:/ {
        sub(/^description:[[:space:]]*/, "")
        print
        exit
      }
    ' "$ROOT_DIR/$skill/SKILL.md"
  )"

  [[ "$description" == Use\ when* ]] || fail "$skill description must start with \"Use when\""
done

for required_doc in "$ROOT_DIR/tests/scenarios.md" "$ROOT_DIR/RELEASE.md"; do
  [[ -f "$required_doc" ]] || fail "Missing ${required_doc#$ROOT_DIR/}"
done

for forbidden in "科技""阿维" "蓝得""一见" "keji""-avi" "blue""-de-yijian"; do
  if find "$ROOT_DIR" -path "$ROOT_DIR/.git" -prune -o -print | grep -F "$forbidden" >/dev/null; then
    fail "Forbidden legacy name appears in a path: $forbidden"
  fi
  if grep -RIn --exclude-dir=.git -- "$forbidden" "$ROOT_DIR" >/dev/null; then
    fail "Forbidden legacy name appears in file contents: $forbidden"
  fi
done

for risky in "必""赚" "保""证有效" "全网""最低" "100%""有效"; do
  if grep -RIn --exclude-dir=.git -- "$risky" "$ROOT_DIR" >/dev/null; then
    fail "Unsupported absolute claim appears: $risky"
  fi
done

while IFS= read -r ds_store; do
  fail "Unexpected .DS_Store file: $ds_store"
done < <(find "$ROOT_DIR" -path "$ROOT_DIR/.git" -prune -o -name .DS_Store -print)

bash -n "$ROOT_DIR/install.sh"
help_output="$("$ROOT_DIR/install.sh" invalid-target 2>&1 || true)"
for skill in "${skill_dirs[@]}"; do
  grep -F "$skill" <<<"$help_output" >/dev/null || fail "Installer help does not list $skill"
done

tmp_home="$(mktemp -d)"
last_skill_index=$((${#skill_dirs[@]} - 1))
last_skill="${skill_dirs[$last_skill_index]}"
temp_ds_store="$ROOT_DIR/$last_skill/.DS_Store"
trap 'rm -rf "$tmp_home"; rm -f "$temp_ds_store"' EXIT

touch "$temp_ds_store"

HOME="$tmp_home" "$ROOT_DIR/install.sh" user-agents "$last_skill" >/dev/null
installed="$tmp_home/.agents/skills/$last_skill"

[[ -f "$installed/SKILL.md" ]] || fail "Installer did not copy SKILL.md"
[[ ! -e "$installed/.DS_Store" ]] || fail "Installer copied .DS_Store into installed skill"

HOME="$tmp_home" "$ROOT_DIR/install.sh" user-agents >/dev/null
for skill in "${skill_dirs[@]}"; do
  [[ -f "$tmp_home/.agents/skills/$skill/SKILL.md" ]] || fail "Installer did not copy $skill"
done

echo "Validation passed"
