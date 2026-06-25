#!/bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Executing secure embedded-client 1080p MKV and MP3 extraction..."

# Swapped clients to web_embedded and android_embedded to bypass PO Token/DRM requirements
yt-dlp --extractor-args "youtube:player-client=web_embedded,android_embedded" \
       --js-runtimes node \
       --remote-components ejs:github \
       -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
       --merge-output-format mkv \
       -x --audio-format mp3 --audio-quality 0 \
       --keep-video \
       "$URL"

if [ $? -eq 0 ]; then
    echo -e "\nSuccess: High-definition MKV and MP3 saved correctly."
else
    echo "Error: Download or extraction failed."
    exit 1
fi
