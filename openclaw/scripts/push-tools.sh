#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
WS_ROOT="/home/clawd/.openclaw/workspace"
SRC="$WS_ROOT/TOOLS.md"
DST="$REPO_ROOT/openclaw/TOOLS.md"
if [[ ! -f "$SRC" ]]; then
  echo "missing source: $SRC" >&2
  exit 1
fi
cp "$SRC" "$DST"
cd "$REPO_ROOT"
git add openclaw/TOOLS.md
if ! git diff --cached --quiet; then
  git commit -m "openclaw: sync TOOLS.md from workspace"
  git push
  echo "Pushed TOOLS.md to clawd-configs"
else
  echo "No TOOLS.md changes to push"
fi
