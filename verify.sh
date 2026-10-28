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
echo "Archive contents:"
7z l "$ARCHIVE" 2>/dev/null | grep "....A" | grep -c "\.ogg$" | xargs -I{} echo "  {} audio files"

echo
echo "Verification complete."