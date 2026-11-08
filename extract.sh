#!/data/data/com.termux/files/usr/bin/env bash
# extract.sh — extract the archive and verify every file against the
# per-file checksums in SHA256SUMS-full.txt.
#
# The outer archive checksum (SHA256SUMS.txt, checked by verify.sh) proves the
# .7z is intact but says nothing about the files inside it; this proves all 217
# extracted files byte-for-byte. Reads/writes only under $TMPDIR — never
# extracts into the repo itself.
set -euo pipefail

TMPDIR="${TMPDIR:-/data/data/com.termux/files/usr/tmp}"
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
