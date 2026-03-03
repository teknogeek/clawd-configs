#!/usr/bin/env bash
set -euo pipefail

COOKIE_ENV="/home/clawd/.openclaw/workspace/memory/tl-cookie-auth.env"
STATE_JSON="/home/clawd/.openclaw/workspace/memory/tl-hnr-state.json"
URL="https://www.torrentleech.org/profile/teknogeek/hnr"

source "$COOKIE_ENV"
: "${TLUID:?missing TLUID}"
: "${TLPASS:?missing TLPASS}"

html_file=$(mktemp)
trap 'rm -f "$html_file"' EXIT
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
ratio=$(python3 - "$html_file" <<'PY'
import re,sys
html=open(sys.argv[1],'r',encoding='utf-8',errors='ignore').read()
m=re.search(r'title="Ratio"[^>]*>.*?(\d+\.\d+)\s*</div>', html, re.DOTALL)
print(m.group(1) if m else '')
PY
)

if [[ -z "$count" ]]; then
  echo "TL HnR watch parse failed"
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

python3 - "$STATE_JSON" "$count" "$points" "$surplus" "$ratio" "$now_utc" <<'PY'
import json,sys
path=sys.argv[1]
count=int(sys.argv[2])
points=sys.argv[3]
surplus=sys.argv[4]
ratio=sys.argv[5]
now=sys.argv[6]
try:
  prev=json.load(open(path))
except Exception:
  prev={}
prev.update({
  "lastCount": count,
  "lastPoints": points,
  "lastSurplus": surplus,
  "lastRatio": ratio,
  "lastCheckedUtc": now,
})
open(path,'w').write(json.dumps(prev,indent=2)+"\n")
PY

if [[ -n "$last" && "$count" -gt "$last" ]]; then
  echo "TL HnR increased: ${last} -> ${count} | points ${points:-?} | surplus ${surplus:-?}"
else
  echo "NO_REPLY"
fi
