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
# extract.sh — extract the archive and verify every file against the
# per-file checksums in SHA256SUMS-full.txt.
#
# The outer archive checksum (SHA256SUMS.txt, checked by verify.sh) proves the
# .7z is intact but says nothing about the files inside it; this proves all 217
# extracted files byte-for-byte. Reads/writes only under $TMPDIR — never
# extracts into the repo itself.
set -euo pipefail

# Prefer the caller's TMPDIR, then the Termux default, then any writable
# temp dir — CI runners have neither TMPDIR set nor the Termux path, and a
# hardcoded fallback made mkdir fail with "Permission denied".
if [ -n "${TMPDIR:-}" ] && [ -d "$TMPDIR" ] && [ -w "$TMPDIR" ]; then
    :
elif [ -d /data/data/com.termux/files/usr/tmp ] && [ -w /data/data/com.termux/files/usr/tmp ]; then
    TMPDIR=/data/data/com.termux/files/usr/tmp
else
    TMPDIR=$(mktemp -d 2>/dev/null || echo ".")
fi
export TMPDIR
mkdir -p "$TMPDIR"

ARCHIVE="audios from Android 9.7z"
SUMS="SHA256SUMS-full.txt"
WORK="$TMPDIR/android9-audios-extract"

if [[ ! -f "$ARCHIVE" ]]; then
    echo "ERROR: run this script from the repo root (missing: $ARCHIVE)" >&2
    exit 1
fi
if ! command -v 7z >/dev/null 2>&1; then
    echo "ERROR: 7z is required — install with 'pkg install p7zip'" >&2
    exit 1
fi

rm -rf "$WORK"
mkdir -p "$WORK"
ROOT="$(pwd)"
echo "Extracting to $WORK ..."
7z x -y -o"$WORK" "$ARCHIVE" >/dev/null

echo "Verifying 217 files against $SUMS ..."
if (cd "$WORK" && sha256sum -c "$ROOT/$SUMS" --quiet); then
    echo "✓ all files match SHA256SUMS-full.txt"
else
    echo "✗ checksum mismatch inside the archive" >&2
    exit 1
fi
echo "Extracted tree: $WORK"
