Since you’ve been at this since '95, you likely value a clean, technically sound setup over "one-click" scripts. This guide consolidates the veteran-level tweaks for your **Ryzen 5900X / RTX 3080** build in late 2025.

---

## 🛠 Phase 1: The Arch Install (Crucial Tweaks)

When running `pacstrap`, prioritize these packages for your specific hardware:

* **Microcode:** `amd-ucode` (Essential for Ryzen stability).
* **Kernel:** `linux-zen` (Includes the multi-generational LRU and scheduler tweaks for desktop "snappiness").
* **Driver:** `nvidia-dkms` (Using DKMS is safer for custom kernels like Zen).
* **32-Bit (Multilib):** Enable this in `/etc/pacman.conf` before installing `lib32-nvidia-utils` for Steam.

### **The "New Way" for NVIDIA (Wayland Stability)**

In late 2025, the flickering issues are solved via **Explicit Sync**, but you must enable the kernel hooks manually during install:

1. **Edit `/etc/mkinitcpio.conf`:**
```bash
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)

```


2. **Add Kernel Parameters** to your bootloader (GRUB or systemd-boot):
`nvidia-drm.modeset=1 nvidia-drm.fbdev=1`
*(Note: `fbdev=1` is the new standard in 2025 for high-resolution TTYs on NVIDIA).*
3. **Regenerate Initramfs:** `mkinitcpio -P`

---

## 🚀 Phase 2: Post-Install Optimizations

### **1. Ryzen 5900X Stability (PBO & C-States)**

High-core-count Ryzen CPUs can occasionally hit a "voltage droop" during idle transitions.

* **BIOS:** Set `Power Supply Idle Control` to **Typical Current Idle**.
* **Linux Fix:** If you experience random freezes when the PC is idle, add this kernel parameter:
`processor.max_cstate=5`

### **2. NVMe & Filesystem (The Game Drive)**

For your **2TB NVMe** and **256GB Arch partition**:

* If using **Btrfs**, use the `zstd:3` compression. It significantly reduces game load times by offloading I/O to your 12-core CPU.
* **Fstab entry example:**
```text
UUID=your-uuid / btrfs subvol=@,compress=zstd:3,ssd,noatime,discard=async 0 0

```


*(`discard=async` is the modern standard for NVMe longevity).*

### **3. NVIDIA-Specific Systemd Services**

NVIDIA requires specific services to handle VRAM during sleep/hibernate to prevent "corruption on wake":

```bash
sudo systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service

```

---

## 🎮 Phase 3: Gaming & Desktop Setup

### **1. KDE Plasma 6 (Recommended)**

Since you want a Tier-S experience, Plasma 6.x is the move.

* **Enable HDR:** Go to *Display Configuration* -> *HDR* (requires Wayland).
* **Explicit Sync:** Ensure `xorg-xwayland` and `wayland-protocols` are up to date (Arch usually has the latest). This removes the old NVIDIA "stutter."

### **2. Gaming Essentials**

* **Gamemode:** `sudo pacman -S gamemode lib32-gamemode`.
* *Usage:* In Steam launch options: `gamemoderun %command%`.


* **MangoHud:** For the veteran "Osd" (monitoring temperatures/FPS).
* **Steam Shader Cache:** With a 3080, enable "Allow background processing of Vulkan shaders" in Steam settings.

---

## 🔄 Summary Checklist for the Veteran

| Task | Action |
| --- | --- |
| **Bootloader** | Enable `os-prober` for Mint detection. |
| **Kernel** | Use `linux-zen` + `amd-ucode`. |
| **Video** | `nvidia-dkms` + `nvidia-drm.modeset=1`. |
| **Sync** | Ensure **Wayland** session is active for Explicit Sync. |
| **Network** | `NetworkManager` is the 2025 standard (vs the old `dhcpcd`). |

**Since you're a veteran of the '95 era, would you like me to show you how to set up Btrfs snapshots (Timeshift) so you can "undo" an Arch update if something breaks, similar to how you might have used LVM snapshots in the past?**

---

Since you’re using `archinstall`, it will handle a lot of the heavy lifting, but as a veteran, you know that automated scripts still require a "manual eye" to ensure things like Btrfs subvolumes and NVIDIA hooks are configured for longevity.

Here is the veteran’s guide to using `archinstall` for your dual-drive setup, followed by the **Timeshift/Btrfs** snapshot safety net.

