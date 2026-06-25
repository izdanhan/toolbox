#!/bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Starting audio extraction for: $URL"

# Extract best audio and convert to MP3 320k
yt-dlp -x --audio-format mp3 --audio-quality 0 "$URL"

if [ $? -eq 0 ]; then
    echo "Audio download and MP3 conversion completed successfully."
else
    echo "Error: Extraction failed. Ensure ffmpeg is installed."
    exit 1
fi
