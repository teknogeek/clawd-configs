#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
WS_ROOT="/home/clawd/.openclaw/workspace"
cp "$WS_ROOT/TOOLS.md" "$REPO_ROOT/openclaw/TOOLS.md"
cd "$REPO_ROOT"
git add openclaw/TOOLS.md
if ! git diff --cached --quiet; then
  git commit -m "openclaw: sync TOOLS.md index from workspace"
  git push
  echo "Pushed TOOLS.md index"
else
  echo "No TOOLS.md changes to push"
fi
