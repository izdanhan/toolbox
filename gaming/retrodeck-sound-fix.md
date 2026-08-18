On a Ryzen 7 7840U, SNES emulation via RetroDeck shouldn't blink an eye. Audio crackling here usually stems from a mismatch between SNES's native frame rate (59.94 Hz) and your panel's refresh rate (e.g., 60 Hz / 120 Hz / 165 Hz), or PipeWire underruns via Flatpak.

Execute these fixes in order.

### Fix 1: Adjust RetroArch Audio Latency & Resampler

Since RetroDeck wraps RetroArch for SNES, start inside the RetroArch menu (press **F1** or your hotkey combo while *Chrono Trigger* is running):

1. Go to **Settings** → **Audio** → **Output**.
2. Set **Audio Driver** to `pipewire` (or `alsa` if `pipewire` acts up inside the Flatpak container).
3. Go to **Settings** → **Audio** → **Resampler**.
4. Set **Audio Resampler** to `sixel` or `lower quality` if it's struggling, but set **Resampler Quality** to `Normal` or `Lowest` first.
5. Go back to **Settings** → **Audio** and raise **Audio Latency (ms)**:
* Default is usually `64ms`. Bump it to **`96ms`** or **`128ms`**.



### Fix 2: Display Refresh Rate & Dynamic Audio Rate Control

If the video sync drifts, the audio buffer starves, causing crackles.

1. In RetroArch, go to **Settings** → **Video** → **Output**.
2. Highlight **Vertical Refresh Rate** and run **Set Display-Reported Refresh Rate**.
3. Go to **Settings** → **Audio** → **Synchronization**.
4. Ensure **Audio Sync** is **ON**.
5. Ensure **Maximum Timing Skew** is set around **`0.05`** (allows RetroArch to stretch pitch subtly to match screen refresh without crackling).
6. If variable refresh rate (FreeSync) is active on your display, toggle **Sync to Exact Content Frame Rate** to **ON** under **Settings** → **Frame Throttle**.

### Fix 3: PipeWire Quantum & Pulse Latency Fix (OS-Level)

Ubuntu 26.04 uses PipeWire by default. Flatpak apps can hit buffer underruns if PipeWire forces a quantum size that is too low.

Increase the fallback pulse latency for the RetroDeck Flatpak app:

1. Open a terminal.
2. Launch RetroDeck with an forced environment variable to test:
```bash
PULSE_LATENCY_MSEC=60 flatpak run net.retrodeck.retrodeck

```


3. If the crackling vanishes, make it permanent by overriding the Flatpak environment variable:
```bash
flatpak override --user --env=PULSE_LATENCY_MSEC=60 net.retrodeck.retrodeck

```



### Fix 4: Core Swap

If you are using `bsnes-accuracy`, it can pull weird thread-timing quirks on Linux audio servers. Swap the SNES core in RetroDeck to **`Snes9x`** or **`bsnes-current`** for cleaner frame pacing.
