#!/usr/bin/env bash
# Hotspots Agent Skill installer — copies the local package/ tree to a skills dir.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/package"
TARGET=""
INSTALL_DIR=""
CLAUDE_LINK=0

usage() {
  cat <<'USAGE'
Usage:
  install.sh --target <claude|codex|gemini|copilot|opencode|agents>
  install.sh --dir <path>

Examples:
  bash install.sh --target agents
  bash install.sh --target claude
  bash install.sh --dir "$HOME/.agents/skills/hotspots"
USAGE
}

fail() { echo "[ERR] $*" >&2; exit 1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:-}"; shift 2 || fail "--target needs a value" ;;
    --dir)
      INSTALL_DIR="${2:-}"; shift 2 || fail "--dir needs a value" ;;
    -h|--help)
      usage; exit 0 ;;
    *)
      fail "unknown arg: $1" ;;
  esac
done

if [[ -z "$INSTALL_DIR" && -z "$TARGET" ]]; then
  usage
  exit 1
fi

if [[ -n "$TARGET" && -n "$INSTALL_DIR" ]]; then
  fail "use either --target or --dir, not both"
fi

case "${TARGET}" in
  "" ) ;;
  agents|codex|gemini|copilot|opencode)
    INSTALL_DIR="${HOME}/.agents/skills/hotspots"
    ;;
  claude)
    INSTALL_DIR="${HOME}/.agents/skills/hotspots"
    CLAUDE_LINK=1
    ;;
  *)
    fail "unknown --target: $TARGET"
    ;;
esac

# expand ~
INSTALL_DIR="${INSTALL_DIR/#\~/$HOME}"

[[ -d "$SRC" ]] || fail "missing package dir: $SRC"
[[ -f "$SRC/SKILL.md" ]] || fail "missing $SRC/SKILL.md"

mkdir -p "$(dirname "$INSTALL_DIR")"
TMP="$(mktemp -d "${TMPDIR:-/tmp}/hotspots-skill.XXXXXX")"
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

cp -a "$SRC/." "$TMP/"
# ship LICENSE next to SKILL for agents that look for it
cp -f "$ROOT/LICENSE" "$TMP/LICENSE"

if [[ -e "$INSTALL_DIR" ]]; then
  BACKUP="${INSTALL_DIR}.bak.$(date +%s)"
  mv "$INSTALL_DIR" "$BACKUP"
  echo "Backed up previous install to $BACKUP"
fi

mv "$TMP" "$INSTALL_DIR"
trap - EXIT

if [[ "$CLAUDE_LINK" -eq 1 ]]; then
  mkdir -p "${HOME}/.claude/skills"
  LINK="${HOME}/.claude/skills/hotspots"
  if [[ -L "$LINK" || -e "$LINK" ]]; then
    rm -rf "$LINK"
  fi
  ln -s "$INSTALL_DIR" "$LINK"
  echo "Claude compat link: $LINK -> $INSTALL_DIR"
fi

echo
echo "Installed Hotspots Agent Skill"
echo "  path: $INSTALL_DIR"
echo
echo "Next: restart your Agent or start a new conversation, then ask:"
echo "  出一份今天的热点早报。"
echo
echo "Optional AI section — install official AIHOT skill:"
echo "  bash <(curl -fsSL https://aihot.news/aihot-skill/install.sh) --target agents"