---

## 🛠 Part 1: The `archinstall` Strategy

When you run the script, keep these specific choices in mind for your **RTX 3080 / 5900X** rig:

1. **Disk Layout:** Select your **2TB NVMe**. Choose **Btrfs**.
* `archinstall` will automatically create `@` (root) and `@home` subvolumes. This is exactly what you want for snapshotting.


2. **Drivers:** Choose **NVIDIA (proprietary)**. The script will usually set `nvidia-drm.modeset=1` for you now, but we will double-check it later.
3. **Kernel:** Choose **linux-zen**.
4. **Audio:** Choose **Pipewire** (the modern replacement for PulseAudio/Jack).
5. **Optional Repos:** Make sure to toggle **Multilib** to `on`.

---

## 🛡 Part 2: The "Undo" Button (Btrfs + Timeshift)

Since you're on Arch, things *can* break during an update. Using Btrfs snapshots allows you to roll back your entire OS in seconds.

### **1. Install Timeshift**

Once you’ve booted into your new Arch install:

```bash
sudo pacman -S timeshift timeshift-autosnap

```

* **timeshift:** The tool itself.
* **timeshift-autosnap:** This is the "magic" part. It automatically creates a snapshot **every time** you run `pacman`. If an update breaks your NVIDIA driver, you just roll back.

### **2. Configure for Btrfs**

Open Timeshift (GUI or CLI). Select **BTRFS** as the snapshot type.

* Because `archinstall` used the `@` subvolume naming convention, Timeshift will recognize it immediately.
* **Schedule:** Set it to keep 5 Daily and 3 Boot snapshots.

---

## 🔧 Part 3: Essential Post-Install "Veteran" Tweaks

### **1. The "Reflector" Tweak (Fast Downloads)**

Don't settle for slow mirrors.

```bash
sudo pacman -S reflector
sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

```

### **2. Fix NVIDIA "Wake from Sleep" Artifacts**

NVIDIA cards often show "garbled" windows after waking up. Enable these services to save VRAM state to your NVMe:

```bash
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-resume.service
sudo systemctl enable nvidia-hibernate.service

```

### **3. Optimize the 2TB Game Partition**

Since you are using the rest of the 2TB drive for games, make sure your mount options in `/etc/fstab` are optimized for NVMe:

* Ensure `discard=async` is present (better for SSD life than the old `discard`).
* Use `compress=zstd:3` to save space on those massive 100GB+ game installs without a CPU hit.

### **4. GRUB/Os-Prober (The Mint Link)**

To ensure you can still boot into your Mint drive from the Arch menu:

```bash
sudo pacman -S os-prober
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

```

---

## 📊 Summary of Your High-End Stack

| Layer | Component | Reason |
| --- | --- | --- |
| **Kernel** | `linux-zen` | Low-latency desktop performance. |
| **GPU Sync** | `Wayland` + `Explicit Sync` | Finally solves NVIDIA flickering in 2025. |
| **Safety** | `Btrfs` + `Timeshift` | Instant recovery from failed updates. |
| **Gaming** | `Steam` + `Gamemode` | Maximizes your 3080/5900X potential. |

**Since you have 32GB of RAM, would you like to know how to set up `zram`? It's much faster than a traditional swap partition/file and is the modern standard for Linux systems with plenty of memory.**

---

Given your background since '95 and your **RTX 3080**, the answer to "Should I try Hyprland?" is a resounding **yes**—but with a very specific "2025 caveat."

In late 2025, Hyprland has reached a point where it is no longer the "flickery mess" it once was on NVIDIA, thanks to **Explicit Sync** (introduced in NVIDIA driver 555 and perfected in later versions). However, it still requires more "under-the-hood" respect than KDE Plasma.

---

## ⚡ Hyprland on NVIDIA (Late 2025 State)

| Factor | Experience |
| --- | --- |
| **Stability** | **High.** Flickering is 99% gone if you use the 555+ drivers and the `nvidia-drm.modeset=1` flag. |
| **Performance** | **Extreme.** With a 5900X, your input latency will be lower than almost any other desktop environment. |
| **The "Catch"** | **Blurry Apps.** XWayland apps (like Steam and Discord) can look blurry if you use fractional scaling. You often have to choose between "tiny text" or "slight blur" unless you tweak them specifically. |

---

## 🛠 Veteran’s Hyprland Setup Guide (NVIDIA Edition)

