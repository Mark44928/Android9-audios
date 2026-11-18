#!/data/data/com.termux/files/usr/bin/env bash
# Regression checks for export-m3u.sh: no self-overwrite, correct output path.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE="${TMPDIR:-${RUNNER_TEMP:-$HOME/.cache}}"
mkdir -p "$BASE"
TMP=$(mktemp -d "$BASE/export-m3u-test.XXXXXX")
trap 'rm -rf "$TMP"' EXIT
ARCHIVE="$ROOT/audios from Android 9.7z"

bash "$ROOT/export-m3u.sh" --help > "$TMP/help.txt"
grep -Fq "Usage: bash export-m3u.sh" "$TMP/help.txt"
test ! -e "$ROOT/--help"

before=$(sha256sum "$ARCHIVE" | cut -d' ' -f1)
if bash "$ROOT/export-m3u.sh" "$ARCHIVE" > "$TMP/refuse.log" 2>&1; then
    echo "archive self-overwrite was not refused" >&2
    exit 1
fi
after=$(sha256sum "$ARCHIVE" | cut -d' ' -f1)
[ "$before" = "$after" ] || { echo "archive was modified" >&2; exit 1; }
grep -Fq "refusing to overwrite the source archive" "$TMP/refuse.log"

(
    cd "$TMP"
    bash "$ROOT/export-m3u.sh" playlist.m3u > run.log
    test -s playlist.m3u
    test "$(grep -c . playlist.m3u)" -eq 217
    grep -Fq "Wrote $TMP/playlist.m3u (217 tracks)" run.log
)

echo "export-m3u regression checks OK"
