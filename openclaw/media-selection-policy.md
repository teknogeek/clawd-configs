# Media Selection Policy v1 (Radarr/Sonarr + Tdarr-aware)

## Defaults

- Default movie target quality: 1080p unless explicitly requested otherwise.
- Add without auto-search; perform manual search/ranking.

## Ranking order

1. Target quality/profile match.
2. Source integrity (avoid overly compressed tiny encodes).
3. Seeders.
4. Reasonable size/value (avoid unnecessarily huge files).
5. Tracker preference: TorrentLeech is a plus, not absolute.
6. Codec preference: x265 is a plus, not required (Tdarr re-encodes).

## Tdarr-aware rule

Do not blindly pick the smallest file. Prefer better source quality that Tdarr can compress cleanly.
