#!/usr/bin/env bash
set -euo pipefail

# GitHub profile helper (RO/PR/OFF) using 1Password refs.
# Requires: OP_SERVICE_ACCOUNT_TOKEN + op + gh.

mode="${1:-}"

OP_REF_GH_TOKEN_RO="${OP_REF_GH_TOKEN_RO:-op://Clawd/wb5h3iksiy6kvl4yqujwxozxke/token}"
OP_REF_GH_TOKEN_PR="${OP_REF_GH_TOKEN_PR:-op://Clawd/d2viyad6bwxv2gjvgat2ao73xu/token}"

use_token() {
  local ref="$1"
  local tok
  tok="$(op read "$ref")"
  printf '%s' "$tok" | gh auth login --hostname github.com --with-token
  gh auth setup-git >/dev/null
  echo "GitHub auth active via ref: $ref"
}

case "$mode" in
  ro)
    use_token "$OP_REF_GH_TOKEN_RO"
    ;;
  pr|rw)
    use_token "$OP_REF_GH_TOKEN_PR"
    ;;
  off)
    gh auth logout -h github.com -u >/dev/null 2>&1 || true
    echo "GitHub auth cleared"
    ;;
  *)
    echo "Usage: $0 {ro|pr|off}" >&2
    exit 1
    ;;
esac
