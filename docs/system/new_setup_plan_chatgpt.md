Got it 👍 If the **980 NVMe is reserved for Linux**, that changes things slightly but still works really well. In that case, here’s how I’d map it all out and give you a clean **step-by-step setup checklist**.

---

# ⚙️ Final Drive Roles

* **2 TB 990 Pro NVMe (fastest)**

  * Windows 11 OS + apps
  * Active project folders (`MediaProjects/`)
  * Exports (`05_Exports/`) before moving to HDD

* **1 TB 980 NVMe (Linux dedicated)**

  * Fedora KDE (root + home + swap if you want)
  * Linux project files + Linux caches
  * Linux editing apps (Kdenlive, Darktable, Krita, etc.) point caches here

* **500 GB 850 EVO SATA**

  * Windows scratch/cache drive
  * Resolve cache, Affinity scratch, Blender temp, OBS recordings (short-term)

* **2x 2 TB HDDs**

  * HDD1 → Media library (footage, movies, TV shows, old projects)
  * HDD2 → Backup/mirror of HDD1

* **2 TB T7 External SSD**

  * Portable projects (desktop ↔ laptop sync)
  * Backup of current WIP projects when traveling

* **Laptop (2 TB 990 EVO)**

  * Fedora Workstation GNOME
  * Windows Pro VM (if ever needed)

---

# 📝 Step-by-Step Setup Checklist

### 1. Partition & Format

* **Desktop**

  * **2 TB 990 Pro (Windows)** → NTFS, single partition (C:)
  * **1 TB 980 NVMe (Linux)** → ext4 or btrfs

    * `100 GB /` (root)
    * `Rest /home`
    * `Optional 16–32 GB swap` if you want hibernate
  * **500 GB SATA** → NTFS (scratch)
  * **2x 2 TB HDDs** → NTFS for maximum cross-compatibility
  * **External T7 SSD** → exFAT (Linux + Windows friendly)

* **Laptop**

  * **2 TB 990 EVO** → ext4/btrfs (Linux only)

---

### 2. Install OSes

* Install **Windows 11** first on 990 Pro.
* Install **Fedora KDE** on 980 NVMe.
* Bootloader (GRUB) will detect Windows automatically.
* On laptop → install **Fedora GNOME** directly, no dual-boot needed.

---

### 3. Configure Caches & Scratch

**Windows (Desktop):**

* **DaVinci Resolve** → Preferences → Media Storage → set to `D:\ResolveCache` (on 850 EVO).
* **Affinity Suite** → Preferences → Performance → Scratch disk → `D:\AffinityScratch`.
* **Blender** → Preferences → File Paths → Cache → `D:\BlenderCache`.
* **OBS Studio** → Recordings → `D:\OBSRecordings`.

**Linux (Desktop, 980 NVMe):**

* Create `/mnt/cache` on 980.
* **Kdenlive** → Settings → Configure → Environment → set cache to `/mnt/cache/kdenlive`.
* **Darktable** → Preferences → Database + cache path → `/mnt/cache/darktable`.
* **Krita/GIMP** → Temporary files path → `/mnt/cache/`.
* **Blender** → Preferences → File Paths → Cache → `/mnt/cache/blender`.

---

### 4. Project Folder Structure (shared across both OSes)

On **HDD1** (or on 990 Pro if active):

```
MediaProjects/
│
├── Project_YYYY-MM-DD_Name/
│   ├── 01_Footage/
│   ├── 02_Audio/
│   ├── 03_Images/
│   ├── 04_ProjectFiles/
│   ├── 05_Exports/
│   └── 06_Cache/
└── SharedAssets/
    ├── Music/
    ├── SoundFX/
    ├── LUTs/
    ├── Overlays/
    └── Fonts/
```

---

### 5. Backups & Sync

* Use **FreeFileSync (Windows)** or `rsync` (Linux) to mirror HDD1 → HDD2.
* Sync WIP projects to **External T7 SSD** before traveling.
* Optionally, set up **Syncthing** between desktop and laptop for continuous sync of `MediaProjects/`.

---

### 6. Media Playback

* **Kodi on Windows** → main front-end for movies/TV.
* On Linux, try **Jellyfin/Plex server** pointing to HDD1 so you can stream to TV/laptop as well.

---

# ✅ Why This Works

