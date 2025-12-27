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
