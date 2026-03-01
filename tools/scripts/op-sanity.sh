#!/usr/bin/env bash
set -euo pipefail

# Print non-secret fingerprints (hash + length) for an op:// reference.
# Usage: op-sanity.sh op://Vault/item/field

REF="${1:-}"
if [[ -z "$REF" ]]; then
  echo "usage: $0 op://Vault/item/field" >&2
  exit 2
fi

if ! command -v op >/dev/null 2>&1; then
  echo "op CLI not found" >&2
  exit 127
fi

VAL="$(op read "$REF")"
# Intentionally do not print the secret.
printf "%s" "$VAL" | sha256sum | awk '{print "sha256=" $1}'
printf "%s" "$VAL" | wc -c | awk '{print "len=" $1}'
