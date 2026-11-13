#!/data/data/com.termux/files/usr/bin/env bash

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ] || [ "${1:-}" = "help" ]; then
    cat <<USAGE
Usage:
  bash verify.sh    Verify the tarball's SHA256 against SHA256SUMS.txt (read-only)
  bash extract.sh    Extract to a temporary directory (TMPDIR, never into the repo)
  bash tests/audio_stats.sh   Print per-codec bitrates and durations

Environment:
  TMPDIR  Where the archive is extracted and temporary files are written
          (default: /data/data/com.termux/files/usr/tmp)
USAGE
    exit 0
fi
if [ "$#" -gt 0 ]; then
    echo "unexpected argument: $1 (try --help)" >&2
    exit 2
fi
# tests/audio_stats.sh — re-derive the archive's stats from the .7z itself and
# assert they match what the README advertises, so docs cannot drift from the
# shipped payload. Run by CI.
set -euo pipefail
cd "$(dirname "$0")/.."

# Prefer the caller's TMPDIR, then the Termux default, then any writable
# temp dir — CI runners have neither, and a hardcoded fallback failed there.
if [ -n "${TMPDIR:-}" ] && [ -d "$TMPDIR" ] && [ -w "$TMPDIR" ]; then
    :
elif [ -d /data/data/com.termux/files/usr/tmp ] && [ -w /data/data/com.termux/files/usr/tmp ]; then
    TMPDIR=/data/data/com.termux/files/usr/tmp
else
    TMPDIR=$(mktemp -d 2>/dev/null || echo ".")
fi
work="$TMPDIR/a9-stats"
rm -rf "$work"; mkdir -p "$work"

7z x -y -o"$work" "audios from Android 9.7z" >/dev/null

count() { find "$work/audio/$1" -type f -name '*.ogg' | wc -l | tr -d ' '; }

fail=0
check() { # <label> <expected> <actual>
  if [ "$2" != "$3" ]; then
    echo "STAT DRIFT: $1 — README says $2, archive has $3"
    fail=1
  else
    echo "OK  $1 = $3"
  fi
}

total=$(find "$work" -type f -name '*.ogg' | wc -l | tr -d ' ')
check "total files"    217 "$total"
check "alarms"          23 "$(count alarms)"
check "notifications"   75 "$(count notifications)"
check "ringtones"      102 "$(count ringtones)"
check "ui sounds"       17 "$(count ui)"

rates=$(python3 - "$work" <<'PY'
import collections, pathlib, sys
c = collections.Counter()
for p in pathlib.Path(sys.argv[1]).rglob("*.ogg"):
    d = p.read_bytes()
    i = d.find(b"\x01vorbis")  # Vorbis identification header
    if i >= 0:
        c[int.from_bytes(d[i + 12:i + 16], "little")] += 1
print(" ".join(f"{k // 1000}kHz:{v}" for k, v in sorted(c.items())))
PY
)
check "sample rates" "44kHz:190 48kHz:27" "$rates"

# README must mention the 48 kHz minority, not claim a single rate
if ! grep -q "48 kHz" README.md; then
  echo "STAT DRIFT: README no longer mentions the 48 kHz files"
  fail=1
fi

exit "$fail"
