#!/bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Step 1: Downloading 1080p Video (MKV container for maximum audio integrity)..."
yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --merge-output-format mkv "$URL"

if [ $? -ne 0 ]; then
    echo "Error: Video download failed."
    exit 1
fi

echo -e "\nStep 2: Extracting standalone MP3 audio..."
yt-dlp -x --audio-format mp3 --audio-quality 0 "$URL"

if [ $? -eq 0 ]; then
    echo -e "\nSuccess: Both 1080p MKV video and high-quality MP3 audio have been saved."
else
    echo "Error: Audio extraction failed."
    exit 1
fi
