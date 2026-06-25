#!/bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Error: No URL provided."
    echo "Usage: $0 [URL]"
    exit 1
fi

URL="$1"

echo "Executing clean 1080p MKV and MP3 extraction..."

# Ajetaan lataus dynaamisella nimellä, jotta voimme siivota väliaikaistiedostot luotettavasti
yt-dlp --extractor-args "youtube:player-client=web_embedded,android_embedded" \
       --js-runtimes node \
       --remote-components ejs:github \
       -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
       --merge-output-format mkv \
       --embed-chapters \
       -x --audio-format mp3 --audio-quality 0 \
       --keep-video \
       "$URL"

if [ $? -eq 0 ]; then
    echo -e "\nCleaning up raw source tracks..."
    # Poistetaan väliaikaiset raakavideo- ja äänitiedostot (.f[0-9]* loppuiset)
    rm -f *\[*\]*.f[0-9]*.* 2>/dev/null
    
    echo -e "\nSuccess: Only the final 1080p MKV and MP3 files are kept."
else
    echo "Error: Download or extraction failed."
    exit 1
fi
