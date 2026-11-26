#!/bin/bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <URL> [target_dir] [mode: video|audio]"
    exit 1
fi

URL="$1"
OUT_DIR="${2:-.}"
MODE="${3:-video}"

mkdir -p "$OUT_DIR"

# If URL contains a playlist ID, place items inside a numbered playlist subfolder;
# otherwise save directly to OUT_DIR using your [id] naming convention.
if [[ "$URL" == *"list="* ]]; then
    TEMPLATE="%(playlist_title)s/%(playlist_index)02d - %(title)s [%(id)s].%(ext)s"
else
    TEMPLATE="%(title)s [%(id)s].%(ext)s"
fi

if [ "$MODE" = "audio" ]; then
    yt-dlp --js-runtimes node \
           --remote-components ejs:github \
           -P "$OUT_DIR" \
           -o "$TEMPLATE" \
           -x \
           --audio-format mp3 \
           --audio-quality 0 \
           --embed-thumbnail \
           --add-metadata \
           "$URL"
else
    yt-dlp --extractor-args "youtube:player-client=web_embedded,android_embedded" \
           --js-runtimes node \
           --remote-components ejs:github \
           -P "$OUT_DIR" \
           -o "$TEMPLATE" \
           -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
           --merge-output-format mkv \
           --embed-chapters \
           --embed-metadata \
           "$URL"
fi
