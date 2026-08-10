#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

FILES=()
while IFS= read -r -d '' file; do
  FILES+=("$file")
done < <(
  find "$REPO_ROOT" -type f \
    ! -path "$REPO_ROOT/.git/*" \
    ! -path "$REPO_ROOT/scripts/privacy-check.sh" \
    \( -name '*.md' -o -name '*.yaml' -o -name '*.yml' -o -name '*.sh' \) \
    -print0
)

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "privacy check failed: no files found" >&2
  exit 1
fi

FAILED=0

report_matches() {
  local label="$1"
  local matches="$2"
  if [[ -n "$matches" ]]; then
    echo "privacy check failed: $label" >&2
    echo "$matches" >&2
    FAILED=1
  fi
}

EMAIL_MATCHES="$(grep -EnH '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "${FILES[@]}" 2>/dev/null | grep -v 'user@example\.com' || true)"
report_matches "unexpected email address" "$EMAIL_MATCHES"

HOME_PATH_MATCHES="$(grep -EnH '/(Users|home)/[A-Za-z0-9._-]+/' "${FILES[@]}" 2>/dev/null || true)"
report_matches "concrete home directory path" "$HOME_PATH_MATCHES"

WINDOWS_HOME_MATCHES="$(grep -EnH '[A-Za-z]:\\Users\\[A-Za-z0-9._-]+\\' "${FILES[@]}" 2>/dev/null || true)"
report_matches "concrete Windows home directory path" "$WINDOWS_HOME_MATCHES"

TOKEN_MATCHES="$(grep -EnH '(gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}|AIza[0-9A-Za-z_-]{20,})' "${FILES[@]}" 2>/dev/null || true)"
report_matches "credential-like token" "$TOKEN_MATCHES"

PRIVATE_KEY_MATCHES="$(grep -EnH -- '-----BEGIN ([A-Z ]+ )?PRIVATE KEY-----' "${FILES[@]}" 2>/dev/null || true)"
report_matches "private key material" "$PRIVATE_KEY_MATCHES"

INSTALL_PATH_MATCHES="$(grep -EnH 'installed_from=/' "$REPO_ROOT/scripts/install.sh" 2>/dev/null || true)"
report_matches "installer writes a source-machine absolute path" "$INSTALL_PATH_MATCHES"

if [[ "$FAILED" -ne 0 ]]; then
  exit 1
fi

echo "privacy checks passed"
