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

---

To use AMD FSR on Fallout 4 under Linux, you have two distinct paths depending on whether you want to use the primitive, system-level upscaler built into Proton/Gamescope, or a modern, high-quality injected upscaler like FSR 3/4.

Given your T14s hardware (Radeon 780M iGPU), running at native 1440p or 4K on a 27" display will tank your framerate. You *need* upscaling. Choose **one** of the methods below.

---

### Option 1: The Modern Way (Injected FSR via OptiScaler)

This is the best method for image quality. Fallout 4 has no native FSR support, but since you are on Linux, you can use **OptiScaler** to trick the game into thinking it's running Nvidia DLSS, and then translate those calls directly into AMD FSR.

1. Download the latest release of `OptiScaler` (specifically the `dxgi.dll` version).
2. Drop `dxgi.dll` directly into your Fallout 4 installation directory (where `Fallout4.exe` lives).
3. Update your Steam Launch Options to allow the DLL override and combine it with your previous performance tweaks:
```bash
WINEDLLOVERRIDES="dxgi=n,b" PROTON_ENABLE_NVAPI=1 gamemoderun %command%

```


4. Boot the game. Press the **Insert** key on your keyboard to open the OptiScaler overlay menu.
5. Set the upscale method to **FSR**, select your preferred quality preset, and turn on **Force Reflex** to minimize input lag.

---

### Option 2: The Fast Way (Proton System-Level FSR)

If you don't want to mess with third-party DLL files, you can force Proton to render the entire game window at a lower resolution and scale it up using FSR 1.0.

1. Set your Steam Launch Options to this:
```bash
WINE_FULLSCREEN_FSR=1 WINE_FULLSCREEN_FSR_STRENGTH=2 PROTON_ENABLE_NVAPI=1 gamemoderun %command%

```


*(Note: `WINE_FULLSCREEN_FSR_STRENGTH` goes from `0` to `5`. `0` is sharpest, `5` is blurriest. `2` is usually the sweet spot).*
2. Open your `Fallout4Prefs.ini` file.
3. You must configure the game to run at a **lower, non-native aspect-ratio matched resolution**, and force it into **exclusive fullscreen** for Proton to capture and upscale it. Change your ini display values to match a lower rendering target (e.g., if your 27" monitor is 2560x1440, drop the game render resolution to 1706x960):
```ini
[Display]
bTopMostWindow=0
bMaximizeWindow=0
bBorderless=0
bFull Screen=1
iSize W=1706
iSize H=960

```


4. Launch the game. Proton will automatically scale that 960p window up to your screen's native 1440p using an FSR spatial filter.
