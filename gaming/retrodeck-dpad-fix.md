# Retrodeck d-pad fix

This is a classic mapping handoff failure between the RetroDeck frontend (EmulationStation) and the underlying emulator core (usually RetroArch). Because `xpadneo` exposes the Elite 2 D-pad as a distinct set of Linux hat axes (`ABS_HAT0X` / `ABS_HAT0Y`), the menu parses it fine via SDL2, but the backend cores drop the assignment.

Fix this systematically.

### 1. Match the Controller Driver (RetroArch)

RetroDeck runs inside a Flatpak container, which changes how it accesses host hardware inputs. If RetroArch is looking for `udev` inputs while `xpadneo` and Flatpak are feeding it `sdl2`, your D-pad mappings will fail inside the emulation layer.

1. Launch **RetroDeck** and open **RetroArch** directly (or use the hotkey combo to open the RetroArch Quick Menu inside any running game).
2. Navigate to **Settings** ➔ **Drivers**.
3. Look for **Controller**. If it is set to `udev`, change it to `sdl2`. If it is already on `sdl2`, try toggling it to `udev`.
4. Navigate back to the Main Menu ➔ **Configuration File** ➔ **Save Current Configuration**.
5. Restart the game to see if the mapping initializes.

---

### 2. Force D-Pad Emulation (Per-Core Level)

If the driver matches but the specific emulator core still refuses to read the D-pad axes, you need to force the core to treat the D-pad as the primary digital movement input.

1. Launch the problematic game.
2. Open the **RetroArch Quick Menu** (Default layout: `Xbox Button + X`, or hit `F1` if a keyboard is connected).
3. Go to **Controls** ➔ **Port 1 Controls**.
4. Check the following settings:
* **Device Type:** Set this to **RetroPad with Analog**.
* **Analog to Digital Type:** If the game only accepts analog inputs, change this to **Left Analog**. If it’s a strict 2D retro game, ensure it's set to **None** or **Left Analog** to test if it routes the physical D-pad signals to the emulator's expected digital track.


5. Go up one menu level and select **Manage Remap Files** ➔ **Save Core Remap File** so you don't have to redo this every time the game launches.

---

### 3. Clear Stale EmulationStation Autoconfigs

If you mapped the controller multiple times while testing `xpadneo`, RetroDeck might be passing a corrupted temporary configuration file to the core on launch.

Clean the slate via terminal on your host system:

```bash
# For flatpak installations (RetroDeck standard)
rm -rf ~/.var/app/net.retrodeck.retrodeck/config/retroarch/autoconfig/*

```

After clearing it, open RetroDeck, run the controller configuration wizard once more while connected via Bluetooth, and let it regenerate clean, uniform `.cfg` templates for the cores.
