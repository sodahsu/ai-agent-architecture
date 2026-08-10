#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

cd "$REPO_ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "history privacy check skipped: no git worktree"
  exit 0
fi

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

# Omit commit metadata so author e-mail addresses do not create false positives.
git log --all --format= --no-ext-diff -p -- . > "$TMP"

FAILED=0

report_matches() {
  local label="$1"
  local matches="$2"
  if [[ -n "$matches" ]]; then
    echo "history privacy check failed: $label" >&2
    echo "$matches" >&2
    FAILED=1
  fi
}

EMAIL_MATCHES="$(grep -En '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$TMP" 2>/dev/null | grep -v 'user@example\.com' || true)"
report_matches "unexpected email address in git history" "$EMAIL_MATCHES"

HOME_PATH_MATCHES="$(grep -En '/(Users|home)/[A-Za-z0-9._-]+/' "$TMP" 2>/dev/null || true)"
report_matches "concrete home directory path in git history" "$HOME_PATH_MATCHES"

WINDOWS_HOME_MATCHES="$(grep -En '[A-Za-z]:\\Users\\[A-Za-z0-9._-]+\\' "$TMP" 2>/dev/null || true)"
report_matches "concrete Windows home directory path in git history" "$WINDOWS_HOME_MATCHES"

TOKEN_MATCHES="$(grep -En '(gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}|AIza[0-9A-Za-z_-]{20,})' "$TMP" 2>/dev/null || true)"
report_matches "credential-like token in git history" "$TOKEN_MATCHES"

PRIVATE_KEY_MATCHES="$(grep -En -- '-----BEGIN ([A-Z ]+ )?PRIVATE KEY-----' "$TMP" 2>/dev/null || true)"
report_matches "private key material in git history" "$PRIVATE_KEY_MATCHES"

if [[ "$FAILED" -ne 0 ]]; then
  exit 1
fi

echo "history privacy checks passed"
