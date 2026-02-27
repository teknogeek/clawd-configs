# OpenClaw GitHub Auth & Access

## Current model

- GitHub access uses PATs stored in 1Password vault `Clawd`.
- Preferred PAT item names:
  - `TeknoClawd PAT - R/O` (field: `token`)
  - `TeknoClawd PAT - R/W` (field: `token`)

## Notes

- `gh` can be authenticated by piping PAT to `gh auth login --with-token`.
- Use R/O token for read/list/query tasks.
- Use R/W token only for writes (push/create/edit operations).
- Avoid storing PATs in repo, shell history, or chat.
