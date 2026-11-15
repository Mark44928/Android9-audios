#!/data/data/com.termux/files/usr/bin/env bash
# random.sh [--extract] — pick one random track from the archive.
# --extract copies that single file to $TMPDIR/android9-random (no repo writes).
set -euo pipefail
cd "$(dirname "$0")"

ARCHIVE="audios from Android 9.7z"
EXTRACT=0
[ "${1:-}" = "--extract" ] && EXTRACT=1
OUT="${TMPDIR:-.}/android9-random"

command -v 7z >/dev/null 2>&1 || {
    echo "ERROR: 7z is required — install with 'pkg install p7zip'" >&2
    exit 1
}
[ -f "$ARCHIVE" ] || { echo "ERROR: archive not found: $ARCHIVE" >&2; exit 1; }

mapfile -t TRACKS < <(
    7z l -ba "$ARCHIVE" \
        | awk '{ for (i = 1; i <= 5; i++) $i = ""; sub(/^ +/, ""); print }' \
        | grep -Ei '\.(ogg|oga|mp3|wav|flac|m4a|opus)$' || true
)
COUNT=${#TRACKS[@]}
[ "$COUNT" -gt 0 ] || { echo "ERROR: no audio files found in the archive" >&2; exit 1; }

PICK=${TRACKS[RANDOM % COUNT]}
echo "$PICK"

if [ "$EXTRACT" = "1" ]; then
    mkdir -p "$OUT"
    7z e -y -o"$OUT" "$ARCHIVE" "$PICK" >/dev/null
    echo "Extracted to $OUT/$(basename "$PICK")"
fi
