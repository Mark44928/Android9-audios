#!/data/data/com.termux/files/usr/bin/env bash
# verify.sh — verify SHA256 and file count of the Android 9 audio archive

set -euo pipefail

ARCHIVE="audios from Android 9.7z"
SUMS="SHA256SUMS.txt"
EXPECTED_FILES=217

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

# Verify the archive actually still holds the advertised number of audio
# files, so a truncated or re-packed archive fails loudly instead of silently
# shipping half the sounds.
if command -v 7z &>/dev/null; then
    file_count=$(7z l -slt "$ARCHIVE" 2>/dev/null | sed -n 's/^Path = //p' | grep -c '\.ogg$')
    echo "Archive contents: $file_count audio files"
    if [[ "$file_count" -ne "$EXPECTED_FILES" ]]; then
        echo "✗ FILE COUNT MISMATCH: expected $EXPECTED_FILES, archive holds $file_count"
        exit 1
    fi
    echo "✓ File count matches the advertised $EXPECTED_FILES"
else
    echo "Archive contents:"
    echo "  (7z not installed, cannot list contents — install with 'pkg install p7zip')"
fi

echo
echo "Verification complete."
