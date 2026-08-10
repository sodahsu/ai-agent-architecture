#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

cd "$REPO_ROOT"

bash -n scripts/*.sh
bash scripts/test-install.sh
bash scripts/privacy-check.sh

REQUIRED_FILES=(
  AGENTS.md
  CONTRIBUTING.md
  README.md
  INSTALL.md
  PRIVACY.md
  openspec/project.md
  openspec/changes/public-architecture-foundation/proposal.md
  openspec/changes/public-architecture-foundation/tasks.md
  openspec/changes/public-architecture-foundation/specs/public-installation/spec.md
  adapters/claude-code/CLAUDE.md
  adapters/codex/AGENTS.md
)

for file in "${REQUIRED_FILES[@]}"; do
  [[ -f "$file" ]] || {
    echo "check failed: missing required file $file" >&2
    exit 1
  }
done

for skill in skills/*/SKILL.md; do
  [[ -f "$skill" ]] || continue
  for heading in Purpose Inputs Outputs Preconditions Permissions Procedure Validation 'Failure Conditions' 'Completion Criteria'; do
    grep -q "^## $heading$" "$skill" || {
      echo "check failed: $skill missing heading: $heading" >&2
      exit 1
    }
  done
done

for agent in agents/coordinator.md agents/implementer.md agents/reviewer.md agents/evaluator.md; do
  for heading in Role Inputs Outputs 'Allowed Actions' 'Forbidden Actions' 'Completion Criteria'; do
    grep -q "^## $heading$" "$agent" || {
      echo "check failed: $agent missing heading: $heading" >&2
      exit 1
    }
  done
done

grep -q '^<!-- ai-agent-architecture-managed -->$' adapters/claude-code/CLAUDE.md
grep -q '^<!-- ai-agent-architecture-managed -->$' adapters/codex/AGENTS.md

echo "all checks passed"
