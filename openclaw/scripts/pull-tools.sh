#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
WS_ROOT="/home/clawd/.openclaw/workspace"
cp "$REPO_ROOT/openclaw/TOOLS.md" "$WS_ROOT/TOOLS.md"
echo "Pulled TOOLS.md -> workspace"