* **Windows (990 Pro)** = editing/gaming powerhouse with max speed.
* **Linux (980 NVMe)** = full-fledged daily driver, not crippled.
* **Scratch/cache** = isolated on SATA SSD so you can purge it without fear.
* **HDDs** = bulk media only.
* **External SSD** = portable & universal.

---

Would you like me to also make you a **daily workflow guide** (step-by-step: where to dump footage, where to edit, when to move files, how to clear caches) so you don’t have to “think about drives” every time you start a project?

---

Perfect 🚀 Let’s build you a **daily workflow guide** that matches your hardware, your Linux/Windows split, and your beginner-friendly creative process. The idea is: **you always know where to put things, what to edit on, and when to clean up.**

---

# 🎬 Daily Creative Workflow

---

## **Step 1. Import Footage**

1. Plug in your camera or copy from SD card → **always dump into HDD1** first:

   ```
   HDD1:/MediaProjects/Project_YYYY-MM-DD_Name/01_Footage/
   ```

   * Keep originals intact here. This becomes your “master library.”
   * (Linux path will be `/mnt/hdd1/MediaProjects/...`)

2. Copy the **whole project folder** (not just footage) to **fast storage**:

   * Windows: `C:\MediaProjects\Project_YYYY-MM-DD_Name` (on 990 Pro)
   * Linux: `/home/you/MediaProjects/Project_YYYY-MM-DD_Name` (on 980 NVMe)

👉 HDD1 = safe storage. NVMe = working copy.

---

## **Step 2. Organize Project**

Inside your project folder, drop assets into subfolders:

* `02_Audio/` → music, voiceovers, sound effects
* `03_Images/` → thumbnails, overlays, reference images
* `04_ProjectFiles/` → save Kdenlive `.kdenlive` file or Resolve `.drp` here
* `06_Cache/` → your software will auto-dump cache here if you point it

---

## **Step 3. Edit**

* **Linux (980 NVMe)** → open in Kdenlive/Darktable/Krita, work normally.
* **Windows (990 Pro)** → open in Resolve/Affinity if you need codec support (H.265/AAC) or pro features.

👉 Both OSes use the *same project folder structure*, so you can jump between them.

---

## **Step 4. Export**

* Render/export to:

  ```
  /MediaProjects/Project_YYYY-MM-DD_Name/05_Exports/
  ```
* Keep **different versions** (YouTube 4K, social media cut, etc.) in that folder.

---

## **Step 5. Archive or Clean**

* Finished? Move the **entire project folder** back from NVMe to HDD1.
* Delete the copy on NVMe (keeps fast drive clean).
* Delete `/06_Cache/` manually if big files remain.

👉 This way, your NVMe always has just your **active projects**, nothing old.

---

## **Step 6. Backup**

* Run **FreeFileSync (Windows)** or `rsync` (Linux) → HDD1 → HDD2 mirror.
* For portable projects, copy finished or WIP folders to **T7 external SSD**.
* Optional: use **Syncthing** to auto-sync “MediaProjects” between desktop & laptop.

---

# 🧹 Cache Management Guide

* **Windows**

  * Resolve cache → `D:\ResolveCache` (850 EVO)
  * Affinity scratch → `D:\AffinityScratch` (850 EVO)
  * Blender cache → `D:\BlenderCache` (850 EVO)
  * OBS recordings → `D:\OBSRecordings` (move them to HDD1 when done)

* **Linux**

  * Create `/mnt/cache` on 980 NVMe
  * Point Kdenlive/Darktable/Krita/Blender caches here
  * Run `rm -rf /mnt/cache/*` when you want to clear

👉 Rule of thumb: **Never let cache live in your project folder or OS drive.** Keep it isolated so you can wipe it anytime.

---

# 🏁 Quick Daily Routine

1. Copy footage → HDD1 (`01_Footage`)
2. Copy project folder → NVMe (working copy)
3. Edit in Linux **or** Windows depending on tools/codecs
4. Export to `05_Exports`
5. Move project back to HDD1 when done
6. Sync HDD1 → HDD2 (backup)
7. Clean caches on 850 EVO (Windows) or `/mnt/cache` (Linux)

---

✅ This workflow keeps your NVMe uncluttered, HDD organized, and projects portable between OSes & laptop.

---
