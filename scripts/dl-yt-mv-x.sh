#!/bin/bash

# Check argument
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Executing single-pass download for 1080p MKV and MP3 extraction..."

# Combined command: Downloads the best 1080p stream as MKV, 
# then uses the '--keep-video' flag during audio extraction to ensure the MKV is preserved.
yt-dlp --cookies-from-browser firefox \
       --extractor-args "youtube:player-client=web" \
       --js-runtimes node \
       --remote-components ejs:github \
       -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
       --merge-output-format mkv \
       -x --audio-format mp3 --audio-quality 0 \
       --keep-video \
       "$URL"

if [ $? -eq 0 ]; then
    echo -e "\nSuccess: Both 1080p MKV video and high-quality MP3 audio are saved in the directory."
else
    echo "Error: Download or extraction failed."
    exit 1
fi
