This is a classic dual-boot collision, and it is exactly why sharing an ESP (EFI System Partition) between a highly automated distribution like Fedora and a manually configured one like Arch Linux eventually breaks.

Here is exactly what happened under the hood, and how to fix it.

---

## The Diagnostics: Why Did It Break?

Fedora still relies heavily on **GRUB2** by default. When Fedora ran a kernel update, its `kernel-install` scripts and `grubby` ran. Because both OSes share the same EFI partition, Fedora did two things:

1. **Re-registered GRUB as the primary bootloader** in your UEFI NVRAM, displacing `systemd-boot`.
2. **Rewrote the Boot Loader Specification (BLS) entries** inside the EFI partition (`/boot/efi/loader/entries/` or `/efi/loader/entries/`).

Since Fedora expects its own GRUB environment to load those BLS entries, `systemd-boot` (which is still physically there) was either bypassed, or read Fedora's new BLS entries and got utterly confused—showing you only the "rescue" option because it couldn't map Fedora’s actual kernel parameters or find Arch's entries.

---

## The Fix: Taking Control Back from Fedora

You need to boot into a live USB (either Arch or Fedora) to repair this. Once you are booted into a live environment, follow these steps.

1. **Mount your Arch partitions:** From live boot.
Identify your Arch root partition on the 990 Pro (e.g., `/dev/nvme0n1p3` or similar) and your shared EFI partition (e.g., `/dev/nvme0n1p1`). Mount them:

```bash
sudo mount /dev/nvme0n1pX /mnt # Replace X with your Arch root
sudo mount /dev/nvme0n1pY /mnt/boot # Or /mnt/efi, wherever Arch mounts the ESP

```


2. **Chroot into Arch:** Enter your environment.
Use `arch-chroot` to enter your system:

```bash
sudo arch-chroot /mnt

```


3. **Reinstall systemd-boot:** Force NVRAM priority.
Force systemd-boot to reinstall itself to the ESP and set itself as the primary UEFI boot option:

```bash
bootctl install

```

Verify it is active by running `bootctl status`.


4. **Fix the Arch Loader Config:** Verify entries.
Make sure your `/boot/loader/entries/arch.conf` exists and points directly to your Arch root `PARTUUID`:

```ini
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID=XXXX-XXXX rw

```


---

## How to Keep Fedora From Doing This Again

To prevent Fedora's future DNF/kernel updates from hijacking your boot configuration:

### Option A: Force Fedora to use systemd-boot (The Cleanest Path)

Since you are already using `systemd-boot` on Arch, migrate Fedora to it as well.

1. Boot into Fedora.
2. Tell Fedora to stop relying on GRUB and write BLS entries compatible with `systemd-boot`:
```bash
sudo dnf install systemd-boot-unsigned -y
sudo bootctl install

```


3. Remove Fedora's automatic GRUB hooks so it stops fighting over the ESP:
```bash
sudo dnf remove grubby -y
sudo dnf install sdubby -y

```


*Note: `sdubby` acts as a translation layer, telling Fedora's package manager to update `systemd-boot` instead of GRUB when new kernels land.*

### Option B: The "Nuclear" Isolation Path (Highly Recommended)

Because you have a spacious 2 TB drive, **do not share the EFI partition.**

* Use Fedora's original EFI partition *exclusively* for Fedora.
* Shrink your Arch partition by 1 GB, create a **second EFI partition** specifically for Arch, and install `systemd-boot` there.
* Use your motherboard’s UEFI boot menu (F12/F11) to switch between them. This completely isolates both OSes—an update on one can physically never touch the other.
