#!/bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Executing clean 1080p MKV (with Chapters)"

# Lisätty --embed-chapters, joka muuttaa YouTuben aikajanat MKV-kappaleiksi
yt-dlp --extractor-args "youtube:player-client=web_embedded,android_embedded" \
       --js-runtimes node \
       --remote-components ejs:github \
       -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
       --merge-output-format mkv \
       --embed-chapters \
       --keep-video \
       "$URL"

if [ $? -eq 0 ]; then
    echo -e "\nCleaning up raw source tracks..."
    rm -f *\[*\]*.f[0-9]*.* 2>/dev/null
    
    echo -e "\nSuccess: 1080p MKV (with metadata chapters)."
else
    echo "Error: Download or extraction failed."
    exit 1
fi