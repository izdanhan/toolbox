
# 🛡️ Complete Guide to Backing Up Your Home Folder with Kup on Fedora KDE

This guide will walk you through installing the Kup backup tool on Fedora Linux with the KDE Plasma desktop and configuring it to protect your data while excluding unnecessary folders.

***

## **1. Installing Kup on Fedora**

Kup is not available in the official Fedora repositories due to a naming conflict with another package3. However, you can easily install it from a third-party Copr repository.

1. **Open a terminal** (`Konsole`).
2. Enable the Copr repository that provides Kup:
```bash
sudo dnf copr enable zawertun/kde-kup1
```
3. Install the `kup` package and its recommended backend, `bup`, for versioned backups:
```bash
sudo dnf install kup bup15
```

***

## **2. Initial Setup & Creating Your First Backup Plan**

1. **Launch Kup**: Open your application menu and search for "Backups" or "Configure backup plans". This will open the Kup configuration module within **System Settings**.
2. **Enable Backups**: Toggle the **"Backups Enabled"** switch to the on position.
3. **Create a New Plan**: Click the **"Add New Plan"** button to begin configuration59.

***

## **3. Configuring a Backup Plan**

A backup plan defines what to back up, where to save it, and when it should run.

### **A. Choose a Backup Type**

Kup offers two types of backups9:

- **`Versioned Backup`** (Recommended): Creates a history of your files. Each backup is incremental, meaning it only saves changes, saving a significant amount of space. This requires the `bup` backend.
- **`Synchronized Backup`**: Simply mirrors the source directory to the destination. Files changed or deleted on the source will be changed or deleted in the backup.

**For most users,&#160;`Versioned Backup`&#160;is the safer choice.**

### **B. Select Sources (What to Back Up)**

This is where you select your home folder and, crucially, define exclusions.

1. Click the **"Sources"** button.
2. In the file browser, navigate to and select your home directory (e.g., `/home/yourusername`).
3. **To exclude folders** (like Steam, Downloads), you must use an **exclude pattern**:
    - Click the **"Exclude..."** button next to the source list.
    - In the "Exclude patterns" window, add the names of the folders you wish to skip, one per line. For example:
text.steam
.local/share/Steam
Downloads
.cache
.var/app/com.valvesoftware.Steam
    - These patterns are relative to the source directory. Using patterns like `*/Steam` or `*/Downloads` can help ensure all matching directories are excluded, no matter where they are9.

### **C. Set Destination (Where to Save)**

Click the **"Destination"** button to choose where your backups will be stored.

- **For safety, always save to an external drive or a different physical storage device.** This protects your data in case of a hardware failure.
- Select the mount point of your external drive (e.g., `/run/media/yourusername/YourExternalDrive/Backups`).

### **D. Schedule (When to Run)**

Click the **"Schedule"** button to set up automatic backups.

- **`Interval`**: Backs up after a set period of inactivity (e.g., every 24 hours).
- **`Active Usage Time`**: Backs up after your computer has been actively used for a certain number of hours.
- **`Manual Activation`**: Backups only run when you manually start them.

**A good starting point is an&#160;`Interval`&#160;of 24 hours.**

### **E. Review and Apply**

Give your plan a descriptive name (e.g., "Home Directory Backup"), review all your settings, and click **"Apply"** to save the plan5.

***

## **4. Running and Monitoring Backups**

- After applying your plan, Kup will likely ask if you want to run the first backup immediately. Click **"Yes"**.
- An icon will appear in your system tray. Click on it to see the progress of the current backup job.
- You can also manually start a backup at any time from this system tray icon9.

***

## **5. Restoring Files**

Restoring is straightforward with Kup's GUI.

1. Open the Kup system tray menu and select **"Restore files..."**.
2. A file browser window will open, allowing you to navigate through your backup history (for versioned backups).
3. Select the file or folder version you want to restore and choose a destination for it9.

***

## **📊 Summary of Common Exclude Patterns**

Here is a quick reference table for folders you might want to exclude from your home directory backup:

| Folder Pattern | Reason for Exclusion |
| --- | --- |
| `**/.steam` | Steam client configuration and caches. |
| `**/.local/share/Steam` | The main Steam library, containing all game files (very large!). |
| `**/Downloads` | User download directory (transient, large files). |
| `**/.cache` | Application cache files (unnecessary to back up). |
| `**/.var/app/com.valvesoftware.Steam` | Flatpak version of Steam installation. |
| `**/tmp` | Temporary files. |
| `*.tmp` | Temporary files. |
| `**/Trash` | Local trash folder. |

> **Note**: The `**/` prefix is a powerful pattern that means "match in any subdirectory." For example, `**/.cache` will exclude the `.cache` folder anywhere in your backup source.

***

## **💡 Troubleshooting and Tips**

- **Name Conflict**: If you encounter any issues finding the package, remember that on some systems, the backup tool might be named `kup-backup` instead of just `kup`3.
- **Bup for Versioning**: Ensure `bup` is installed if you want to use versioned backups, as Kup relies on it for this functionality9.
- **Flatpak Steam**: If you installed Steam via Flatpak, its data is located in `~/.var/app/com.valvesoftware.Steam`. This is a prime candidate for exclusion due to its large size.
- **Check Logs**: If a backup fails, check the logs available through the Kup system tray menu for detailed error messages.

By following this guide, you should have a robust, automated backup system for your Fedora KDE setup that efficiently protects your important data without wasting space on easily replaceable files. Remember to periodically test restoring a file to ensure your backups are working correctly!