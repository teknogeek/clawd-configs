# ARR Access Notes (Radarr/Sonarr)

## Purpose

Quick reference for validating and using Radarr/Sonarr API access without rediscovering setup details.

## Endpoints

- Radarr base: `https://radarr.int.teknogeek.io`
- Sonarr base: `https://sonarr.int.teknogeek.io`
- Quality profiles API path (both): `/api/v3/qualityprofile`

## Secrets Source

Use 1Password vault `Clawd`:

- `Radarr API Key` (field: `credential`)
- `Sonarr API Key` (field: `credential`)

## Current Verified Mapping (2026-02-28)

- Target profile name: `HD-1080p`
- Radarr: `id=4`
- Sonarr: `id=4`

Note: Sonarr includes an extra profile (`Highest Possible`, `id=7`).

## Verification Command Pattern

Use `op` in tmux per skill policy, then query APIs with `X-Api-Key`.

Example (sanitized):

```bash
RADARR_KEY="$(op read 'op://Clawd/Radarr API Key/credential')"
SONARR_KEY="$(op read 'op://Clawd/Sonarr API Key/credential')"

curl -fsS -H "X-Api-Key: $RADARR_KEY" \
  "https://radarr.int.teknogeek.io/api/v3/qualityprofile"

curl -fsS -H "X-Api-Key: $SONARR_KEY" \
  "https://sonarr.int.teknogeek.io/api/v3/qualityprofile"
```

## Maintenance

- Re-verify profile IDs after major ARR upgrades or profile edits.
- If profile names/IDs drift, update this file and `tools/media-selection-policy.md`.
