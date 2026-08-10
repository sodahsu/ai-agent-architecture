#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

cd "$REPO_ROOT"

bash -n scripts/*.sh
bash scripts/test-install.sh
bash scripts/privacy-check.sh
bash scripts/privacy-history-check.sh

REQUIRED_FILES=(
  AGENTS.md
  CONTRIBUTING.md
  LICENSE
  README.md
  INSTALL.md
  PRIVACY.md
  docs/governance/public-capability-catalog.md
  openspec/project.md
  openspec/changes/public-architecture-foundation/proposal.md
  openspec/changes/public-architecture-foundation/tasks.md
  openspec/changes/public-architecture-foundation/specs/public-installation/spec.md
  openspec/changes/public-architecture-foundation/specs/public-capabilities/spec.md
  adapters/claude-code/CLAUDE.md
  adapters/codex/AGENTS.md
)

for file in "${REQUIRED_FILES[@]}"; do
  [[ -f "$file" ]] || {
    echo "check failed: missing required file $file" >&2
    exit 1
  }
done

SKILL_COUNT=0
for skill in skills/*/SKILL.md; do
  [[ -f "$skill" ]] || continue
  SKILL_COUNT=$((SKILL_COUNT + 1))
  for heading in Purpose Inputs Outputs Preconditions Permissions Procedure Validation 'Failure Conditions' 'Completion Criteria'; do
    grep -q "^## $heading$" "$skill" || {
      echo "check failed: $skill missing heading: $heading" >&2
      exit 1
    }
  done
done

AGENT_COUNT=0
for agent in agents/*.md; do
  [[ -f "$agent" ]] || continue
  [[ "$(basename "$agent")" == "README.md" ]] && continue
  AGENT_COUNT=$((AGENT_COUNT + 1))
  for heading in Role Inputs Outputs 'Allowed Actions' 'Forbidden Actions' 'Completion Criteria'; do
    grep -q "^## $heading$" "$agent" || {
      echo "check failed: $agent missing heading: $heading" >&2
      exit 1
    }
  done
done

[[ "$SKILL_COUNT" -gt 0 ]] || {
  echo "check failed: no public skills found" >&2
  exit 1
}

[[ "$AGENT_COUNT" -gt 0 ]] || {
  echo "check failed: no public agents found" >&2
  exit 1
}

grep -q '^<!-- ai-agent-architecture-managed -->$' adapters/claude-code/CLAUDE.md
grep -q '^<!-- ai-agent-architecture-managed -->$' adapters/codex/AGENTS.md
grep -q '\.ai-agent-architecture/agents/README\.md' adapters/claude-code/CLAUDE.md
grep -q '\.ai-agent-architecture/skills/README\.md' adapters/claude-code/CLAUDE.md
grep -q '\.ai-agent-architecture/agents/README\.md' adapters/codex/AGENTS.md
grep -q '\.ai-agent-architecture/skills/README\.md' adapters/codex/AGENTS.md

echo "all checks passed ($AGENT_COUNT agents, $SKILL_COUNT skills)"
