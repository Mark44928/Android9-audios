#!/data/data/com.termux/files/usr/bin/env bash
# verify.sh — verify SHA256 of Android 9 audio archive

set -euo pipefail

ARCHIVE="audios from Android 9.7z"
SUMS="SHA256SUMS.txt"

echo "Verifying $ARCHIVE..."

if [[ ! -f "$ARCHIVE" ]]; then
    echo "ERROR: Archive not found: $ARCHIVE"
    exit 1
fi

if [[ ! -f "$SUMS" ]]; then
    echo "ERROR: Checksum file not found: $SUMS"
    exit 1
fi

expected=$(awk '{print $1}' "$SUMS")
actual=$(sha256sum "$ARCHIVE" | awk '{print $1}')

if [[ "$expected" == "$actual" ]]; then
    echo "✓ SHA256 matches: $actual"
else
    echo "✗ SHA256 MISMATCH!"
    echo "  Expected: $expected"
    echo "  Actual:   $actual"
    exit 1
fi

echo

# Try to show archive contents if 7z is available
if command -v 7z &>/dev/null; then
    echo "Archive contents:"
    file_count=$(7z l "$ARCHIVE" 2>/dev/null | grep -E "\.ogg$|\.OGG$" | wc -l)
    echo "  $file_count audio files"
else
    echo "Archive contents:"
    echo "  (7z not installed, cannot list contents)"
fi

echo
echo "Verification complete."
