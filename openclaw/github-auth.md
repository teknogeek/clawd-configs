# OpenClaw GitHub Auth & Access

## Current model

- GitHub access uses PATs stored in 1Password vault `Clawd`.
- Default profile is **read-only**.
- Write/PR profile is used only on explicit request.

## 1Password references (non-secret)

- `OP_REF_GH_TOKEN_RO=op://Clawd/wb5h3iksiy6kvl4yqujwxozxke/token`
- `OP_REF_GH_TOKEN_PR=op://Clawd/d2viyad6bwxv2gjvgat2ao73xu/token`

## Bash helper workflow (from local TOOLS.md)

- `gh-ro` → load/auth with read-only token.
- `gh-pr` → load/auth with read-write token for push/PR operations.
- `gh-off` → clear token env/session after write tasks.
- `gh-safe` → wrapper intended to block likely write-capable `gh` commands unless in PR/write profile.

## Rules

- Never store raw PAT values in workspace files.
- Keep RO as default for routine repo access.
- Escalate to R/W only for explicit write scopes (branch push, PR creation, issue edits).
- Return to `gh-off` after write tasks.
- Branch safety baseline: no force-push and no default-branch deletion where supported.
