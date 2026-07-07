The 48 FPS cap is a known Bethesda engine bug. On a 144Hz monitor, Fallout 4’s hardcoded internal VSync forces the game to run at exactly 1/3 of your refresh rate ($144 / 3 = 48$).

Your `DXVK_FRAME_RATE=60` argument is currently being overridden by the game's engine-level VSync. You need to disable the engine VSync in the configuration files so your launch options can take control.

### Step 1: Modify the `.ini` Files

Navigate to the game's Proton prefix directory on your Fedora desktop:

```bash
~/.steam/steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My Games/Fallout4/

```

*(Note: If you use a custom Steam library path, locate the corresponding `compatdata/377160/` directory there).*

Open both **`Fallout4.ini`** and **`Fallout4Prefs.ini`** using a text editor (like KWrite or Kate) and modify the following line in the `[Display]` section of both files:

```ini
iPresentInterval=0

```

*(If it is set to `1`, change it to `0`. If the line doesn't exist under `[Display]`, add it).*

### Step 2: Keep Your Launch Options

Keep your current Steam launch string exactly as it is:

```text
MANGOHUD=1 PROTON_ENABLE_WAYLAND=1 DXVK_FRAME_RATE=60 gamemoderun %command%

```

With `iPresentInterval=0` letting go of the engine lock, `DXVK_FRAME_RATE=60` will successfully cap the game at a stable 60 FPS without breaking the physics engine.


---


The physics engine in Fallout 4 is tied directly to the framerate. Running at 200–1000 FPS will break the game mechanics, accelerate lockpicking speeds to unplayable levels, and cause you to get stuck permanently in terminals.

Since `iPresentInterval=0` worked, the engine-level lock is gone, but your `DXVK_FRAME_RATE=60` argument is being ignored. This happens on Linux under Wayland because `DXVK_FRAME_RATE` relies on specific presentation behaviors that are bypassed depending on the compositor or VKD3D-Proton layer handling (Fallout 4 is a DirectX 11 game, but depending on your Proton version, it might be routing frames differently, or Gamescope is needed to hard-cap).

Switch your Steam launch options to use MangoHud's built-in frame limiter or standard environment variables instead.

### Option 1: Use MangoHud for the Cap

Since you already have MangoHud running, use its internal limiter. Update your Steam launch options to:

```text
MANGOHUD=1 MANGOHUD_CONFIG="fps_limit=60,no_display=0" PROTON_ENABLE_WAYLAND=1 gamemoderun %command%

```

*(If you do not want the MangoHud visual overlay cluttering the screen but still want the 60 FPS limit, change `no_display=0` to `no_display=1`).*

### Option 2: Use Gamescope (The Bulletproof Method)

Gamescope creates an isolated micro-compositor that forces presentation limits before the desktop compositor even sees the frames.

1. Install gamescope via DNF if you don't have it:
```bash
sudo dnf install gamescope

```


2. Change your launch options to:
```text
MANGOHUD=1 gamescope -r 60 -f -- gamemoderun %command%

```


* `-r 60` forces a strict 60Hz container refresh rate.
* `-f` runs it fullscreen.



Test Option 1 first as it keeps your current stack light.
