#!/bin/bash

# Check argument
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Step 1: Downloading 1080p Video (MKV container)..."
# Added --remote-components ejs:github
yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
       --merge-output-format mkv \
       --cookies-from-browser firefox \
       --extractor-args "youtube:player-client=web" \
       --js-runtimes node \
       --remote-components ejs:github \
       "$URL"

if [ $? -ne 0 ]; then
    echo "Error: Video download failed."
    exit 1
fi

echo -e "\nStep 2: Extracting standalone MP3 audio..."
# Added --remote-components ejs:github
yt-dlp -x --audio-format mp3 --audio-quality 0 \
       --cookies-from-browser firefox \
       --extractor-args "youtube:player-client=web" \
       --js-runtimes node \
       --remote-components ejs:github \
       "$URL"

if [ $? -eq 0 ]; then
    echo -e "\nSuccess: 1080p MKV video and high-quality MP3 audio have been saved."
else
    echo "Error: Audio extraction failed."
    exit 1
fi
