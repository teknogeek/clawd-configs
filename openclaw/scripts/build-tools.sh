#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="$REPO_ROOT/openclaw/TOOLS.md"

cat > "$OUT" <<'HDR'
# TOOLS.md - Local Notes (Generated)

> This file is generated from detailed docs in `openclaw/*.md`.
> Source-of-truth is the split files, not this compiled output.

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

---
HDR

for src in \
  "$REPO_ROOT/openclaw/obsidian-notes.md" \
  "$REPO_ROOT/openclaw/media-selection-policy.md" \
  "$REPO_ROOT/openclaw/github-auth.md" \
  "$REPO_ROOT/openclaw/onepassword-secrets.md" \
  "$REPO_ROOT/openclaw/sandbox-runtime.md"
do
  if [[ -f "$src" ]]; then
    printf "\n\n" >> "$OUT"
    cat "$src" >> "$OUT"
  fi
done

echo "Built $OUT"
