#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  bash scripts/uninstall.sh [--target <path>]
USAGE
}

require_value() {
  local option="$1"
  local value="${2:-}"
  if [[ -z "$value" ]]; then
    echo "$option requires a value" >&2
    usage >&2
    exit 2
  fi
}

TARGET="."
while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      require_value "$1" "${2:-}"
      TARGET="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

TARGET_ABS="$(cd "$TARGET" 2>/dev/null && pwd -P)" || {
  echo "Target directory does not exist: $TARGET" >&2
  exit 2
}
DEST="$TARGET_ABS/.ai-agent-architecture"

if [[ -L "$DEST" ]]; then
  echo "Refusing to uninstall: .ai-agent-architecture is a symbolic link" >&2
  exit 3
fi
if [[ -e "$DEST" && ! -d "$DEST" ]]; then
  echo "Refusing to uninstall: .ai-agent-architecture is not a directory" >&2
  exit 3
fi
if [[ ! -d "$DEST" ]]; then
  echo "No managed .ai-agent-architecture/ directory found"
  exit 0
fi

for entry in CLAUDE.md AGENTS.md; do
  path="$TARGET_ABS/$entry"
  installed="$DEST/adapter/$entry"

  if [[ -f "$path" && ! -L "$path" && -f "$installed" && ! -L "$installed" ]]; then
    if grep -q '^<!-- ai-agent-architecture-managed -->$' "$path" && cmp -s "$path" "$installed"; then
      rm -f "$path"
      echo "Removed unmodified managed $entry"
    elif grep -q '^<!-- ai-agent-architecture-managed -->$' "$path"; then
      echo "Preserved modified managed $entry"
    fi
  fi
done

rm -rf "$DEST"
echo "Removed .ai-agent-architecture/"
