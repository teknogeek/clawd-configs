#!/usr/bin/env bash
set -euo pipefail

CHANNEL_ID="1476956790217506919"  # #clawd
COOKIE_ENV="/home/clawd/.openclaw/workspace/memory/tl-cookie-auth.env"
STATE_JSON="/home/clawd/.openclaw/workspace/memory/tl-hnr-state.json"
URL="https://www.torrentleech.org/profile/teknogeek/hnr"

FORCE_ALERT=0
if [[ "${1:-}" == "--test-alert" ]]; then
  FORCE_ALERT=1
fi

source "$COOKIE_ENV"
: "${TLUID:?missing TLUID in tl-cookie-auth.env}"
: "${TLPASS:?missing TLPASS in tl-cookie-auth.env}"

html_file=$(mktemp)
# Write to file to avoid stdout pipe issues in systemd / large HTML buffering
curl -fsSL -H "Cookie: tluid=${TLUID}; tlpass=${TLPASS}" "$URL" > "$html_file"

count=$(python3 - "$html_file" <<'PY'
import re,sys
html=open(sys.argv[1],'r',encoding='utf-8',errors='ignore').read()
m=re.search(r'hitnrunCountTotal">(\d+)<', html)
print(m.group(1) if m else '')
PY
)
points=$(python3 - "$html_file" <<'PY'
import re,sys
html=open(sys.argv[1],'r',encoding='utf-8',errors='ignore').read()
m=re.search(r'har_points">\s*([0-9,]+\.[0-9]+)', html)
print(m.group(1) if m else '')
PY
)
surplus=$(python3 - "$html_file" <<'PY'
import re,sys
html=open(sys.argv[1],'r',encoding='utf-8',errors='ignore').read()
m=re.search(r'har_surplus">\s*([^<]+)<', html)
print(m.group(1).strip() if m else '')
PY
)

rm -f "$html_file"

if [[ -z "$count" ]]; then
  echo "TL HnR watch: parse failed" >&2
  exit 2
fi

last=""
if [[ -f "$STATE_JSON" ]]; then
  last=$(python3 - "$STATE_JSON" <<'PY'
import json,sys
try:
  j=json.load(open(sys.argv[1]))
  v=j.get('lastCount')
  print('' if v is None else str(v))
except Exception:
  print('')
PY
)
fi

now_utc=$(date -u +%FT%TZ)

# Write updated state
python3 - "$STATE_JSON" "$count" "$points" "$surplus" "$now_utc" <<'PY'
import json,sys
path=sys.argv[1]
count=int(sys.argv[2])
points=sys.argv[3]
surplus=sys.argv[4]
now=sys.argv[5]
try:
  prev=json.load(open(path))
except Exception:
  prev={}
prev.update({
  "lastCount": count,
  "lastPoints": points,
  "lastSurplus": surplus,
  "lastCheckedUtc": now,
})
open(path,'w').write(json.dumps(prev,indent=2)+"\n")
PY

# Decide alert
alert=0
if [[ "$FORCE_ALERT" == "1" ]]; then
  alert=1
elif [[ -n "$last" && "$count" -gt "$last" ]]; then
  alert=1
fi

if [[ "$alert" == "1" ]]; then
  msg="TL HnR increased: ${last:-null} -> ${count} | points ${points:-?} | surplus ${surplus:-?}"
  openclaw message send --channel discord --target "$CHANNEL_ID" --message "$msg" >/dev/null
fi
