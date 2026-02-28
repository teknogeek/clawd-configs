# TOOLS.md - Local Notes Index

This file is a lightweight index. Detailed operational docs live under `tools/`.

## Notes Repo Workflow

- Obsidian/notes vault repo: `/home/clawd/.openclaw/workspace/vaults/notes`
- Before any read/write note operation, sync first:
  - `git -C /home/clawd/.openclaw/workspace/vaults/notes pull --rebase --autostash`
- After note changes, commit and push immediately to reduce conflicts.

Details: `tools/obsidian-notes.md`

## Media Automation Preferences

- Default movie target quality: 1080p (`HD-1080p` profile in Radarr) unless explicitly requested otherwise.
- Manual search selection policy is documented in:
  - `tools/media-selection-policy.md`

## GitHub Access Workflow

- Default mode: read-only token profile.
- Escalate to write profile only on explicit write/PR tasks.
- Helper script source of truth:
  - `tools/scripts/shell/github-token-profiles.sh`
- Wrapper CLI:
  - `tools/scripts/github-profile.sh {ro|pr|off}`

Details: `tools/github-auth.md`

## 1Password Secret Handling

- Use 1Password vault `Clawd` for secrets; avoid sending raw secrets in chat.

Details: `tools/onepassword-secrets.md`

## Sandbox Runtime

Details: `tools/sandbox-runtime.md`

---

Source of truth for workspace ops docs is `workspace/tools/*`.