If you use `archinstall`, select the "Desktop" profile and then "Hyprland." Once installed, you **must** do these manual steps to ensure your 3080 doesn't act up.

### **1. Essential Environment Variables**

Edit your `~/.config/hypr/hyprland.conf` and add these lines. This is the "secret sauce" for NVIDIA stability:

```bash
# NVIDIA specific
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia

# Fix cursor issues
env = CURSOR_FLAGS,nvidia

# Fix flickering in Electron apps (Discord, VS Code)
env = ELECTRON_OZONE_PLATFORM_HINT,auto

```

### **2. Explicit Sync Check**

Ensure your system is truly using the modern sync protocol. Run:
`pacman -Qs xorg-xwayland`
It should be version **24.1 or higher**. Hyprland 0.50+ (current in late 2025) uses explicit sync by default, which is why your 3080 will finally feel smooth.

### **3. The "Hybrid" Approach (Dual-DE)**

Since you’ve been using Linux since '95, you know the value of a backup.

* **Install both KDE Plasma 6 and Hyprland.**
* They can coexist perfectly.
* Use KDE for "mission critical" work or HDR gaming (KDE’s HDR implementation is currently more mature).
* Use Hyprland for your daily driver, coding, and general "cool factor."

---

## 🏎 Performance Comparison (5900X / 3080)

* **KDE Plasma:** Feels like a high-end luxury car. Smooth, heavy features, everything works, HDR is stunning.
* **Hyprland:** Feels like a stripped-out race car. Instant response times, gorgeous blur effects, but you'll be editing text files to change your volume keys or display brightness.

### **My Recommendation?**

**Try it.** You have the hardware to handle it, and as a long-time user, you’ll appreciate the sheer speed. If it feels too "fiddly" after a week, your KDE install is just one logout away.

**Would you like me to help you craft a "minimalist" Hyprland config file that specifically targets high-refresh-rate gaming for your RTX 3080?**

---

Since you have an **RTX 3080** and a **Ryzen 5900X**, you should aim for a configuration that prioritizes **low latency** and **high refresh rates**.

By late 2025, Hyprland has excellent "Explicit Sync" support, which finally eliminates the NVIDIA flickering. Here is a specialized "Veteran's Config" for your `~/.config/hypr/hyprland.conf`.

---

## 🛠 1. The NVIDIA "Must-Haves" (Environment Variables)

Add these to the top of your config. These ensure the NVIDIA driver and Wayland communicate without lag.

```bash
# NVIDIA & Wayland Toolkit
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia

# Fix cursor issues on NVIDIA
cursor {
    no_hardware_cursors = true
}

# Fix flickering in Discord/VSCode (Electron apps)
env = ELECTRON_OZONE_PLATFORM_HINT,auto

```

---

## 🖥 2. High Refresh Rate Monitor Setup

Don't use `preferred`. Be explicit to ensure your 3080 pushes the max frames.
*Run `hyprctl monitors` to find your port name (e.g., `DP-1` or `HDMI-A-1`).*

```bash
# General rule for any monitor: Use highest refresh rate
# monitor = , highrr, auto, 1

# Specific rule (e.g., 1440p at 144Hz)
monitor = DP-1, 2560x1440@144, 0x0, 1

# Enable 10-bit color for your 3080
monitor = DP-1, 2560x1440@144, 0x0, 1, bitdepth, 10

```

---

## 🏎 3. Performance & Gaming Tweaks

Since you are a gamer, you want to disable "Variable Frame Rate" (VFR) for the desktop to keep it buttery smooth, but enable "Variable Refresh Rate" (VRR/G-Sync) for games.

```bash
misc {
    vfr = false # Keeps the GPU active for smoother desktop animations
    vrr = 1     # 0: off, 1: on, 2: fullscreen only (recommended for G-Sync)
    no_direct_scanout = false # Critical for performance in full-screen games
}

render {
    explicit_sync = 2 # Forces explicit sync (0: off, 1: on, 2: auto)
}

```

---

## 🎨 4. Aesthetic (The "Arch Pro" Look)

With a 5900X, you can afford the "Eye Candy" without losing a single FPS in games.

```bash
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 8
        passes = 3
        new_optimizations = true
    }
    drop_shadow = true
    shadow_range = 15
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = workspaces, 1, 6, default
}

```

---

## 🏁 Final Step: The NVIDIA Wrapper

