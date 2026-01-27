
***

# 01 - Operating System Setup Guide

## Table of Contents
1.  [Philosophy & Rationale](#philosophy--rationale)
2.  [Preparation](#preparation)
3.  [Windows 11 Installation](#windows-11-installation)
4.  [Fedora Linux (KDE Plasma) Installation](#fedora-linux-kde-plasma-installation)
5.  [Post-Installation Steps](#post-installation-steps)
6.  [GRUB Bootloader Notes](#grub-bootloader-notes)

## Philosophy & Rationale

This setup follows a "Right Tool for the Right Job" approach:
*   **Windows 11:** Serves as the **Production OS**. It is used for tasks that benefit from its superior hardware support, specifically:
    *   GPU-accelerated video editing in DaVinci Resolve (with full CUDA and NVENC support).
    *   Using the licensed Affinity Suite (Photo, Designer, Publisher).
    *   High-performance gaming with full HDR and VRR support on the Samsung Q70A TV.
    *   Uncompromised HDMI 2.1 functionality.
*   **Fedora Linux (KDE Plasma):** Serves as the **Daily Driver & Tinkering OS**. It is used for:
    *   Learning open-source creative tools (Kdenlive, Darktable).
    *   General computing, web browsing, and coding.
    *   Safe experimentation and tinkering in a stable, well-supported environment.
*   **Isolation:** Each OS gets its own dedicated NVMe drive. This ensures maximum performance and eliminates the risk of one OS accidentally corrupting the bootloader or system files of the other.

## Preparation

### Required Tools
1.  **Two USB Flash Drives** (16GB+ recommended).
2.  **Ventoy** (https://www.ventoy.net/): A tool to create bootable USB drives with multiple ISO files.
3.  **ISO Files:**
    *   **Windows 11:** Download the latest image from [Microsoft's official site](https://www.microsoft.com/software-download/windows11).
    *   **Fedora KDE Plasma:** Download the "Fedora KDE Plasma" spin from [getfedora.org](https://getfedora.org/en/workstation/download/).

### Creating Bootable Media with Ventoy
1.  Install Ventoy on one of your USB drives.
2.  Copy both the `Windows11.iso` and `Fedora-KDE.iso` files onto the Ventoy drive.
3.  This single drive can now boot either installer.

### BIOS/UEFI Configuration
Before installing, enter your motherboard's BIOS/UEFI setup (usually by pressing `DEL` or `F2` during boot) and configure the following:
1.  **Enable UEFI Mode:** Ensure BIOS is set to UEFI, not Legacy/CSM.
2.  **Secure Boot:** Can be left **Enabled**. Both Windows and Fedora support it.
3.  **Fast Boot:** **Disable** this temporarily for installation.
4.  **SATA Mode:** Set to **AHCI** for best performance with your SSDs. (Note: If Windows was previously installed in RAID/RST mode, changing this will cause a boot blue screen. This must be changed before a fresh install).
5.  **TPM:** Enable (required for Windows 11).

## Windows 11 Installation

### Step 1: Partitioning the 2TB 990 Pro
1.  Boot from the Ventoy drive and select the `Windows11.iso`.
2.  Proceed through the Windows installer until you reach the "Where do you want to install Windows?" screen.
3.  You will see a list of drives. Select **Drive 0** (your 2TB Samsung 990 Pro).
4.  Delete all existing partitions on this drive until you have a single block of "Unallocated Space".
5.  Click **Next**. Windows will automatically create the required UEFI (ESP), MSR, and primary partitions.

### Step 2: Completing the Install
1.  Let the installer copy files and complete the installation. The system will reboot several times.
2.  Go through the initial setup (OOBE): create a user account, privacy settings, etc.
3.  Once on the desktop, connect to the internet and let Windows Update run. It will download critical drivers for your system.

## Fedora Linux (KDE Plasma) Installation

### Step 1: Launching the Installer
1.  Reboot and boot from the Ventoy drive again, this time selecting the `Fedora-KDE.iso`.
2.  Select "Start Fedora KDE Plasma" from the GRUB menu.
3.  Once the live environment boots, click "Install to Hard Drive".

### Step 2: Installation Destination
This is the most critical step.
1.  Under **Installation Destination**, select **Custom**.
2.  You will see a list of disks. Select your **1TB Samsung 980 NVMe (e.g., /dev/nvme1n1)**.
3.  Click **Delete all** on this disk to start with a clean slate.
4.  Click the **+** button to create new partitions manually:
    *   **EFI System Partition:**
        *   Desired Capacity: `1 GiB`
        *   Mount Point: `/boot/efi`
        *   Type: `EFI System Partition`
    *   **Boot Partition:**
        *   Desired Capacity: `1 GiB`
        *   Mount Point: `/boot`
        *   Type: `ext4`
    *   **Root Partition:**
        *   Desired Capacity: `50 GiB`
        *   Mount Point: `/`
        *   Type: `ext4` (or `btrfs` if you prefer snapshots)
    *   **Home Partition:**
        *   Desired Capacity: `Leave the rest of the space` (approx. 948 GiB)
        *   Mount Point: `/home`
        *   Type: `ext4`
5.  Click **Done** and review the summary. Accept the changes to begin writing to the disk.

### Step 3: Finalizing Setup
1.  Complete the rest of the installer: set your timezone, create a user account, and set a root password.
2.  After installation is complete, click **Finish** and reboot.
3.  **Remove the installation media** when prompted.

## Post-Installation Steps

### Windows 11
1.  **NVIDIA Drivers:** Download and install the latest **NVIDIA Studio Driver** from [NVIDIA's website](https://www.nvidia.com/Download/index.aspx). This optimizes performance for creative applications.
2.  **Windows Subsystem for Linux (WSL):** Open PowerShell as Administrator and run:
    ```powershell
    wsl --install
    ```
    This installs Ubuntu for development tasks without rebooting.

### Fedora Linux
1.  **Enable RPM Fusion:** The Fedora project doesn't include proprietary software by default. RPM Fusion provides these packages.
    ```bash
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    ```
2.  **Install NVIDIA Drivers:**
    ```bash
    sudo dnf update
    sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
    ```
    Reboot after this completes.
3.  **Install Media Codecs:**
    ```bash
    sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
    sudo dnf groupupdate sound-and-video
    ```

## GRUB Bootloader Notes

Fedora's GRUB should automatically detect your Windows 11 installation and add it to the boot menu. If it doesn't, you can regenerate the config:
```bash
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```
You can set the default OS and timeout in `/etc/default/grub` and then run the command above again.

***

## Repository Structure
| File      | Description   |
|-----------|---------------|
| README.md | [Overview and hardware summary](README.md)
| 01_OS_Setup.md | [Dual-boot configuration guide](01_OS_Setup.md)
| 02_Storage_Strategy.md | [Storage layout and management](02_Storage_Strategy.md)
| 03_Software_Configuration.md | [Creative software setup](03_Software_Configuration.md)
| 04_Workflow_Management.md | [Cross-platform workflow implementation](04_Workflow_Management.md)
| 05_Lab_Environment.md | [Distro-hopping and experimentation setup](05_Lab_Environment.md)
| 06_Network_Sharing.md | [Media sharing and network configuration](06_Network_Sharing.md)
