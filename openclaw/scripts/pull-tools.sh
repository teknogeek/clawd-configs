#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
WS_ROOT="/home/clawd/.openclaw/workspace"
# Always rebuild before pulling
"$REPO_ROOT/openclaw/scripts/build-tools.sh"
cp "$REPO_ROOT/openclaw/TOOLS.md" "$WS_ROOT/TOOLS.md"
echo "Pulled generated TOOLS.md -> workspace"