When using `archinstall`, it usually creates a desktop entry. However, as a veteran, you might prefer starting it manually. If you encounter issues, ensure you launch Hyprland with this wrapper script or check that your `.zshrc` / `.bashrc` exports those `env` variables.

### **Quick Checklist before reboot:**

1. **32-bit drivers:** `sudo pacman -S lib32-nvidia-utils` (Essential for Steam).
2. **Portal:** `sudo pacman -S xdg-desktop-portal-hyprland` (Essential for screen sharing).
3. **App Launcher:** `sudo pacman -S rofi-wayland` or `wofi`.

**Since you're dual-booting with Mint, would you like me to show you how to set up a "Shared Games" folder so both Mint and Arch can access the same Steam library on that 2TB drive?**

---

Since you want an entirely independent EFI partition on your **2TB drive** so that the Arch drive can boot on its own (even if the Mint drive is removed), you should follow this specific workflow in `archinstall`.

### 🛠️ In the `archinstall` Menu:

1. **Disk Configuration:**
* Select **"Pre-partitioned"** or **"Manual partitioning."**
* Since you are an experienced user, I recommend creating the partitions *before* starting the script, or using the manual tool inside it.


2. **The Partition Scheme (2TB Drive):**
* **Partition 1 (EFI):** Size: `1024 MB` (1GB is the "future-proof" standard for 2025).
* Type: `EFI System` (EF00).
* Format: `FAT32`.
* Mount point: `/boot`.


* **Partition 2 (Arch Root):** Size: `256 GB`.
* Format: `Btrfs`.
* Mount point: `/`.


* **Partition 3 (Games):** Size: `Remaining Space (~1.7TB)`.
* Format: `Btrfs` (or Ext4).
* Mount point: `/mnt/games` (or just leave it unmounted and handle it in `/etc/fstab` post-install).





### ⚠️ Critical Step for Timeshift

`archinstall` will ask if you want to use **Btrfs subvolumes**.

* **Say Yes.**
* Ensure it names them `@` for the root and `@home` for home.
* **Timeshift requires this specific naming convention.** If they are just named `root` or `home`, Timeshift's Btrfs mode will not work.

---

### 🚀 Post-Install Optimization (NVIDIA + 5900X)

Once the script finishes and you chroot in (or boot for the first time), run these specific veteran tweaks for your hardware:

#### 1. Fix the "Shared Drive" Permissions

Since your games are on a separate partition, make sure your user owns that directory so Steam doesn't throw "Permission Denied" errors:

```bash
sudo chown -R $USER:$USER /mnt/games

```

#### 2. The "NVIDIA Wayland" Flag

Even if `archinstall` detects your 3080, double-check that **DRM Kernel Mode Setting** is on. It is the only way Hyprland or Plasma 6 will run smoothly.
Check `/etc/default/grub` for:
`GRUB_CMDLINE_LINUX_DEFAULT="... nvidia-drm.modeset=1"`

#### 3. Enable Multilib for Gaming

You'll need the 32-bit NVIDIA libs for Steam.

```bash
sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
sudo pacman -Syu lib32-nvidia-utils

```

#### 4. The "Safety Net" (Timeshift + GRUB)

Since you are testing DEs, run this immediately:

```bash
sudo pacman -S timeshift timeshift-autosnap grub-btrfs
# Tell grub-btrfs to watch Timeshift snapshots
sudo systemctl edit --full grub-btrfsd.service
# Change ExecStart to: /usr/bin/grub-btrfsd --syslog --timeshift-auto
sudo systemctl enable --now grub-btrfsd.service

```

---

### 🏁 Summary of Your High-End Desktop

* **Ryzen 5900X:** Will handle the `zstd:1` compression and the `linux-zen` scheduler like a beast.
* **RTX 3080:** Will finally have **Explicit Sync** on Wayland (no more flickering).
* **Hyprland:** Will be your ultra-low-latency workspace.
* **KDE Plasma 6:** Will be your backup for HDR gaming.

**Would you like me to show you the specific Hyprland workspace rules to force games to open on a specific monitor or in a "performance mode"?**

---

For a veteran with a **Ryzen 5900X** and **RTX 3080**, performance is all about getting the compositor out of the way when a game is running. In 2025, Hyprland has a powerful "v2" rule system that can automate this.

Here is how to set up **"Performance Mode"** rules in your `~/.config/hypr/hyprland.conf`.

