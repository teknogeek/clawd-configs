#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# Build generated TOOLS.md from split docs
"$REPO_ROOT/openclaw/scripts/build-tools.sh"
cd "$REPO_ROOT"
git add openclaw/*.md openclaw/scripts/*.sh
if ! git diff --cached --quiet; then
  git commit -m "openclaw: rebuild generated TOOLS.md from split docs"
  git push
  echo "Pushed split docs + generated TOOLS.md"
else
  echo "No changes to push"
fi
