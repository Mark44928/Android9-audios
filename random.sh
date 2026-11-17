#!/data/data/com.termux/files/usr/bin/env bash
# random.sh [--extract] [--category alarms|notifications|ringtones|ui] [--count N] [--list]
# Pick one (or N) random track(s) from the archive, optionally restricted to a category.
# --extract copies the selected file(s) to $TMPDIR/android9-random (no repo writes).
set -euo pipefail
cd "$(dirname "$0")"

ARCHIVE="audios from Android 9.7z"
EXTRACT=0
LIST=0
CATEGORY=""
COUNT=1

usage() {
    echo "usage: random.sh [--category alarms|notifications|ringtones|ui] [--count N] [--list] [--extract]"
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --extract) EXTRACT=1 ;;
        --list) LIST=1 ;;
        --category)
            [ $# -ge 2 ] || { echo "ERROR: --category needs alarms, notifications, ringtones or ui" >&2; exit 2; }
            CATEGORY="$(printf '%s' "$2" | tr '[:upper:]' '[:lower:]')"
            shift
            ;;
        --category=*) CATEGORY="$(printf '%s' "${1#--category=}" | tr '[:upper:]' '[:lower:]')" ;;
        --count)
            [ $# -ge 2 ] || { echo "ERROR: --count needs a number" >&2; exit 2; }
            COUNT="$2"
            shift
            ;;
        --count=*) COUNT="${1#--count=}" ;;
        -h|--help) usage; exit 0 ;;
        *) echo "ERROR: unknown option: $1" >&2; usage >&2; exit 2 ;;
    esac
    shift
done

case "$CATEGORY" in
    ""|alarms|notifications|ringtones|ui) ;;
    alarm) CATEGORY=alarms ;;
    notification) CATEGORY=notifications ;;
    ringtone) CATEGORY=ringtones ;;
    *) echo "ERROR: --category must be alarms, notifications, ringtones or ui" >&2; exit 2 ;;
esac

case "$COUNT" in
    ''|*[!0-9]*) echo "ERROR: --count needs a whole number" >&2; exit 2 ;;
esac
[ "$COUNT" -ge 1 ] && [ "$COUNT" -le 50 ] || { echo "ERROR: --count must be 1-50" >&2; exit 2; }
OUT_DEFAULT_TMP="${TMPDIR:-}"
if [ -n "$OUT_DEFAULT_TMP" ] && [ -d "$OUT_DEFAULT_TMP" ] && [ -w "$OUT_DEFAULT_TMP" ]; then
    :
elif [ -d /data/data/com.termux/files/usr/tmp ] && [ -w /data/data/com.termux/files/usr/tmp ]; then
    OUT_DEFAULT_TMP=/data/data/com.termux/files/usr/tmp
else
    OUT_DEFAULT_TMP=$(mktemp -d)
fi
OUT="${OUT_DEFAULT_TMP}/android9-random"

command -v 7z >/dev/null 2>&1 || {
    echo "ERROR: 7z is required — install with 'pkg install p7zip'" >&2
    exit 1
}
[ -f "$ARCHIVE" ] || { echo "ERROR: archive not found: $ARCHIVE" >&2; exit 1; }

mapfile -t TRACKS < <(
    7z l -ba "$ARCHIVE" \
        | awk '{ for (i = 1; i <= 5; i++) $i = ""; sub(/^ +/, ""); print }' \
        | grep -Ei '\.(ogg|oga|mp3|wav|flac|m4a|opus)$' \
        | if [ -n "$CATEGORY" ]; then grep -E "^audio/$CATEGORY/"; else grep -E '^audio/'; fi || true
)
TOTAL_TRACKS=${#TRACKS[@]}
[ "$TOTAL_TRACKS" -gt 0 ] || { echo "ERROR: no audio files found in the archive${CATEGORY:+ for category $CATEGORY}" >&2; exit 1; }
[ "$COUNT" -le "$TOTAL_TRACKS" ] || COUNT="$TOTAL_TRACKS"

pick_unique() {
    local -n pool="$1"
    local amount="$2" picked=() index
    if [ "$amount" -ge "${#pool[@]}" ]; then
        printf '%s\n' "${pool[@]}"
        return
    fi
    while [ "${#picked[@]}" -lt "$amount" ]; do
        index=$((RANDOM % ${#pool[@]}))
        local candidate="${pool[$index]}" seen=0 existing
        for existing in "${picked[@]}"; do
            [ "$existing" = "$candidate" ] && { seen=1; break; }
        done
        if [ "$seen" -eq 0 ]; then
            picked+=("$candidate")
            printf '%s\n' "$candidate"
        fi
    done
}

if [ "$LIST" = "1" ]; then
    printf '%s\n' "${TRACKS[@]}"
    exit 0
fi

PICKS=()
while IFS= read -r pick; do PICKS+=("$pick"); done < <(pick_unique TRACKS "$COUNT")

printf '%s\n' "${PICKS[@]}"

if [ "$EXTRACT" = "1" ]; then
    mkdir -p "$OUT"
    for PICK in "${PICKS[@]}"; do
        7z e -y -o"$OUT" "$ARCHIVE" "$PICK" >/dev/null
        echo "Extracted to $OUT/$(basename "$PICK")"
    done
fi
