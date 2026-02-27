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
