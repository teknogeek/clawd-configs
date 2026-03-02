# WORKFLOW_AUTO.md

## Active
- TL: HnR recovery. Current HnR count jumped to ~45 after purging partials.
- Strategy: keep autobrr/freeleech intake **disabled**; keep disk gate; reduce HnR count as needed (cheap clears or reacquire smallest-debt torrents).
- In progress: reacquired 3 large-debt HnRs into qB tagged `hnr-fix`: Love Island S05, HIMYM S01-S09, New Avengers S02.

## Current constraints / decisions
- TL partials can HnR once >=10% downloaded; partials don’t earn seedtime; clearance is mainly 1:1 upload debt or points/surplus/VIP.
- Autobrr disk gate: NFS mounted into container at `/config/mount-media`, floor set to **1500G** (script blocks if below).

## Monitoring
- Hourly cron `tl-hnr-hourly-watch` posts only when HnR count increases.

## Post-compaction restore
- Re-read: `SOUL.md`, `USER.md`, and `memory/YYYY-MM-DD.md` (today + yesterday if present).
- In shared/group contexts: do **not** load `MEMORY.md`.
- Before destructive actions when primary docs/rules were provided: re-read + quote relevant lines.
