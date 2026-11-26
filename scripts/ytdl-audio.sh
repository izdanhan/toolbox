#!/bin/bash
set -u

if [ -z "${1:-}" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL] [TARGET_DIR]"
    exit 1
fi

URL="$1"
OUT_DIR="${2:-.}"

yt-dlp -P "$OUT_DIR" \
       -o "%(title)s [%(id)s].%(ext)s" \
       -x \
       --audio-format mp3 \
       --audio-quality 0 \
       --embed-thumbnail \
       --add-metadata \
       "$URL"
