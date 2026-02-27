#!/usr/bin/env bash
# GitHub token profile helpers for local shell use.
# Requires: op CLI + OP_REF_GH_TOKEN_RO / OP_REF_GH_TOKEN_PR

gh-ro() {
  if ! command -v op >/dev/null 2>&1; then
    echo "[gh] op CLI not found"; return 1
  fi
  if [[ -z "${OP_REF_GH_TOKEN_RO:-}" ]]; then
    echo "[gh] OP_REF_GH_TOKEN_RO is not set"; return 1
  fi
  unset GH_TOKEN GITHUB_TOKEN
  export GH_TOKEN="$(op read "$OP_REF_GH_TOKEN_RO")"
  export GITHUB_TOKEN="$GH_TOKEN"
  export GH_TOKEN_PROFILE="ro"
  echo "[gh] profile=RO"
  gh auth status || true
}

gh-pr() {
  if ! command -v op >/dev/null 2>&1; then
    echo "[gh] op CLI not found"; return 1
  fi
  if [[ -z "${OP_REF_GH_TOKEN_PR:-}" ]]; then
    echo "[gh] OP_REF_GH_TOKEN_PR is not set"; return 1
  fi
  unset GH_TOKEN GITHUB_TOKEN
  export GH_TOKEN="$(op read "$OP_REF_GH_TOKEN_PR")"
  export GITHUB_TOKEN="$GH_TOKEN"
  export GH_TOKEN_PROFILE="pr"
  echo "[gh] profile=PR"
  gh auth status || true
}

gh-off() {
  unset GH_TOKEN GITHUB_TOKEN GH_TOKEN_PROFILE
  echo "[gh] tokens cleared from env"
}

# safer wrapper: blocks accidental write-ish ops unless in PR profile
# Set GH_SAFE_WRITE_ALLOW=1 to bypass for a single command.
gh-safe() {
  local cmd="${1:-}"
  shift || true
  case "$cmd" in
    pr|issue|release|repo|api|workflow|run|secret|variable|label)
      if [[ "${GH_TOKEN_PROFILE:-ro}" != "pr" && "${GH_SAFE_WRITE_ALLOW:-0}" != "1" ]]; then
        echo "[gh-safe] blocked potentially write-capable command in RO profile. Use gh-pr first."
        return 2
      fi
      ;;
  esac
  gh "$cmd" "$@"
}
