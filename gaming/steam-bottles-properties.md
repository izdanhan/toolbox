# Fixes and etc Steam and Bottles

## Basic
    MANGOHUD=1 gamemoderun %command%

## CachyOS
    MANGOHUD=1 game-performance %command%

## FSR scale to fullscreen
    WINE_FULLSCREEN_FSR=1

## Skyrim, Fallout 4 and other Bethesda games
    PROTON_ENABLE_WAYLAND=1 DXVK_FRAME_RATE=60 gamemoderun %command%

## Gamescope
    gamescope -w 1280 -h 720 -W 1920 -H 1080 -f -F fsr --fsr-sharpness 2 -r 60 -- %command%

    gamescope -w 1920 -h 1080 -W 2560 -H 1440 -f -F fsr --fsr-sharpness 2 -r 60 -- %command%

    gamescope -w 1280 -h 720 -W 1920 -H 1080 -f -F fsr --fsr-sharpness 2 -r 60 --force-grab-cursor -- %command%

## Elite Dangerous
    __GL_GSYNC_ALLOWED=1 __GL_VRR_ALLOWED=1 MANGOHUD=1 gamemoderun %command%

    MANGOHUD=1 __GL_GSYNC_ALLOWED=1 __GL_VRR_ALLOWED=1 DISABLE_COMPOSITOR=1 gamemoderun %command% /autorun /autoquit /edo

# Elite Dangerous Steam EDMC
flatpak override --user --filesystem="~/.steam/steam/steamapps/compatdata/359320/pfx/drive_c/users/steamuser/Saved Games/Frontier Developments/Elite Dangerous" io.edcd.EDMarketConnector

# Elite Dangerous Epic EDMC
flatpak override --user --filesystem="/run/media/daniel/Voyager/HeroicLibrary/Prefixes/Elite Dangerous/drive_c/users/steamuser/Saved Games/Frontier Developments/Elite Dangerous" io.edcd.EDMarketConnector

## Bethesda games

### D11 games
    DXVK_CONFIG=dxgi.maxFrameRate=60;d3d11.maxFrameRate=60

### DX9 and DX11 games
    DXVK_CONFIG=d3d9.maxFrameRate=60;d3d11.maxFrameRate=60;dxgi.maxFrameRate=60

### Skyrim gamepad fix
    SkyrimPrefs.ini:
    bGamepadEnable=1
