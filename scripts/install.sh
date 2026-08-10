#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  bash scripts/install.sh --adapter <claude-code|codex> [--target <path>]
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

ADAPTER=""
TARGET="."

while [[ $# -gt 0 ]]; do
  case "$1" in
    --adapter)
      require_value "$1" "${2:-}"
      ADAPTER="$2"
      shift 2
      ;;
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

case "$ADAPTER" in
  claude-code)
    ENTRY_NAME="CLAUDE.md"
    ;;
  codex)
    ENTRY_NAME="AGENTS.md"
    ;;
  *)
    echo "--adapter must be claude-code or codex" >&2
    exit 2
    ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TARGET_ABS="$(cd "$TARGET" 2>/dev/null && pwd -P)" || {
  echo "Target directory does not exist: $TARGET" >&2
  exit 2
}
DEST="$TARGET_ABS/.ai-agent-architecture"
ENTRY_SOURCE="$REPO_ROOT/adapters/$ADAPTER/$ENTRY_NAME"
ENTRY_TARGET="$TARGET_ABS/$ENTRY_NAME"
INTEGRATION_TARGET="$DEST/${ENTRY_NAME%.md}.integration.md"
PREVIOUS_ENTRY="$DEST/adapter/$ENTRY_NAME"
METADATA="$DEST/INSTALL-METADATA"

if [[ -L "$DEST" ]]; then
  echo "Refusing to install: .ai-agent-architecture is a symbolic link" >&2
  exit 3
fi
if [[ -e "$DEST" && ! -d "$DEST" ]]; then
  echo "Refusing to install: .ai-agent-architecture exists and is not a directory" >&2
  exit 3
fi
if [[ -L "$METADATA" ]]; then
  echo "Refusing to install: INSTALL-METADATA is a symbolic link" >&2
  exit 3
fi

if [[ -f "$METADATA" ]]; then
  EXISTING_ADAPTER="$(sed -n 's/^adapter=//p' "$METADATA" | head -n 1)"
  if [[ -n "$EXISTING_ADAPTER" && "$EXISTING_ADAPTER" != "$ADAPTER" ]]; then
    echo "Existing installation uses adapter: $EXISTING_ADAPTER" >&2
    echo "Run scripts/uninstall.sh before switching to adapter: $ADAPTER" >&2
    exit 4
  fi
fi

ENTRY_IS_UNMODIFIED_MANAGED=false
if [[ -f "$ENTRY_TARGET" && ! -L "$ENTRY_TARGET" && -f "$PREVIOUS_ENTRY" && ! -L "$PREVIOUS_ENTRY" ]]; then
  if grep -q '^<!-- ai-agent-architecture-managed -->$' "$ENTRY_TARGET" && cmp -s "$ENTRY_TARGET" "$PREVIOUS_ENTRY"; then
    ENTRY_IS_UNMODIFIED_MANAGED=true
  fi
fi

mkdir -p "$DEST"
rm -rf "$DEST/agents" "$DEST/skills" "$DEST/docs" "$DEST/adapter"
rm -f "$DEST/PRIVACY.md" "$DEST/LICENSE" "$METADATA" "$INTEGRATION_TARGET"

cp -R "$REPO_ROOT/agents" "$DEST/agents"
cp -R "$REPO_ROOT/skills" "$DEST/skills"
mkdir -p "$DEST/docs"
cp -R "$REPO_ROOT/docs/architecture" "$DEST/docs/architecture"
cp -R "$REPO_ROOT/docs/governance" "$DEST/docs/governance"
cp -R "$REPO_ROOT/adapters/$ADAPTER" "$DEST/adapter"
cp "$REPO_ROOT/PRIVACY.md" "$DEST/PRIVACY.md"
cp "$REPO_ROOT/LICENSE" "$DEST/LICENSE"

if [[ ! -e "$ENTRY_TARGET" && ! -L "$ENTRY_TARGET" ]]; then
  cp "$ENTRY_SOURCE" "$ENTRY_TARGET"
  echo "Created $ENTRY_NAME"
elif [[ "$ENTRY_IS_UNMODIFIED_MANAGED" == true ]]; then
  cp "$ENTRY_SOURCE" "$ENTRY_TARGET"
  echo "Updated unmodified managed $ENTRY_NAME"
else
  cp "$ENTRY_SOURCE" "$INTEGRATION_TARGET"
  echo "Preserved existing or modified $ENTRY_NAME"
  echo "Integration template: ${INTEGRATION_TARGET#$TARGET_ABS/}"
fi

cat > "$METADATA" <<META
project=ai-agent-architecture
schema_version=1
adapter=$ADAPTER
META

echo "Installed public AI Agent Architecture into ${DEST#$TARGET_ABS/}"
