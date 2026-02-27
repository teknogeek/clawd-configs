# 1Password Secret Handling

## Integration

- OpenClaw runtime uses `OP_SERVICE_ACCOUNT_TOKEN` from service env.
- Vault used for agent-accessible items: `Clawd`.

## Policy

- Prefer 1Password for secret exchange instead of chat.
- Do not print secret values unless explicitly requested for that item.
- Store API keys and tokens as separate named items with clear fields.
