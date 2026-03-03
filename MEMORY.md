# MEMORY.md — Long-term curated memory (PRIVATE)

> Only load in main/private sessions. Do NOT load in Discord channels or group chats.

## Preferences & Working Norms
- Tone: blunt, competent, minimal fluff. "Chill buddy" default.
- Don't present menus/option lists in casual conversation.
- Don't respond to every message with a last-word acknowledgement.
- Security-conscious: prefer 1Password for secrets, never leak in public.
- Match energy — one word question = one word answer.

## Network & Infrastructure
- LAN degradation root cause: UDM-SE CPU/packet saturation from IDS/IPS (Suricata HIGH) + DPI under high PPS from torrents.
- Fix: disabled IDS/IPS and Traffic Identification/DPI.
- Working config: Mullvad WG Boston, QR ON, MTU 1380, qB 100/30 peers. 80-100 MiB/s sustained, 0% loss.
- ONT→UDM cable had swapped pairs; fixing termination restored baseline stability.
- Key lesson: trust ping loss/jitter under load over speedtests.
- NordVPN had a reproducible "loss cliff" at ~40 MiB/s; ultimately UDM CPU features were the real bottleneck.

## TorrentLeech HnR Situation (active as of 2026-03-02)
- HnR count jumped to ~45 after purging partials.
- Partials HnR once >=10% downloaded; don't earn seedtime.
- Clearance: 1:1 upload debt, or points/surplus/VIP.
- Strategy: autobrr freeleech disabled, 1.5TB disk gate active, reacquired 3 large-debt HnRs tagged hnr-fix.
- If count hits 50: clear cheapest HnRs via points, or reacquire smallest-debt torrents (3-7GB).
- Hourly monitoring via systemd timer.

## Runtime Lessons
- Sandbox mode non-main means cron agent turns run in Docker — may lack host tools (curl, python3, op).
- For tasks needing host tools: use systemd timers, or change sandbox config.
- Don't blame the runtime without debugging first. Run which <tool> before claiming it's missing.

## Baby & Health
- Vanessa due Aug 22, 2026 with baby girl.
- GD monitoring: fasting 60-90, post-meal <120.
- Safe: cooked salmon (low mercury, high omega-3). Limit oily fish to 2x/week.
- Avoid: unpasteurized cheese (all types), pre-packed salads, raw fish, high-mercury fish.
- All meat/fish cooked to 165°F.

## Model Switch (2026-03-02)
- Switched from GPT-5.2 to Claude Sonnet 4
- Reason: OpenAI flagged account for "cybersecurity policy violation" for doing normal security research tasks (torrent monitoring, security-flavored prompts)
- All workspace files carried over unchanged
- SOUL.md was rewritten by Nyx (Ian's bot) to fix anti-sycophancy, response length, and honesty directives
- Setup: Claude Max subscription via setup-token OAuth, no API key billing
