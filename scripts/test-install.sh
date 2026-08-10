#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL="$SCRIPT_DIR/install.sh"
UNINSTALL="$SCRIPT_DIR/uninstall.sh"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

CLAUDE_TARGET="$TMP/claude-project"
CODEX_TARGET="$TMP/codex-project"
mkdir -p "$CLAUDE_TARGET" "$CODEX_TARGET"

bash "$INSTALL" --adapter claude-code --target "$CLAUDE_TARGET" >/dev/null
[[ -f "$CLAUDE_TARGET/CLAUDE.md" ]]
grep -q '^<!-- ai-agent-architecture-managed -->$' "$CLAUDE_TARGET/CLAUDE.md"
[[ -f "$CLAUDE_TARGET/.ai-agent-architecture/agents/coordinator.md" ]]
[[ -f "$CLAUDE_TARGET/.ai-agent-architecture/skills/task-contract/SKILL.md" ]]
bash "$UNINSTALL" --target "$CLAUDE_TARGET" >/dev/null
[[ ! -e "$CLAUDE_TARGET/.ai-agent-architecture" ]]
[[ ! -e "$CLAUDE_TARGET/CLAUDE.md" ]]

printf '%s\n' '# existing user instructions' > "$CODEX_TARGET/AGENTS.md"
bash "$INSTALL" --adapter codex --target "$CODEX_TARGET" >/dev/null
grep -q '^# existing user instructions$' "$CODEX_TARGET/AGENTS.md"
[[ -f "$CODEX_TARGET/.ai-agent-architecture/AGENTS.integration.md" ]]
[[ -f "$CODEX_TARGET/.ai-agent-architecture/agents/reviewer.md" ]]
bash "$UNINSTALL" --target "$CODEX_TARGET" >/dev/null
[[ -f "$CODEX_TARGET/AGENTS.md" ]]
grep -q '^# existing user instructions$' "$CODEX_TARGET/AGENTS.md"
[[ ! -e "$CODEX_TARGET/.ai-agent-architecture" ]]

echo "install tests passed"
