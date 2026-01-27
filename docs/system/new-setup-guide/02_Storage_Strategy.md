
***

# 02 - Storage Strategy & Configuration

## Table of Contents
1.  [Drive Allocation Philosophy](#drive-allocation-philosophy)
2.  [Drive Role Assignment Table](#drive-role-assignment-table)
3.  [Configuration: Windows 11](#configuration-windows-11)
4.  [Configuration: Fedora Linux](#configuration-fedora-linux)
5.  [The Project Folder Structure](#the-project-folder-structure)
6.  [Cache & Scratch Configuration](#cache--scratch-configuration)
7.  [Backup Strategy](#backup-strategy)

## Drive Allocation Philosophy

The goal is to create a logical, performance-tiered system where data lives on the most appropriate storage medium. This setup ensures your fast NVMe drives are dedicated to active work, while larger, slower drives handle bulk storage and archives. The structure is designed to be **cross-platform**, meaning your project data is accessible and organized identically from both Windows and Linux.

## Drive Role Assignment Table

| Drive | Capacity | Format | Windows Letter | Linux Mount Point | Purpose |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Samsung 990 Pro** | 2 TB | NTFS | `C:\` | (Not mounted) | Windows OS, Apps, **Active Projects** |
| **Samsung 980** | 1 TB | ext4 | (Not visible) | `/` (root & home) | Fedora OS, Linux Apps, Linux Projects |
| **Samsung 850 EVO** | 500 GB | NTFS | `D:\` | `/mnt/scratch` | **Dedicated Scratch & Cache Drive** |
| **Hard Drive #1** | 2 TB | NTFS | `E:\` | `/mnt/archive` | **Media Archive & Project Library** |
| **Hard Drive #2** | 2 TB | NTFS | `F:\` | `/mnt/backup` | **Mirror Backup of HDD #1** |
| **Samsung T7** | 2 TB | exFAT | (When plugged in) | (When plugged in) | **Portable Projects & Transfers** |

## Configuration: Windows 11

### Initial Setup (Disk Management)
1.  Press `Win + X` and select **Disk Management**.
2.  You will see your 500GB SSD and two 2TB HDDs as unallocated space.
3.  **For the 500GB 850 EVO (Scratch Drive):**
    *   Right-click on the unallocated space and select **New Simple Volume**.
    *   Assign the drive letter **D:**.
    *   Format as **NTFS** with the label `Scratch`.
4.  **For the first 2TB HDD (Archive):**
    *   Create a new simple volume.
    *   Assign the drive letter **E:**.
    *   Format as **NTFS** with the label `Archive`.
5.  **For the second 2TB HDD (Backup):**
    *   Create a new simple volume.
    *   Assign the drive letter **F:**.
    *   Format as **NTFS** with the label `Backup`.

### Creating the Project Structure
1.  On your **C:\** drive (990 Pro), create the main folder: `C:\MediaProjects\`.
2.  On your **E:\** drive (Archive HDD), create the same folder: `E:\MediaProjects\`.
3.  *(The detailed structure for these folders is defined in the next section).*

## Configuration: Fedora Linux

The goal is to automatically mount the NTFS drives on boot so they are always available.

### 1. Install NTFS Support
```bash
sudo dnf install fuse-ntfs3g
```

### 2. Create Mount Points
Create directories where the drives will be accessed:
```bash
sudo mkdir /mnt/scratch    # For the 500GB SSD (D:)
sudo mkdir /mnt/archive    # For the first HDD (E:)
sudo mkdir /mnt/backup     # For the second HDD (F:)
```

### 3. Identify Disk UUIDs
Find the unique identifiers (UUIDs) for your drives. This is more reliable than using device names like `/dev/sda1`.
```bash
sudo blkid
```
Look for the lines corresponding to your NTFS partitions. They will look like:
```
/dev/sdb1: UUID="A12B3C4D5E6F7890" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="12345678-1234-1234-1234-1234567890ab"
```
Copy the `UUID` value for each drive.

### 4. Configure Automatic Mounting
Edit the filesystem table:
```bash
sudo nano /etc/fstab
```
Add the following lines to the end of the file, replacing `UUID=...` with the actual UUIDs you found for each partition:
```
# Scratch Drive (500GB SSD)
UUID=A12B3C4D5E6F7890 /mnt/scratch ntfs-3g defaults,uid=1000,gid=1000,umask=022 0 0

# Archive Drive (HDD #1)
UUID=B23C4D5E6F7890A1 /mnt/archive ntfs-3g defaults,uid=1000,gid=1000,umask=022 0 0

# Backup Drive (HDD #2)
UUID=C34D5E6F7890A1B2 /mnt/backup ntfs-3g defaults,uid=1000,gid=1000,umask=022 0 0
```
**Options explained:**
*   `uid=1000,gid=1000`: Makes you (the first user) the owner of the mounted drive, giving you full read/write permissions.
*   `umask=022`: Sets the default permissions for new files.
*   `0 0`: Controls filesystem checks (not needed for NTFS).

### 5. Mount the Drives
Apply the changes without rebooting:
```bash
sudo systemctl daemon-reload
sudo mount -a
```
If there are no errors, your drives are now mounted and will be on every boot. You can access them at `/mnt/scratch`, `/mnt/archive`, and `/mnt/backup`.

## The Project Folder Structure

This consistent structure must be created on **both** `C:\MediaProjects\` (Windows) and `/mnt/archive/MediaProjects/` (Linux). This is the key to your cross-platform workflow.

```
MediaProjects/
│
├── Project_2024-09-10_YouTubeIntro/  # Example Project Folder
│   ├── 01_Footage/              # Raw camera files (MP4, CR3). NEVER edit these directly.
│   ├── 02_Audio/                # Music, SFX, voice recordings
│   ├── 03_Assets/               # Graphics, logos, lower thirds, thumbnails
│   ├── 04_ProjectFiles/         # .drp (Resolve), .kdenlive, .afdesign, .blend files
│   ├── 05_Exports/              # Final rendered videos, edited photos
│   └── 06_Cache/                # Program-specific cache (safe to delete)
│
└── SharedAssets/                 # Global assets for all projects
    ├── Music/
    ├── SoundFX/
    ├── LUTs/
    ├── Overlays/
    └── Fonts/
```

## Cache & Scratch Configuration

Point demanding applications to use your `D:\` or `/mnt/scratch` drive for temporary files.

*   **DaVinci Resolve:** `Preferences -> Media Storage -> Add Folder -> D:\Resolve_Cache` (Win) or `/mnt/scratch/Resolve_Cache` (Linux).
*   **Affinity Photo:** `Preferences -> Performance -> Scratch Disk -> D:\` (Win).
*   **Blender:** `Edit -> Preferences -> File Paths -> Temporary Files -> D:\Blender\` (Win) or `/mnt/scratch/Blender/` (Linux).
*   **OBS Studio:** `Settings -> Output -> Recording Path -> D:\OBS_Recordings\` (Win) or `/mnt/scratch/OBS_Recordings/` (Linux).

## Backup Strategy

1.  **Manual Mirroring (Simple):** Use **FreeFileSync** on Windows to create a "Mirror" task from `E:\` (Archive) to `F:\` (Backup). Run this after any major file addition or project completion.
2.  **Automated Mirroring (Linux):** You can use a cron job to run `rsync` periodically.
    ```bash
    # Example command (test it first!)
    rsync -avh --delete /mnt/archive/ /mnt/backup/
    ```
3.  **Project Sync:** Use your **Samsung T7 SSD** to manually copy current WIP projects before traveling.

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
