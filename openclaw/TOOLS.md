# TOOLS.md - Local Notes (Generated)

> This file is generated from detailed docs in `openclaw/*.md`.
> Source-of-truth is the split files, not this compiled output.

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

---


# Obsidian / Notes Headless Workflow

## Vault path

- `/home/clawd/.openclaw/workspace/vaults/notes`

## Sync discipline (required)

1. Before note read/write operations:
   - `git -C /home/clawd/.openclaw/workspace/vaults/notes pull --rebase --autostash`
2. After note writes:
   - commit + push immediately.

## CLI

- Migrated to `notesmd-cli` (rename from `obsidian-cli`).
- Workspace skill override path:
  - `~/.openclaw/workspace/skills/obsidian/SKILL.md`


# Media Selection Policy v1 (Radarr/Sonarr + Tdarr-aware)

## Defaults

- Default movie target quality: 1080p (`HD-1080p`) unless explicitly requested otherwise.
- Add without auto-search; perform manual search/ranking.

## Manual ranking order

1. Best overall quality that fits target profile.
2. Higher seeders.
3. Reasonable size/value (avoid unnecessarily huge releases).

## Preference modifiers

- Tracker preference: TorrentLeech is a plus, but not absolute over clearly better public results.
- Codec preference: x265 is a plus, not required (Tdarr handles re-encoding).
- Audio/source integrity preference: prefer releases with stronger audio/source characteristics (e.g., solid 5.1 and cleaner source chain) over weaker low-bitrate/stereo options when other factors are close.

## Tdarr-aware rules

- Do not blindly pick the smallest file. Prefer better source quality that Tdarr can compress cleanly.
- Penalize tiny high-res encodes that are likely over-compressed for their claimed resolution.


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

## Shell helpers (source of truth)

- Script: `openclaw/scripts/shell/github-token-profiles.sh`
- Provides: `gh-ro`, `gh-pr`, `gh-off`, `gh-safe`
- Recommended `.bashrc` source line:
  - `source /home/clawd/.openclaw/workspace/repos/clawd-configs/openclaw/scripts/shell/github-token-profiles.sh`

## Rules

- Never store raw PAT values in workspace files.
- Keep RO as default for routine repo access.
- Escalate to R/W only for explicit write scopes (branch push, PR creation, issue edits).
- Return to `gh-off` after write tasks.
- Branch safety baseline: no force-push and no default-branch deletion where supported.


# 1Password Secret Handling

## Integration

- OpenClaw runtime uses `OP_SERVICE_ACCOUNT_TOKEN` from service env.
- Vault used for agent-accessible items: `Clawd`.

## Policy

- Prefer 1Password for secret exchange instead of chat.
- Do not print secret values unless explicitly requested for that item.
- Store API keys and tokens as separate named items with clear fields.
- Never persist raw secrets in repo files.

## Important item references (non-secret)

- GitHub R/O PAT item: `TeknoClawd PAT - R/O` (field: `token`)
- GitHub R/W PAT item: `TeknoClawd PAT - R/W` (field: `token`)
- OpenClaw gateway token item: `OpenClaw Gateway Token`
- Service account auth token item: `Service Account Auth Token: TeknoClawd`


# OpenClaw Sandbox Runtime Notes

Current intended sandbox posture:

- `agents.defaults.sandbox.mode: non-main`
- Docker-backed sandbox enabled
- network: `bridge`
- workspace access: `rw`

Docker access requires `clawd` in `docker` group.
