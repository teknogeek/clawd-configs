# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Notes Repo Workflow

- Obsidian/notes vault repo: `/home/clawd/.openclaw/workspace/vaults/notes`
- Before any read/write note operation, sync first:
  - `git -C /home/clawd/.openclaw/workspace/vaults/notes pull --rebase --autostash`
- After note changes, commit and push immediately to reduce conflicts.

## Media Automation Preferences

- Default movie target quality: 1080p (`HD-1080p` profile in Radarr) unless explicitly requested otherwise.
- Manual search ranking preference (in order):
  1. Best overall quality that fits target
  2. Higher seeders
  3. Reasonable size/value (avoid unnecessarily huge releases)
- Tracker preference: TorrentLeech (private tracker) is a plus, but do not force it over clearly better public results.
- Codec preference: x265 is a plus, but not required (Tdarr handles re-encoding).

## GitHub Access Workflow (Security Baseline)

- Default mode: **read-only** GitHub token via 1Password (`gh-ro`).
- Escalation mode: **PR/write** token only when explicitly requested (`gh-pr`).
- Cleanup mode: clear token env after write tasks (`gh-off`).
- `gh-safe` wrapper is available to block likely write-capable gh commands unless in PR profile.

### 1Password secret refs (non-secret pointers)

- `OP_REF_GH_TOKEN_RO=op://Clawd/wb5h3iksiy6kvl4yqujwxozxke/token`
- `OP_REF_GH_TOKEN_PR=op://Clawd/d2viyad6bwxv2gjvgat2ao73xu/token`

### Rules

- Never store raw PAT values in workspace files.
- Keep RO as default for all routine repo access.
- Use PR token only for branch push + PR workflows.
- Branch safety baseline is applied repo-wide (no force-push, no default-branch deletion where supported).

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.
