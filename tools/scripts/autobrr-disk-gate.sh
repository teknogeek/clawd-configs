#!/bin/sh
# autobrr-disk-gate.sh
# Approves a torrent only if projected free space >= MIN_FREE_GB
# Projected free = disk free - remaining bytes of all incomplete qBT downloads
set -eu

MOUNT="/config/mount-media"
MIN_FREE_GB=1500
QB_URL="https://qbt.int.teknogeek.io"
QB_USER="admin"
QB_PASS="CHANGEME"
COOKIE="/tmp/qbt_gate_sid.txt"

# --- Step 1: disk free ---
avail_g="$(df -BG "$MOUNT" | tail -n 1 | awk '{print $(NF-2)}' | tr -cd '0-9' || true)"
if [ -z "$avail_g" ]; then
  echo "BLOCK: couldn't parse df output for $MOUNT" >&2
  exit 2
fi

# --- Step 2: qBT pending bytes ---
pending_gb=0

# Login and grab SID cookie
if curl -fsSL -c "$COOKIE" \
    --data "username=${QB_USER}&password=${QB_PASS}" \
    "${QB_URL}/api/v2/auth/login" > /dev/null 2>&1; then

  # Sum amount_left across all incomplete torrents
  raw=$(curl -fsSL -b "$COOKIE" \
    "${QB_URL}/api/v2/torrents/info?filter=incomplete" 2>/dev/null || echo "[]")

  pending_bytes=$(echo "$raw" | grep -o '"amount_left":[0-9]*' \
    | awk -F: '{s+=$2} END{print s+0}')
  pending_gb=$(( ${pending_bytes:-0} / 1024 / 1024 / 1024 ))
else
  echo "WARN: qBT login failed, using disk-only check" >&2
fi

# --- Step 3: project and decide ---
projected_gb=$(( avail_g - pending_gb ))

echo "INFO: disk=${avail_g}G pending=${pending_gb}G projected=${projected_gb}G min=${MIN_FREE_GB}G" >&2

if [ "$projected_gb" -lt "$MIN_FREE_GB" ]; then
  echo "BLOCK: projected free ${projected_gb}G < ${MIN_FREE_GB}G" >&2
  exit 1
fi

echo "OK: projected free ${projected_gb}G >= ${MIN_FREE_GB}G" >&2
exit 0
