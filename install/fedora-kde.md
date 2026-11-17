**Snapper + Btrfs Assistant + `grub-btrfs**` is objectively superior to Timeshift on Fedora 45:

* **Zero rigid subvolume constraints:** Timeshift forces Ubuntu-style `@` and `@home` naming and cannot easily exclude heavy creative caches without messy workarounds. Snapper works natively with Fedora's default `root` and `home` subvolumes.
* **Automatic DNF5 pre/post hooks:** Snapper hooks directly into `libdnf5-plugin-actions` to take automatic before/after snapshots whenever you update kernels, Nvidia drivers, or KDE packages.
* **Bootable rollbacks:** Paired with `grub-btrfs`, your snapshots appear directly in the GRUB boot menu so you can boot into a working state if an Nvidia/kernel update ever breaks display output.
* **Full GUI control:** `btrfs-assistant` gives you a clean Qt/KDE-native GUI to browse, diff, delete, and restore Snapper snapshots without touching the CLI.

---

### Part 1: Prepare & Partition `/dev/nvme0n1` in the Installer

First, verify your exact partition layout before wiping anything so you don't touch your 1.68 TB `ext4` games/storage partition.

1. **Boot the Fedora 45 KDE Plasma Live USB** and launch **Install to Hard Drive** (Anaconda).
2. Select your language and keyboard layout, then click **Installation Destination**.
3. Under **Local Standard Disks**, select **only the 2 TB Samsung 990 Pro** (`nvme0n1`). Leave the 1 TB Samsung 980 unchecked.
4. Under **Storage Configuration**, select **Custom** and click **Done**.
5. In the Manual Partitioning screen, expand your existing Fedora installation on the left panel:
* **Keep untouched:** Select your ~1.68 TB `ext4` partition. Verify **Reformat** is **unchecked**. (Optional: set its mount point to `/mnt/storage` now, or add it via `fstab` later.)
* **Delete old OS partitions:** Delete the old `/boot/efi` (~600 MB), `/boot` (~1–2 GB), and the ~318 GB Btrfs root/home partitions inside that 320 GB block.


6. Create the new partitions inside that freed ~320 GB space:
* **EFI System Partition:** Click `+` → Mount Point: `/boot/efi` | Desired Capacity: `600 MiB` | Device Type: `Standard Partition` | File System: `EFI System Partition`.
* **Boot Partition:** Click `+` → Mount Point: `/boot` | Desired Capacity: `2048 MiB` (2 GB ensures plenty of space for multiple kernels + Nvidia `initramfs` images) | Device Type: `Standard Partition` | File System: `ext4`.
* **Root Subvolume:** Click `+` → Mount Point: `/` | Desired Capacity: leave blank (uses remaining free space of the 320 GB block) | Device Type: `Btrfs`.
* **Home Subvolume:** Click `+` → Mount Point: `/home` | Device Type: `Btrfs` (it automatically shares the same Btrfs pool).
* *(Optional — Recommended for Creators)* **Separate Var/Log Subvolume:** Click `+` → Mount Point: `/var/log` | Device Type: `Btrfs` (prevents log files from rolling back when you restore a `/` snapshot).


7. Click **Done** → **Accept Changes** → **Begin Installation**.
* *Verification:* The summary popup shows **only** the 320 GB OS partitions being created/formatted, while your 1.68 TB `ext4` partition is untouched.



---

### Part 2: Post-Install Nvidia RTX 3080 & System Setup

Boot into your new Fedora 45 KDE Plasma desktop, open **Konsole**, and run the following commands to update the system and install proprietary Nvidia drivers and multimedia codecs:

```bash
# 1. Update base system
sudo dnf upgrade --refresh -y

# 2. Enable RPM Fusion (Free + Nonfree)
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# 3. Install Nvidia RTX 3080 drivers + CUDA support (for Blender/Resolve)
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda

# 4. Install full hardware-accelerated multimedia codecs
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf group upgrade -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

```

Wait ~3 minutes for the `akmod-nvidia` background kernel module build to finish, then verify before rebooting:

```bash
modinfo -F version nvidia

```

* *Verification:* If it outputs a driver version number (e.g., `570.xx` or `575.xx`) instead of `modinfo: ERROR: Module nvidia not found`, reboot now (`sudo reboot`). After rebooting, run `nvidia-smi` to confirm your RTX 3080 is active.

---

### Part 3: Configure Snapper, `btrfs-assistant`, DNF5 Hooks & `grub-btrfs`

Run these commands in **Konsole** to set up automated snapshots and GRUB boot entries:

#### 1. Install Snapper, Btrfs Assistant, and Dependencies

