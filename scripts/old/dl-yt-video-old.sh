#!/bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Starting download for: $URL"

# Execute yt-dlp with 1080p constraints
yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --merge-output-format mp4 "$URL"

if [ $? -eq 0 ]; then
    echo "Download completed successfully."
else
    echo "Error: Download failed. Make sure yt-dlp and ffmpeg are updated."
    exit 1
fi
