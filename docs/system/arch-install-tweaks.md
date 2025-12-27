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
