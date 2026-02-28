#!/usr/bin/env bash
set -euo pipefail

# Thin wrapper around canonical shell helpers.
# Usage: github-profile.sh {ro|pr|off}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/shell/github-token-profiles.sh"

mode="${1:-}"
case "$mode" in
  ro)  gh-ro ;;
  pr|rw) gh-pr ;;
  off) gh-off ;;
  *)
    echo "Usage: $0 {ro|pr|off}" >&2
    exit 1
    ;;
esac
