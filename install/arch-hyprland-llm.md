# Arch Linux Hyprland

## 1. Snapper vs. Timeshift for Btrfs

**Use Snapper over Timeshift.**

* **Timeshift** was built for RSYNC/Ext4 first and glued onto Btrfs later. It assumes a rigid subvolume layout (`@` and `@home`) and lacks native bootloader integration without external hacks.
* **Snapper** is natively designed for Btrfs. Paired with `snapper-rollback` and `grub-btrfs` (or `limine` / `systemd-boot` snapshot hooks), it handles timeline snapshots, pre/post `pacman` transaction snapshots, and allows instant rollback straight from the bootloader without needing a live USB.

---

## 2. Recommended Partition Scheme (320 GB Dedicated Space)

Do not over-partition. Keep Btrfs subvolumes handling the logical isolation while using a single primary Btrfs partition.

| Partition | Mount Point | Filesystem | Size | Purpose |
| --- | --- | --- | --- | --- |
| `/dev/nvmeXnXp1` | `/boot` | `vfat` (FAT32) | **1 GB - 2 GB** | Shared ESP / EFI Partition for systemd-boot or GRUB |
| `/dev/nvmeXnXp2` | `/` | `btrfs` | **~318 GB** | Btrfs root containing subvolumes |

### Btrfs Subvolume Layout

When formatting `p2`, mount the root Btrfs filesystem and create the following subvolumes:

```bash
@               -> /               (System Root - Snapshot target)
@home          -> /home           (User data - Excluded from root rollback)
@snapshots     -> /.snapshots     (Snapper snapshot store)
@var_log       -> /var/log        (Logs - Prevents bloat in snapshots)
@pkg           -> /var/cache/pacman/pkg (Pacman cache - Excluded from rollback)

```

**Mount Flags:** Use `noatime,compress=zstd:1,ssd,space_cache=v2,subvol=...` on all subvolumes for optimal NVMe performance and compression savings.

---

## 3. TUI Ecosystem Recommendations (Your Stack Extended)

Since you are running a keyboard-driven Hyprland setup, replace traditional GUI utilities with these high-performance CLI/TUI tools:

### Networking & Hardware Connectivity

* **`nmtui-go`** / **`impala`**: Fast BubbleTea-based WiFi manager (modern alternative to default `nmtui`).
* **`bluetui`**: Fast TUI for managing Bluetooth via `bluez`.
* **`caligula`**: User-friendly TUI for flashing OS images to USB drives (`caligula-cli`).

### Audio & System Control

* **`wiremix`**: Modern TUI mixer for PipeWire (your config already binds this to Pulseaudio keybindings).
* **`power-profiles-daemon` / `auto-cpufreq**`: Managed via script hooks or simple CLI toggles.

### File & Disk Management

* **`yazi`** or **`lf`**: High-performance, async terminal file manager with image previews (`kitty` graphics protocol support built-in).
* **`gparted` alternative:** `cfdisk` for partitioning, `ncdu` / `dua-cli` for analyzing disk usage across Btrfs subvolumes.
* **`btop`**: System monitoring (already in your Hyprland waybar bindings).

### Git & Code Operations

* **`lazygit`**: The fastest keyboard-driven Git TUI available.
* **`lazydocker`**: Manage agent execution containers and local AI test environments completely in the terminal.

---

## 4. Direct Manual Installation Steps

### Step 1: Create Btrfs Subvolumes

Assuming your 320 GB target partition is `/dev/nvme0n1p2`:

```bash
# Format Partition
mkfs.btrfs -f -L "ARCH_BTRFS" /dev/nvme0n1p2

# Mount target to set up subvolumes
mount /dev/nvme0n1p2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var_log
btrfs subvolume create /mnt/@pkg
umount /mnt

# Mount subvolumes with zstd compression
MNTOPTS="noatime,compress=zstd:1,ssd,space_cache=v2"
mount -o $MNTOPTS,subvol=@ /dev/nvme0n1p2 /mnt

mkdir -p /mnt/{boot,home,.snapshots,var/log,var/cache/pacman/pkg}
mount -o $MNTOPTS,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o $MNTOPTS,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots
mount -o $MNTOPTS,subvol=@var_log /dev/nvme0n1p2 /mnt/var/log
mount -o $MNTOPTS,subvol=@pkg /dev/nvme0n1p2 /mnt/var/cache/pacman/pkg

# Mount Boot (EFI)
mount /dev/nvme0n1p1 /mnt/boot

```

### Step 2: Bootstrap Minimal Arch Base

```bash
pacstrap -K /mnt base base-devel linux linux-firmware btrfs-progs neovim git networkmanager
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

```

### Step 3: Install Hyprland & Core TUI Tools

```bash
pacman -S hyprland hyprpaper hyprlock hypridle \
         xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
         alacritty rofi-wayland waybar swaync \
         polkit-kde-agent cliphist wl-clipboard \
         nvidia-dkms nvidia-utils \
         pipewire pipewire-audio pipewire-pulse wireplumber \
         snapper snapper-rollback \
         btop lazygit yazi caligula

```

### Step 4: Configure Snapper (Post-Boot)

Once logged into your Arch environment:

```bash
# Unmount and remove auto-created .snapshots directory to let snapper bind the Btrfs subvolume
umount /.snapshots
rm -r /.snapshots

# Initialize snapper root config
snapper -c root create-config /

# Re-mount the dedicated snapshot subvolume
mount -a

# Enable automatic timeline and pre/post pacman snapshots
systemctl enable --now snapper-timeline.timer snapper-cleanup.timer

```

---

#### Recommended Next Move

Once Arch is installed and booted into your Hyprland environment with Snapper configured, you can test local LLMs directly in your terminal using **Ollama** or start running CLI agents against your system.

Ready to pull your local Hyprland dotfiles over and set up Ollama on your RTX 3080?
