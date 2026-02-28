# OpenClaw Redeploy Guide (VM rebuild)

This repo is the source of truth for OpenClaw-specific ops/runbook content.

## 1) Base host prep

- Install git, curl, brew (Linuxbrew), Node/npm, Python3.
- Clone this repo to the workspace host.

## 2) OpenClaw install

- Install/update OpenClaw via your preferred method.
- Ensure gateway service is enabled (`openclaw gateway status`).

## 3) Secret/auth wiring

- Configure 1Password service-account token in gateway service env:
  - `OP_SERVICE_ACCOUNT_TOKEN=...`
- Confirm `op` CLI is installed and accessible.

## 4) Docker + sandbox

- Install Docker and add runtime user to `docker` group.
- Configure OpenClaw sandbox mode/settings per `openclaw/sandbox-runtime.md`.

## 5) GitHub auth profiles

- Use RO/RW PAT workflow in `openclaw/github-auth.md`.
- Keep read-only as default.

## 6) Notes + tools docs sync

- Pull generated runtime TOOLS.md:
  - `openclaw/scripts/pull-tools.sh`
- Keep split docs authoritative; regenerate/push via:
  - `openclaw/scripts/push-tools.sh`

## 7) Validation checks

- `openclaw gateway status`
- `openclaw security audit --deep`
- `openclaw skills check`
- verify key integrations: notes, GitHub auth, media policy references

## 8) Post-restore sanity

- Confirm repo remotes and push auth.
- Confirm 1Password item names/refs still match docs.
- Confirm Radarr/Sonarr manual-selection workflow behavior.