```bash
sudo dnf install -y snapper btrfs-assistant libdnf5-plugin-actions git make inotify-tools

```

#### 2. Initialize Snapper for `/` (and Optionally `/home`)

```bash
# Create root snapshot config
sudo snapper -c root create-config /

# Fix SELinux context for /.snapshots
sudo restorecon -Rv /.snapshots

```

*(Note: Avoid creating timeline snapshots for `/home` if you store large Krita/Blender/raw video files there, as snapshots lock disk blocks when files are deleted. Keep your large project files on your 1.68 TB `ext4` partition or the 1 TB Samsung 980.)*

#### 3. Tune Retention Limits (Prevents 320 GB Partition Fill-Up)

Open `/etc/snapper/configs/root`:

```bash
sudo nano /etc/snapper/configs/root

```

Set these sensible limits so snapshots don't eat your 320 GB drive:

```ini
TIMELINE_CREATE="yes"
TIMELINE_LIMIT_HOURLY="3"
TIMELINE_LIMIT_DAILY="5"
TIMELINE_LIMIT_WEEKLY="2"
TIMELINE_LIMIT_MONTHLY="1"
TIMELINE_LIMIT_YEARLY="0"
NUMBER_LIMIT="10"
NUMBER_LIMIT_IMPORTANT="10"
EMPTY_PRE_POST_CLEANUP="yes"

```

Save (`Ctrl+O`, `Enter`) and exit (`Ctrl+X`), then enable the timers:

```bash
sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer

```

#### 4. Hook Snapper into DNF5 Updates

Fedora 45 uses DNF5 (`libdnf5-plugin-actions`) rather than the legacy DNF4 snapper plugin. Create `/etc/dnf/libdnf5-plugins/actions.d/snapper.actions`:

```bash
sudo mkdir -p /etc/dnf/libdnf5-plugins/actions.d
sudo tee /etc/dnf/libdnf5-plugins/actions.d/snapper.actions > /dev/null << 'EOF'
# Take pre/post snapshots on package transactions
pre_transaction::::/usr/bin/snapper create --type=pre --cleanup-algorithm=number --print-number --description="dnf5: ${command}" > /tmp/snapper_pre_id
post_transaction::::/usr/bin/snapper create --type=post --cleanup-algorithm=number --pre-number=$(cat /tmp/snapper_pre_id) --description="dnf5: ${command}" ; rm -f /tmp/snapper_pre_id
EOF

```

#### 5. Install `grub-btrfs` for Bootable Snapshots

```bash
cd /tmp
git clone https://github.com/Antynea/grub-btrfs.git
cd grub-btrfs
sudo make install

```

Configure `grub-btrfs` for Fedora's `/boot/grub2` path:

```bash
sudo sed -i 's|#GRUB_BTRFS_GRUB_DIRNAME="/boot/grub"|GRUB_BTRFS_GRUB_DIRNAME="/boot/grub2"|g' /etc/default/grub-btrfs/config
sudo sed -i 's|#GRUB_BTRFS_MKCONFIG=/usr/bin/grub-mkconfig|GRUB_BTRFS_MKCONFIG=/sbin/grub2-mkconfig|g' /etc/default/grub-btrfs/config
sudo sed -i 's|#GRUB_BTRFS_SCRIPT_CHECK=grub-script-check|GRUB_BTRFS_SCRIPT_CHECK=grub2-script-check|g' /etc/default/grub-btrfs/config

sudo restorecon -Rv /etc/grub.d/41_snapshots-btrfs
sudo snapper -c root create --description "Initial clean install"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo systemctl enable --now grub-btrfsd.service

```

* *Verification:* Run `sudo snapper list` — you should see snapshot `#1` (`Initial clean install`). Open **Btrfs Assistant** from your KDE Application Launcher to verify the GUI detects your `root` subvolume and snapshot. When you reboot, a **Fedora Linux snapshots** submenu will appear in GRUB.

---

### Part 4: Remount Your 1.68 TB `ext4` Storage Partition

1. Find the `UUID` of your 1.68 TB `ext4` partition:
```bash
lsblk -f

```


2. Create a mount point and take ownership:
```bash
sudo mkdir -p /mnt/storage
sudo chown -R $USER:$USER /mnt/storage

```


3. Add it to `/etc/fstab` (replace `YOUR-UUID-HERE` with the actual UUID):
```bash
echo 'UUID=YOUR-UUID-HERE  /mnt/storage  ext4  defaults,noatime  0  2' | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
sudo mount -a

```


* *Verification:* Run `df -h /mnt/storage` — it should show your ~1.68 TB partition mounted cleanly with all your existing games and files intact.
