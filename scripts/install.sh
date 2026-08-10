#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  bash scripts/install.sh --adapter <claude-code|codex> [--target <path>]
USAGE
}

ADAPTER=""
TARGET="."

while [[ $# -gt 0 ]]; do
  case "$1" in
    --adapter)
      ADAPTER="${2:-}"
      shift 2
      ;;
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

if [[ "$ADAPTER" != "claude-code" && "$ADAPTER" != "codex" ]]; then
  echo "--adapter must be claude-code or codex" >&2
  exit 2
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_ABS="$(cd "$TARGET" 2>/dev/null && pwd)" || {
  echo "Target directory does not exist: $TARGET" >&2
  exit 2
}
DEST="$TARGET_ABS/.ai-agent-architecture"

mkdir -p "$DEST"
rm -rf "$DEST/agents" "$DEST/skills" "$DEST/docs" "$DEST/adapter"
cp -R "$REPO_ROOT/agents" "$DEST/agents"
cp -R "$REPO_ROOT/skills" "$DEST/skills"
mkdir -p "$DEST/docs"
cp -R "$REPO_ROOT/docs/architecture" "$DEST/docs/architecture"
cp -R "$REPO_ROOT/docs/governance" "$DEST/docs/governance"
cp -R "$REPO_ROOT/adapters/$ADAPTER" "$DEST/adapter"
cp "$REPO_ROOT/PRIVACY.md" "$DEST/PRIVACY.md"

if [[ "$ADAPTER" == "claude-code" ]]; then
  ENTRY_NAME="CLAUDE.md"
  ENTRY_SOURCE="$REPO_ROOT/adapters/claude-code/CLAUDE.md"
else
  ENTRY_NAME="AGENTS.md"
  ENTRY_SOURCE="$REPO_ROOT/adapters/codex/AGENTS.md"
fi

ENTRY_TARGET="$TARGET_ABS/$ENTRY_NAME"
INTEGRATION_TARGET="$DEST/${ENTRY_NAME%.md}.integration.md"

if [[ ! -e "$ENTRY_TARGET" ]]; then
  cp "$ENTRY_SOURCE" "$ENTRY_TARGET"
  echo "Created $ENTRY_NAME"
elif grep -q '^<!-- ai-agent-architecture-managed -->$' "$ENTRY_TARGET"; then
  cp "$ENTRY_SOURCE" "$ENTRY_TARGET"
  echo "Updated managed $ENTRY_NAME"
else
  cp "$ENTRY_SOURCE" "$INTEGRATION_TARGET"
  echo "Preserved existing $ENTRY_NAME"
  echo "Integration template: ${INTEGRATION_TARGET#$TARGET_ABS/}"
fi

cat > "$DEST/INSTALL-METADATA" <<META
adapter=$ADAPTER
installed_from=$REPO_ROOT
META

echo "Installed public AI Agent Architecture into ${DEST#$TARGET_ABS/}"
