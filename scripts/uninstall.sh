#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  bash scripts/uninstall.sh [--target <path>]
USAGE
}

TARGET="."
while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:-}"
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

TARGET_ABS="$(cd "$TARGET" 2>/dev/null && pwd)" || {
  echo "Target directory does not exist: $TARGET" >&2
  exit 2
}
DEST="$TARGET_ABS/.ai-agent-architecture"

for entry in CLAUDE.md AGENTS.md; do
  path="$TARGET_ABS/$entry"
  if [[ -f "$path" ]] && grep -q '^<!-- ai-agent-architecture-managed -->$' "$path"; then
    rm -f "$path"
    echo "Removed managed $entry"
  fi
done

if [[ -d "$DEST" ]]; then
  rm -rf "$DEST"
  echo "Removed .ai-agent-architecture/"
else
  echo "No .ai-agent-architecture/ directory found"
fi
