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

## Media / Tracker refs (use **item IDs**, not titles/labels)

Use `op read op://...` refs when scripting; it avoids the “wrong field label” footgun.

- qBittorrent (id: `f4p5guhnnmkii44wglqsu7b5wy`)
  - username: `op://Clawd/f4p5guhnnmkii44wglqsu7b5wy/username`
  - password: `op://Clawd/f4p5guhnnmkii44wglqsu7b5wy/password`
  - port: `op://Clawd/f4p5guhnnmkii44wglqsu7b5wy/Port:`

- TorrentLeech (title: `TorrentLeech` — prefer item id if/when we record it)
  - username: `op://Clawd/TorrentLeech/username`
  - password: `op://Clawd/TorrentLeech/password`
