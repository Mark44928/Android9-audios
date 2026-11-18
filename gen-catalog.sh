#!/data/data/com.termux/files/usr/bin/env bash
# gen-catalog.sh — regenerate catalog.html from the committed archive's
# internal filenames. Read-only: never extracts the .7z, never writes audio.
# Usage:
#   bash gen-catalog.sh           rewrite catalog.html
#   bash gen-catalog.sh --check   exit 0 if catalog.html is up to date (CI)
set -euo pipefail
cd "$(dirname "$0")"

ARCHIVE="audios from Android 9.7z"
OUT="catalog.html"

command -v 7z >/dev/null 2>&1 || {
    echo "ERROR: 7z is required — install with 'pkg install p7zip'" >&2
    exit 1
}
command -v python3 >/dev/null 2>&1 || {
    echo "ERROR: python3 is required" >&2
    exit 1
}
[ -f "$ARCHIVE" ] || { echo "ERROR: archive not found: $ARCHIVE" >&2; exit 1; }

CHECK=0
[ "${1:-}" = "--check" ] && CHECK=1
[ $# -gt 1 ] && { echo "unexpected argument: $2 (try --check)" >&2; exit 2; }
if [ $# -eq 1 ] && [ "$1" != "--check" ]; then
    echo "unexpected argument: $1 (try --check)" >&2
    exit 2
fi

if [ "$CHECK" = 1 ]; then
    TMP_OUT="$(mktemp)"
    trap 'rm -f "$TMP_OUT"' EXIT
    OUT="$TMP_OUT"
fi

7z l -slt "$ARCHIVE" | python3 -c '
import json, sys

raw = sys.stdin.read()
CAP = {"alarms": "Alarms", "notifications": "Notifications",
       "ringtones": "Ringtones", "ui": "UI Sounds"}
tracks = []
for block in raw.split("\n\n"):
    path = None
    size = 0
    is_dir = False
    for line in block.splitlines():
        if line.startswith("Path = "):
            path = line[len("Path = "):]
        elif line.startswith("Size = "):
            try:
                size = int(line[len("Size = "):])
            except ValueError:
                size = 0
        elif line.startswith("Attributes = "):
            is_dir = "D" in line[len("Attributes = "):].split()[0]
    if not path or is_dir or not path.lower().endswith(".ogg"):
        continue
    parts = path.split("/")
    if len(parts) != 3 or parts[0] != "audio" or parts[1] not in CAP:
        sys.exit(f"ERROR: unexpected archive path layout: {path!r}")
    tracks.append({"path": path, "category": parts[1], "name": parts[2], "size": size})

tracks.sort(key=lambda t: t["path"])
counts = {c: sum(1 for t in tracks if t["category"] == c) for c in CAP}
if len(tracks) != 217:
    sys.exit(f"ERROR: expected 217 .ogg files in archive, found {len(tracks)}")

data = json.dumps({"tracks": tracks, "counts": counts}, separators=(",", ":"))
html = open("catalog.template.html", encoding="utf-8").read()
html = html.replace("/*__CATALOG_DATA__*/null", data)
open(sys.argv[1], "w", encoding="utf-8").write(html)
print(f"catalog: {len(tracks)} tracks " + " ".join(f"{k}={v}" for k, v in counts.items()))
' "$OUT"

if [ "$CHECK" = 1 ]; then
    cmp -s "$OUT" catalog.html && { echo "OK  catalog.html is up to date"; exit 0; }
    echo "DRIFT: catalog.html is stale — run: bash gen-catalog.sh" >&2
    exit 1
fi
