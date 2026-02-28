# TOOLS.md - Local Notes Index

This file is a lightweight index. Detailed operational docs live in split files under `openclaw/`.

## Notes Repo Workflow

- Obsidian/notes vault repo: `/home/clawd/.openclaw/workspace/vaults/notes`
- Before any read/write note operation, sync first:
  - `git -C /home/clawd/.openclaw/workspace/vaults/notes pull --rebase --autostash`
- After note changes, commit and push immediately to reduce conflicts.

Details: `openclaw/obsidian-notes.md`

## Media Automation Preferences

- Default movie target quality: 1080p (`HD-1080p` profile in Radarr) unless explicitly requested otherwise.
- Manual search selection policy is documented in:
  - `openclaw/media-selection-policy.md`

## GitHub Access Workflow

- Default mode: read-only token profile.
- Escalate to write profile only on explicit write/PR tasks.
- Helper script source of truth:
  - `openclaw/scripts/shell/github-token-profiles.sh`
- Wrapper CLI:
  - `openclaw/scripts/github-profile.sh {ro|pr|off}`

Details: `openclaw/github-auth.md`

## 1Password Secret Handling

- Use 1Password vault `Clawd` for secrets; avoid sending raw secrets in chat.

Details: `openclaw/onepassword-secrets.md`

## Sandbox Runtime

Details: `openclaw/sandbox-runtime.md`

---

Source of truth for OpenClaw ops docs is this repo (`clawd-configs/openclaw/*`).
