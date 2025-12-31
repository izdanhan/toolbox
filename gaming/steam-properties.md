## Basic
MANGOHUD=1 gamemoderun %command%

## FSR scale to fullscreen
WINE_FULLSCREEN_FSR=1

## Skyrim, Fallout 4 and other Bethesda games
DXVK_FRAME_RATE=60

## Gamescope
gamescope -w 1280 -h 720 -W 1920 -H 1080 -f -F fsr --fsr-sharpness 2 -r 60 -- %command%
gamescope -w 1920 -h 1080 -W 2560 -H 1440 -f -F fsr --fsr-sharpness 2 -r 60 -- %command%
gamescope -w 1280 -h 720 -W 1920 -H 1080 -f -F fsr --fsr-sharpness 2 -r 60 --force-grab-cursor -- %command%