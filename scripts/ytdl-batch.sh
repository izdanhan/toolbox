#!/bin/bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <urls.txt> [target_dir] [mode: video|audio]"
    exit 1
fi

URL_FILE="$1"
OUT_DIR="${2:-.}"
MODE="${3:-video}"
ARCHIVE_FILE="$OUT_DIR/.yt-archive.txt"

if [ ! -f "$URL_FILE" ]; then
    echo "Error: URL file not found: $URL_FILE"
    exit 1
fi

mkdir -p "$OUT_DIR"

while IFS= read -r line || [ -n "$line" ]; do
    url="$(echo "$line" | xargs)"
    [ -z "$url" ] && continue
    case "$url" in
        \#*) continue ;;
    esac

    if [[ "$url" == *"list="* ]]; then
        TEMPLATE="%(playlist_title)s/%(playlist_index)02d - %(title)s [%(id)s].%(ext)s"
    else
        TEMPLATE="%(title)s [%(id)s].%(ext)s"
    fi

    if [ "$MODE" = "audio" ]; then
        yt-dlp --ignore-errors \
               --download-archive "$ARCHIVE_FILE" \
               --js-runtimes node \
               --remote-components ejs:github \
               -P "$OUT_DIR" \
               -o "$TEMPLATE" \
               -x \
               --audio-format mp3 \
               --audio-quality 0 \
               --embed-thumbnail \
               --add-metadata \
               "$url"
    else
        yt-dlp --ignore-errors \
               --download-archive "$ARCHIVE_FILE" \
               --extractor-args "youtube:player-client=web_embedded,android_embedded" \
               --js-runtimes node \
               --remote-components ejs:github \
               -P "$OUT_DIR" \
               -o "$TEMPLATE" \
               -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
               --merge-output-format mkv \
               --embed-chapters \
               --embed-metadata \
               "$url"
    fi
done < "$URL_FILE"