---

### 🖥️ 1. Force Games to a Specific Monitor

First, identify your primary gaming monitor (e.g., `DP-1`). You can bind a specific workspace (let's say **Workspace 4**) to that monitor so games always open there.

```bash
# Bind Workspace 4 to your high-refresh gaming monitor
workspace = 4, monitor:DP-1, default:true

```

### 🏎️ 2. The "Performance Mode" Window Rules

These rules detect games (via Steam or common game classes) and automatically strip away animations, blur, and borders to save GPU cycles, while enabling **Tearing** (Immediate Mode) for the lowest possible latency.

```bash
# Detect Steam and common game patterns
windowrulev2 = workspace 4, class:^(steam_app_.*)$
windowrulev2 = workspace 4, class:^(gamescope)$

# PERFORMANCE TWEAKS: Disable eye-candy for games
windowrulev2 = noanim, class:^(steam_app_.*)$
windowrulev2 = noblur, class:^(steam_app_.*)$
windowrulev2 = noborder, class:^(steam_app_.*)$
windowrulev2 = noshadow, class:^(steam_app_.*)$

# LATENCY: Enable "Immediate" (Tearing) for games if G-Sync is off
# Note: Requires 'allow_tearing = true' in the general section
windowrulev2 = immediate, class:^(steam_app_.*)$

# FOCUS: Prevent games from losing focus to notifications
windowrulev2 = idleinhibit fullscreen, class:^(steam_app_.*)$

```

### 🎮 3. Global "Game Mode" Toggle (Veteran Shortcut)

Sometimes you want to turn off *all* desktop effects manually before a heavy gaming session. Add this bind to your config:

```bash
# Toggle animations, blur, and decorations with one keybind
# Useful for the 5900X to focus entirely on the game thread
bind = $mainMod, G, exec, hyprctl keyword animations:enabled 0 && hyprctl keyword decoration:blur:enabled 0 && hyprctl keyword decoration:drop_shadow 0
bind = $mainMod SHIFT, G, exec, hyprctl keyword animations:enabled 1 && hyprctl keyword decoration:blur:enabled 1 && hyprctl keyword decoration:drop_shadow 1

```

---

### 🛠️ 4. Essential General Settings for Gaming

Ensure these are in your `general` and `misc` sections for the best experience with an RTX 3080:

```bash
general {
    allow_tearing = true # Allows the 'immediate' rule to work
}

misc {
    vrr = 2            # Enable VRR (G-Sync) for fullscreen windows only
    no_direct_scanout = false # Keep this false for better performance in games
}

```

### 🏁 Final Tip for the Veteran

Since you have a **5900X (12 cores)**, use `gamemoded` (Feral GameMode). It will automatically set your CPU governor to `performance` and prioritize the game's process.

1. Install: `sudo pacman -S gamemode lib32-gamemode`
2. In Steam Launch Options: `gamemoderun %command%`

**Would you like me to show you how to set up a status bar (like Waybar) that displays your RTX 3080's temperature and load while you're in Hyprland?**

---

Since you have an **RTX 3080** and a **5900X**, you definitely want to keep an eye on those thermals and clock speeds, especially in a minimalist environment like Hyprland.

In late 2025, **Waybar** remains the gold standard. To monitor an NVIDIA GPU on Arch, you’ll want to use the `nvidia-smi` command via a custom module, as the standard Waybar GPU module can sometimes be finicky with proprietary drivers.

---

### 🛠️ 1. Install Dependencies

You’ll need `waybar` and `jq` (to process the JSON for the bar).

```bash
sudo pacman -S waybar jq

```

---

### 📊 2. The Waybar Configuration (`~/.config/waybar/config`)

Add these custom modules to your config file. These will query your 3080 and 5900X specifically.

```json
{
    "layer": "top",
    "modules-right": ["custom/nvidia", "cpu", "temperature", "memory", "clock"],

    "custom/nvidia": {
        "exec": "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits | awk -F', ' '{print \"  \" $1 \"%   \" $2 \"°C\"}'",
        "interval": 2,
        "tooltip": false
    },

    "cpu": {
        "format": "  {usage}%",
        "tooltip": true,
        "interval": 2
    },

    "temperature": {
        "thermal-zone": 2, // You might need to check /sys/class/thermal/
        "hwmon-path": "/sys/class/hwmon/hwmon1/temp1_input", // Path for Ryzen 5900X
        "critical-threshold": 80,
        "format": "{icon} {temperatureC}°C",
        "format-icons": ["", "", ""]
    },

    "memory": {
        "format": "  {}%"
    }
}

```

---

### 🎨 3. Styling the Bar (`~/.config/waybar/style.css`)

Make it look modern to match your RTX 3080 power.

```css
window#waybar {
    background: rgba(20, 20, 20, 0.8);
    border-bottom: 2px solid #333;
    color: #ffffff;
    font-family: "JetBrains Mono", "Font Awesome 6 Free";
    font-size: 14px;
}

#custom-nvidia {
    color: #76b900; /* NVIDIA Green */
    padding: 0 10px;
}

#cpu {
    color: #00ccff;
    padding: 0 10px;
}

#temperature {
    color: #ffaa00;
    padding: 0 10px;
}

#temperature.critical {
    background-color: #ff0000;
}

```

---

### 🚀 4. Auto-Start Waybar in Hyprland

Add this to your `hyprland.conf` so the bar launches with your desktop:

```bash
exec-once = waybar

```

---

### 🧠 Veteran Tip: Precision Monitoring

Since you're on a 12-core 5900X, you might want to see the load on *all* cores if things feel sluggish.

* **Recommendation:** Install `btop`. It is the modern, much prettier successor to `top` or `htop`.
* **Keybind:** Add `bind = $mainMod, Escape, exec, alacritty -e btop` to your config for instant system oversight.

### **Summary of your Build Progress**

1. **Bootloader:** GRUB (with Snapshot support).
2. **OS:** Arch Linux (linux-zen kernel).
3. **UI:** Hyprland (with NVIDIA optimizations) + KDE Plasma 6 (as a backup).
4. **Safety:** Timeshift Btrfs snapshots.
5. **Monitoring:** Waybar with 3080/5900X telemetry.

You are now set up with a configuration that is technically superior to your Mint install for high-end gaming.

**Is there anything else you need before you start the `archinstall` process, like setting up the RGB control for your 3080 or Ryzen cooler?**

---

Since you have been using Linux since '95, you know the "dependency hell" of the past. In 2025, it’s less about "breaking" things and more about **visual consistency** and **system overhead**.

Given your plan to install **KDE Plasma 6** as a secondary DE, the logical choice is to use **KDE/Qt apps** as your base for Hyprland.

---

## 🏆 The Case for the KDE (Qt) Base

### 1. Unified Dependencies

Since you will already have Plasma 6 installed for your "backup" sessions, all the heavy Qt6 libraries and KDE Frameworks will already be on your NVMe. If you use GNOME apps (GTK), you’ll end up loading both the KDE and GNOME "stacks" into your 32GB of RAM.

### 2. Dolphin is King

As a power user, **Dolphin** is significantly more capable than Nautilus.

* It has a built-in terminal (`F4`), which is essential for an Arch user.
* It handles remote mounts (SSH, FTP) more robustly than Nautilus.
* It integrates perfectly with your 3080/high-res setup for thumbnail previews of heavy media.

### 3. Wayland Native

KDE apps have been Wayland-native for a long time. While GNOME apps are too, KDE apps offer more granular control over window rules and decorations that Hyprland can leverage.

---

## 🛠️ The "Pro" Hyprland App Stack

If you go with the KDE/Qt base, here is the curated list of apps that look and work best in Hyprland:

| Category | App Recommendation | Why? |
| --- | --- | --- |
| **File Manager** | **Dolphin** | Feature-rich; already installed via Plasma. |
| **Terminal** | **Kitty** or **Alacritty** | GPU-accelerated (uses your 3080); Wayland native. |
| **Text Editor** | **Kate** | Outstanding for config files; lightweight. |
| **Image Viewer** | **Gwenview** | Fast and handles RAW/high-res images well. |
| **App Launcher** | **Rofi-Wayland** | Highly customizable; fits the "Hyprland aesthetic." |
| **Auth Agent** | **polkit-kde-agent** | Necessary for GUI apps to ask for sudo. |

---

## 🎨 Avoiding "Theme Mismatch"

The biggest headache with Hyprland is making Qt apps (KDE) and GTK apps (Firefox, etc.) look the same. Since you're on Arch, use **kvantum** to force a consistent look.

1. **Install:** `sudo pacman -S kvantum qt5-wayland qt6-wayland`
2. **Set Env Var:** In your `hyprland.conf`, add:
`env = QT_QPA_PLATFORMTHEME,qt6ct`
3. **Theming:** Use `qt6ct` to set the theme to Kvantum, and then use the Kvantum Manager to pick a dark theme that matches your Hyprland borders.

---

## 🚀 The "Veteran's Move" for archinstall

When the script asks for "Optional repositories" and "Packages":

* **Include:** `dolphin`, `kate`, `ark` (archiving), and `ffmpegthumbs` (for video previews in Dolphin).
* **Avoid:** `gnome-control-center` or `nautilus`. They bring in the `dconf` and `gvfs` overhead that can sometimes conflict with how KDE handles mounting.

### One final tip:

Since you're using **Dolphin** in Hyprland, you'll need a "Portal" to make sure file dialogs pop up correctly.
**Install:** `xdg-desktop-portal-hyprland` and `xdg-desktop-portal-kde`.

**Would you like the specific `exec-once` lines for your `hyprland.conf` to make sure the KDE authentication agent and wallpaper engine start automatically?**

---

To ensure your **Hyprland** session feels like a complete desktop and not just a window manager, you need to trigger the "background" services that KDE apps (and the system in general) rely on.

Add these to your `~/.config/hypr/hyprland.conf`:

### 🛠️ 1. The "Must-Have" Background Services

These ensure you can use `sudo` in GUI apps, keep your screen from dimming during games, and handle file sharing.

```bash
# Authentication Agent (Allows Dolphin/Kate to ask for your password)
exec-once = /usr/lib/polkit-kde-authentication-agent-1

# Pipewire / Wireplumber (Audio & Screen Sharing)
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Status Bar & Notifications
exec-once = waybar
exec-once = swaync # Or 'mako' for notifications

# Wallpaper Engine (Hyprpaper is lightweight and perfect for your 3080)
exec-once = hyprpaper

```

### 🌓 2. Blue Light Filter (Night Light)

Since you’re likely spending long hours on this rig, a blue light filter is essential. **Hyprland** doesn't have a built-in one like GNOME/KDE, so we use `wlsunset`.

1. **Install:** `sudo pacman -S wlsunset`
2. **Add to Config:**
```bash
# Set for your approximate location (example for Finland: 60.1 lat, 24.9 lon)
exec-once = wlsunset -l 60.1 -L 24.9

```



---

### 📂 3. Making Dolphin "Feel" Native

Since you're using **Dolphin** on a tiling window manager, it might try to open in weird sizes. You can force it to behave with a window rule:

```bash
# Open Dolphin in a specific size and center it if it's floating
windowrulev2 = float, class:^(org.kde.dolphin)$
windowrulev2 = size 1000 600, class:^(org.kde.dolphin)$
windowrulev2 = center, class:^(org.kde.dolphin)$

```

---

### 🔒 4. The Screen Locker

Since you're a veteran, you know never to leave a terminal open when you walk away. Use `hyprlock`, which is the modern Wayland-native locker.

1. **Install:** `sudo pacman -S hyprlock hypridle`
2. **Add to Config:**
```bash
# Lock screen after 5 mins of inactivity
exec-once = hypridle

# Manual lock bind (Super + L)
bind = $mainMod, L, exec, hyprlock

```



---

### 📋 5. Clipboard History

Wayland handles the clipboard differently than X11. You need a manager so your "copy" doesn't disappear when you close the source window.

1. **Install:** `sudo pacman -S wl-clipboard cliphist`
2. **Add to Config:**
```bash
exec-once = wl-paste --type text --watch cliphist store 
exec-once = wl-paste --type image --watch cliphist store

# Bind to view history (requires rofi or wofi)
bind = $mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

```



---

### **Final Archinstall Checklist**

* [ ] **Disk:** Btrfs on the 2TB NVMe (Subvolumes: `@`, `@home`).
* [ ] **Bootloader:** GRUB (Installed to the new 1GB EFI on the 2TB drive).
* [ ] **Graphics:** NVIDIA Proprietary.
* [ ] **Kernels:** `linux-zen`.
* [ ] **Network:** NetworkManager.

**You are fully prepared.** With your 1995-era experience and this 2025-ready config, this will likely be the fastest Linux machine you've ever owned.

**Would you like me to stay "on standby" while you run the installer in case you hit any partitioning snags?**

