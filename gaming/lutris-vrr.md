Because you are running non-Steam Assassin’s Creed Valhalla via Lutris/Ubisoft Connect on GNOME Wayland with an RTX 3080, GNOME is dropping VRR due to **Direct Scanout bypassing failure** on the XWayland layer. Games launched through secondary launchers inside Wine/Proton often run in borderless windowed modes or multi-window XWayland wrappers, which breaks GNOME Mutter's VRR detection.

Here is how to force VRR (G-Sync/FreeSync) to engage:

---

### Step 1: Wrap Lutris Launch with Gamescope (Direct Scanout Bypass)

Gamescope creates a dedicated Wayland nested compositor surface. It forces AC Valhalla into true exclusive fullscreen and exposes a direct DRM surface to GNOME so VRR stays active.

1. **Install Gamescope:**
```bash
sudo apt install gamescope

```


2. **Configure Gamescope inside Lutris:**
* Open **Lutris**.
* Right-click **Assassin's Creed Valhalla** → **Configure**.
* Go to the **System options** tab.
* Scroll down to **Command prefix** and add:
```bash
gamescope -w 2560 -h 1440 -r 144 -f --

```


*(Adjust `2560`, `1440`, and `144` to match your monitor's exact resolution and refresh rate).*



---

### Step 2: Set NVIDIA Direct Wayland Environment Flags in Lutris

Force Wine and DXVK inside Lutris to bypass legacy X11 presentation layers.

1. In Lutris, right-click **AC Valhalla** → **Configure** → **Environment variables** tab.
2. Add the following key-value pairs:

| Variable | Value |
| --- | --- |
| `PROTON_ENABLE_WAYLAND` | `1` |
| `__GL_GSYNC_ALLOWED` | `1` |
| `__GL_VRR_ALLOWED` | `1` |
| `MESA_VK_WSI_PRESENT_MODE` | `mailbox` |

---

### Step 3: In-Game Display Settings

Inside Assassin's Creed Valhalla's graphics menu:

* **Window Mode:** Set explicitly to **Fullscreen** (do *not* leave it on Borderless Window).
* **V-Sync:** Turn **OFF** in-game. (Leaving in-game V-Sync enabled caps the frame rate statically and overrides G-Sync/VRR dynamics).
* **FPS Limit:** If you want to prevent tearing at the maximum refresh rate, set an in-game frame limiter to 3 FPS below your max refresh rate (e.g., **141 FPS** for a 144Hz panel).

---

### Step 4: Verify VRR is Active

To verify G-Sync/VRR is actually stepping frequencies while playing, open a terminal before launching the game and watch your display frequency update:

```bash
watch -n 0.5 "cat /sys/class/drm/card0-*-*/attr/vrr_enabled 2>/dev/null || nvidia-smi -q -d CLOCK | grep -i graphics"

```
