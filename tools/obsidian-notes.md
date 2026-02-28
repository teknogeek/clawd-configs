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
