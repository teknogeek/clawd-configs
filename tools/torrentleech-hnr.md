# TorrentLeech HnR Runbook (TL)

## Key TL rule (read this before deleting anything)
- **Partials can become HnR.** Per TL wiki: if you have downloaded **>=10%** of a torrent and you stop/pause before reaching **1:1**, it can appear in your HnR list.
- **Partial downloads do not accrue seed time.** For partial HnRs, the practical clearance mechanism is **upload back to 1:1 of what you downloaded**, or clear via **surplus/points/VIP**.
- **Freeleech does NOT exempt HnR.** It affects download accounting, not seeding obligations.

## Safe deletion policy
Before deleting torrent data:
1) Identify whether it is **TL**.
2) If TL:
   - If it is in TL HnR list: **do not delete data** unless you accept you’ll pay with points/VIP or you’ve already cleared it.
   - If it is a partial and progress >=10%: treat as **HnR-risk**.
   - If completed: follow TL class rule (e.g. TL V: **10 days OR 1:1**) before removal.

## When disk is full (preferred flow)
1) **Stop intake first** (autobrr off / disk gate).
2) Do NOT mass-delete TL partials blindly.
3) Triage:
   - Delete **non-TL** junk first.
   - For TL partials: either keep seeding until **uploaded >= downloaded** (ratio 1.0) or plan to clear with surplus/points/VIP.
4) Re-check TL HnR count after changes.

## Monitoring
- Track TL HnR count + points + surplus regularly.
- If HnR count approaches warning threshold, reduce count by:
  - Clearing **cheapest-by-points** entries, or
  - Reacquiring **smallest upload-debt** entries and seeding them to 1:1.
