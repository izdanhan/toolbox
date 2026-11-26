#!/bin/bash
set -u

if [ -z "${1:-}" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL] [TARGET_DIR]"
    exit 1
fi

URL="$1"
OUT_DIR="${2:-.}"

yt-dlp --extractor-args "youtube:player-client=web_embedded,android_embedded" \
       --js-runtimes node \
       --remote-components ejs:github \
       -P "$OUT_DIR" \
       -o "%(title)s [%(id)s].%(ext)s" \
       -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
       --merge-output-format mkv \
       --embed-chapters \
       --embed-metadata \
       "$URL"
