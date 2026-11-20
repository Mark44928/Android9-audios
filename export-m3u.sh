#!/data/data/com.termux/files/usr/bin/env bash
# export-m3u.sh [--shuffle] [output.m3u] — build a playlist from the archive, no extraction.
# Defaults to $TMPDIR/android9-audios.m3u when no path is given.
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: bash export-m3u.sh [--shuffle] [output.m3u]

Writes a playlist of every audio track in the committed archive.
--shuffle randomises track order (handy for a surprise alarm rotation).
Relative output paths are resolved from the caller's directory.
Default: $TMPDIR/android9-audios.m3u (paths point into the default
extraction tree, android9-audios-extract/, so extract first)
EOF
}

SHUFFLE=0
OUT_ARG=""
while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help) usage; exit 0 ;;
        --shuffle) SHUFFLE=1 ;;
        -*) echo "ERROR: unknown option: $1" >&2; usage >&2; exit 2 ;;
        *)
            [ -z "$OUT_ARG" ] || { echo "ERROR: only one output path may be given" >&2; usage >&2; exit 2; }
            OUT_ARG="$1"
            ;;
    esac
    shift
done

CALLER_DIR=$(pwd)
ROOT=$(cd "$(dirname "$0")" && pwd)
cd "$ROOT"

if [ -n "${TMPDIR:-}" ] && [ -d "$TMPDIR" ] && [ -w "$TMPDIR" ]; then
    :
elif [ -d /data/data/com.termux/files/usr/tmp ] && [ -w /data/data/com.termux/files/usr/tmp ]; then
    TMPDIR=/data/data/com.termux/files/usr/tmp
else
    TMPDIR=$(mktemp -d)
fi
ARCHIVE="$ROOT/audios from Android 9.7z"

if [ -n "$OUT_ARG" ]; then
    CUSTOM_OUT=1
    case "$OUT_ARG" in
        /*) OUT="$OUT_ARG" ;;
        *) OUT="$CALLER_DIR/$OUT_ARG" ;;
    esac
else
    CUSTOM_OUT=0
    OUT="$TMPDIR/android9-audios.m3u"
fi

command -v 7z >/dev/null 2>&1 || {
    echo "ERROR: 7z is required — install with 'pkg install p7zip'" >&2
    exit 1
}
[ -f "$ARCHIVE" ] || { echo "ERROR: archive not found: $ARCHIVE" >&2; exit 1; }

mkdir -p "$(dirname "$OUT")"
OUT_DIR=$(cd "$(dirname "$OUT")" && pwd)
OUT="$OUT_DIR/$(basename "$OUT")"
if [ "$OUT" = "$ARCHIVE" ]; then
    echo "ERROR: refusing to overwrite the source archive" >&2
    exit 1
fi

TMP_OUT="$OUT.tmp.$$"
TMP_SHUF="$TMP_OUT.shuf"
trap 'rm -f "$TMP_OUT" "$TMP_SHUF"' EXIT
if ! 7z l -ba "$ARCHIVE" \
    | awk '{ for (i = 1; i <= 5; i++) $i = ""; sub(/^ +/, ""); print }' \
    | grep -Ei '\.(ogg|oga|mp3|wav|flac|m4a|opus)$' > "$TMP_OUT"; then
    echo "ERROR: no audio files found in the archive" >&2
    exit 1
fi
if [ "$SHUFFLE" = "1" ]; then
    command -v shuf >/dev/null 2>&1 || { echo "ERROR: shuf is required for --shuffle — install with 'pkg install coreutils'" >&2; exit 1; }
    shuf "$TMP_OUT" > "$TMP_SHUF"
    mv -f -- "$TMP_SHUF" "$TMP_OUT"
fi
# The default playlist lives next to the default extraction dir, so its
# relative paths must point into it; a custom destination keeps archive paths.
if [ "$CUSTOM_OUT" != "1" ]; then
    sed -i 's|^|android9-audios-extract/|' "$TMP_OUT"
fi

COUNT=$(grep -c . "$TMP_OUT" || true)
[ "$COUNT" -gt 0 ] || { echo "ERROR: no audio files found in the archive" >&2; exit 1; }
mv -f -- "$TMP_OUT" "$OUT"
trap - EXIT
echo "Wrote $OUT ($COUNT tracks)"
echo "Extract with 'bash extract.sh' first if your player needs real files."
