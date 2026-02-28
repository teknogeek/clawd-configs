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
