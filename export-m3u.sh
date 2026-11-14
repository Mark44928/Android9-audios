#!/data/data/com.termux/files/usr/bin/env bash
# export-m3u.sh [output.m3u] — build a playlist from the archive, no extraction.
# Defaults to $TMPDIR/android9-audios.m3u when no path is given.
set -euo pipefail
cd "$(dirname "$0")"

ARCHIVE="audios from Android 9.7z"
OUT="${1:-${TMPDIR:-.}/android9-audios.m3u}"

command -v 7z >/dev/null 2>&1 || {
    echo "ERROR: 7z is required — install with 'pkg install p7zip'" >&2
    exit 1
}
[ -f "$ARCHIVE" ] || { echo "ERROR: archive not found: $ARCHIVE" >&2; exit 1; }

mkdir -p "$(dirname "$OUT")"
7z l -ba "$ARCHIVE" \
    | awk '{ for (i = 1; i <= 5; i++) $i = ""; sub(/^ +/, ""); print }' \
    | grep -Ei '\.(ogg|oga|mp3|wav|flac|m4a|opus)$' > "$OUT" || true

COUNT=$(grep -c . "$OUT" || true)
[ "$COUNT" -gt 0 ] || { echo "ERROR: no audio files found in the archive" >&2; exit 1; }
echo "Wrote $OUT ($COUNT tracks)"
echo "Extract with 'bash extract.sh' first if your player needs real files."
