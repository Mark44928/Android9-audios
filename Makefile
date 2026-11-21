# Android9-audios — Makefile
# Audio archive verification repo. No build step: the payload is a committed
# .7z. Every script works under TMPDIR and never extracts into the repo.
#
#   make check    verify SHA256 + file count + per-codec stats (read-only)
#   make extract  extract the archive to TMPDIR (never into the repo)
#   make clean    remove any TMPDIR leftovers this Makefile created

PYTHON ?= python3
export TMPDIR ?= /data/data/com.termux/files/usr/tmp

.PHONY: check extract clean

check:
	bash verify.sh
	bash tests/audio_stats.sh

extract:
	bash extract.sh

clean:
	rm -rf "$$TMPDIR/android9-audios-extract" "$$TMPDIR/android9-audios-only"