#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
INSTALL="$SCRIPT_DIR/install.sh"
UNINSTALL="$SCRIPT_DIR/uninstall.sh"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

fail() {
  echo "test failed: $*" >&2
  exit 1
}

CLAUDE_TARGET="$TMP/claude-project"
CODEX_TARGET="$TMP/codex-project"
SYMLINK_TARGET="$TMP/symlink-project"
ENTRY_LINK_TARGET="$TMP/entry-link-project"
mkdir -p "$CLAUDE_TARGET" "$CODEX_TARGET" "$SYMLINK_TARGET" "$ENTRY_LINK_TARGET"

# Fresh Claude install creates a managed entry and privacy-safe metadata.
bash "$INSTALL" --adapter claude-code --target "$CLAUDE_TARGET" >/dev/null
[[ -f "$CLAUDE_TARGET/CLAUDE.md" ]]
grep -q '^<!-- ai-agent-architecture-managed -->$' "$CLAUDE_TARGET/CLAUDE.md"
[[ -f "$CLAUDE_TARGET/.ai-agent-architecture/agents/coordinator.md" ]]
[[ -f "$CLAUDE_TARGET/.ai-agent-architecture/skills/task-contract/SKILL.md" ]]
grep -q '^project=ai-agent-architecture$' "$CLAUDE_TARGET/.ai-agent-architecture/INSTALL-METADATA"
! grep -q 'installed_from=' "$CLAUDE_TARGET/.ai-agent-architecture/INSTALL-METADATA"
! grep -q "$TMP" "$CLAUDE_TARGET/.ai-agent-architecture/INSTALL-METADATA"

# Reinstall may update an unmodified managed entry without creating an integration file.
bash "$INSTALL" --adapter claude-code --target "$CLAUDE_TARGET" >/dev/null
[[ ! -e "$CLAUDE_TARGET/.ai-agent-architecture/CLAUDE.integration.md" ]]

# A user-modified managed entry must be preserved on update and uninstall.
printf '\n# local customization\n' >> "$CLAUDE_TARGET/CLAUDE.md"
bash "$INSTALL" --adapter claude-code --target "$CLAUDE_TARGET" >/dev/null
grep -q '^# local customization$' "$CLAUDE_TARGET/CLAUDE.md"
[[ -f "$CLAUDE_TARGET/.ai-agent-architecture/CLAUDE.integration.md" ]]
bash "$UNINSTALL" --target "$CLAUDE_TARGET" >/dev/null
[[ ! -e "$CLAUDE_TARGET/.ai-agent-architecture" ]]
[[ -f "$CLAUDE_TARGET/CLAUDE.md" ]]
grep -q '^# local customization$' "$CLAUDE_TARGET/CLAUDE.md"

# Existing Codex instructions are never overwritten or removed.
printf '%s\n' '# existing user instructions' > "$CODEX_TARGET/AGENTS.md"
bash "$INSTALL" --adapter codex --target "$CODEX_TARGET" >/dev/null
grep -q '^# existing user instructions$' "$CODEX_TARGET/AGENTS.md"
[[ -f "$CODEX_TARGET/.ai-agent-architecture/AGENTS.integration.md" ]]
[[ -f "$CODEX_TARGET/.ai-agent-architecture/agents/reviewer.md" ]]
bash "$UNINSTALL" --target "$CODEX_TARGET" >/dev/null
[[ -f "$CODEX_TARGET/AGENTS.md" ]]
grep -q '^# existing user instructions$' "$CODEX_TARGET/AGENTS.md"
[[ ! -e "$CODEX_TARGET/.ai-agent-architecture" ]]

# Refuse a managed namespace symlink so writes cannot escape the target repository.
EXTERNAL_DEST="$TMP/external-destination"
mkdir -p "$EXTERNAL_DEST"
printf '%s\n' 'do-not-touch' > "$EXTERNAL_DEST/sentinel"
ln -s "$EXTERNAL_DEST" "$SYMLINK_TARGET/.ai-agent-architecture"
if bash "$INSTALL" --adapter codex --target "$SYMLINK_TARGET" >/dev/null 2>&1; then
  fail "installer accepted .ai-agent-architecture symlink"
fi
grep -q '^do-not-touch$' "$EXTERNAL_DEST/sentinel"
[[ ! -e "$EXTERNAL_DEST/agents" ]]

# Preserve a symlinked entry file and provide an integration template instead.
ENTRY_EXTERNAL="$TMP/external-agents.md"
printf '%s\n' '# external instructions' > "$ENTRY_EXTERNAL"
ln -s "$ENTRY_EXTERNAL" "$ENTRY_LINK_TARGET/AGENTS.md"
bash "$INSTALL" --adapter codex --target "$ENTRY_LINK_TARGET" >/dev/null
grep -q '^# external instructions$' "$ENTRY_EXTERNAL"
[[ -L "$ENTRY_LINK_TARGET/AGENTS.md" ]]
[[ -f "$ENTRY_LINK_TARGET/.ai-agent-architecture/AGENTS.integration.md" ]]
bash "$UNINSTALL" --target "$ENTRY_LINK_TARGET" >/dev/null
[[ -L "$ENTRY_LINK_TARGET/AGENTS.md" ]]
grep -q '^# external instructions$' "$ENTRY_EXTERNAL"

# Missing option values must fail cleanly.
if bash "$INSTALL" --adapter >/dev/null 2>&1; then
  fail "installer accepted missing --adapter value"
fi
if bash "$UNINSTALL" --target >/dev/null 2>&1; then
  fail "uninstaller accepted missing --target value"
fi

echo "install tests passed"
