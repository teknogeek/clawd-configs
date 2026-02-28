#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
WS_ROOT="/home/clawd/.openclaw/workspace"
cp "$WS_ROOT/TOOLS.md" "$REPO_ROOT/workspace/TOOLS.md"
cd "$REPO_ROOT"
git add workspace/TOOLS.md
if ! git diff --cached --quiet; then
  git commit -m "workspace: sync TOOLS.md index from live workspace"
  git push
  echo "Pushed TOOLS.md index"
else
  echo "No TOOLS.md changes to push"
fi
