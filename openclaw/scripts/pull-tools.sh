#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
WS_ROOT="/home/clawd/.openclaw/workspace"
SRC="$REPO_ROOT/openclaw/TOOLS.md"
DST="$WS_ROOT/TOOLS.md"
if [[ ! -f "$SRC" ]]; then
  echo "missing source: $SRC" >&2
  exit 1
fi
cp "$SRC" "$DST"
echo "Pulled TOOLS.md -> workspace"
