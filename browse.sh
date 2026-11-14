#!/data/data/com.termux/files/usr/bin/env bash
# browse.sh — list what's inside the archive without extracting anything.
# Usage: bash browse.sh [filter]     e.g. bash browse.sh alarm
# No files are written anywhere: this is a read-only `7z l` listing.
set -euo pipefail
cd "$(dirname "$0")"

ARCHIVE="audios from Android 9.7z"
FILTER="${1:-}"

command -v 7z >/dev/null 2>&1 || {
    echo "ERROR: 7z is required — install with 'pkg install p7zip'" >&2
    exit 1
}
[ -f "$ARCHIVE" ] || { echo "ERROR: archive not found: $ARCHIVE" >&2; exit 1; }

# -ba: bare listing (no headers). Fields 1-5 are date, time, attrs, size,
# compressed size; everything after that is the path (spaces preserved).
if [ -n "$FILTER" ]; then
    7z l -ba "$ARCHIVE" | awk '{ for (i = 1; i <= 5; i++) $i = ""; sub(/^ +/, ""); print }' \
        | grep -i -- "$FILTER" || { echo "(no matches for '$FILTER')" >&2; exit 1; }
else
    7z l -ba "$ARCHIVE" | awk '{ for (i = 1; i <= 5; i++) $i = ""; sub(/^ +/, ""); print }'
fi
