
# Vorta with BorgBackup Setup Guide

## 1. Initialize a Borg Repository
First, create and initialize a Borg repository on your backup drive (e.g., LUKS2-encrypted HDD).

```bash
# Unlock and mount your LUKS2-encrypted HDD (replace /dev/sdX1 with your partition)
sudo cryptsetup open /dev/sdX1 backup_hdd
sudo mount /dev/mapper/backup_hdd /mnt/backup

# Initialize Borg repository (choose encryption mode: repokey or keyfile)
borg init --encryption=repokey /mnt/backup/borg_repo
```
- You'll be prompted to set a passphrase. **Remember this**; it’s required to access backups.
- Use `--encryption=keyfile` for a separate keyfile (more secure but harder to recover if lost).

---

## 2. Add Repository in Vorta
1. Open Vorta from your application menu.
2. Go to **Repository → Add Existing Repository**.
3. Enter the path to your Borg repo (e.g., `/mnt/backup/borg_repo`).
4. Provide the passphrase set during initialization.
5. Click **Test** to verify connectivity, then **Add Repository**.

---

## 3. Configure Backup Sources
1. In Vorta, go to the **Sources** tab.
2. Click **Add Folder** to include directories (e.g., `/home/your_username/Documents`).
3. Use the **Exclude Patterns** tab to exclude unnecessary files (e.g., `*.tmp`, `~/Downloads/*.iso`).
   - Example excludes:
     ```
     /home/*/.cache
     /home/*/tmp
     *.log
     ```

---

## 4. Set Up Backup Settings
- **Compression**: LZ4 (fast, good compression) or ZSTD (better compression, slightly slower). Configure in **Advanced → Compression**.
- **Retention Policy**: Go to **Prune** tab to define rules:
  - Example: Keep `7 daily, 4 weekly, 6 monthly` archives.
  - Enable **Prune after backup** to automate cleanup.

---

## 5. Schedule Backups
1. Go to the **Schedule** tab.
2. Click **Enable Scheduling**.
3. Set frequency (e.g., daily at 2:00 AM).
4. Ensure Vorta runs at login (**Misc → Start Vorta on login**).

---

## 6. Run First Backup
- Click **Start Backup** in the main window.
- Monitor progress in the **Log** tab.
- Verify stats (e.g., deduplication ratio) after completion.

---

## 7. Restore Files
1. Go to the **Archives** tab, select an archive.
2. **Extract**: Choose files/folders → Click **Extract** → Select destination.
3. **Mount**: Click **Mount** to access files via a temporary directory (useful for browsing).

---

## 8. Maintenance Tips
- **Check Integrity**: Occasionally run `borg check /mnt/backup/borg_repo`.
- **Compact Repository**: Free space with `borg compact /mnt/backup/borg_repo` (if Borg version < 1.2, compacting isn’t always needed).
- **Update Passphrase**: Use `borg key change /mnt/backup/borg_repo` to rotate keys.

---

## 9. Troubleshooting
- **Permission Issues**: Ensure your user has read access to source files and write access to the repo.
- **Low Space**: Borg requires free space for operations. Monitor with `borg list /mnt/backup/borg_repo`.
- **Vorta GUI Bugs**: Check logs at `~/.cache/Vorta/logs/` or run `vorta --debug` in terminal.

---

## 10. Automation (Optional)
For manual triggers via cron or scripts:
```bash
# Trigger a backup for a profile named "Main"
vorta --create "Main"
```

---

## 11. What to backup

### The "Include All, Exclude Some" Approach

This is what you're asking about: setting your source to `/home/yourusername` and then creating a long list of exclusions for folders like `.cache`, `.local/share/Steam`, etc.

**Pros:**
*   **Simplicity of Setup:** It feels easier to just check one box for your home folder.
*   **Comprehensiveness:** You are less likely to accidentally miss a hidden config folder for an important application.

**Cons (These are significant):**
*   **Inefficient Backups:** You are constantly scanning and evaluating every single file in your home directory, including massive, irrelevant files (like game libraries in `.steam` or virtual disks). This makes backup operations slower and more resource-intensive.
*   **Complex Exclusion List:** Your exclude list must be meticulously maintained. Forget to exclude one large directory (e.g., `~/Videos/raw_footage`), and your backup repository size could balloon unexpectedly.
*   **Higher Risk of Backup Failure:** The more files and directories involved, the higher the chance that a permission error on one strange file could interrupt the entire backup process.

### The "Selective Inclusion" Approach (Recommended)

The wiser strategy is to **explicitly include only the directories that contain irreplaceable data.** This is the philosophy behind tools like Borg and Vorta.

**Pros:**
*   **Highly Efficient:** Borg only scans and processes the data you actually care about. Backups are much faster and put less strain on your system.
*   **Predictable Size:** Your backup repository size grows in a predictable and manageable way because you're only adding known data sets.
*   **Simpler Configuration:** Your include list is typically much shorter and easier to manage than a long, complex exclude list. It's a list of what you *want*, not what you *don't want*.
*   **More Robust:** By avoiding system directories and caches, you avoid most permission-related backup errors.

**Cons:**
*   **Requires More Thought:** You need to think about where your important data lives. However, this is a good exercise!

---

### What to Include and Exclude

Here is a practical guide for building your selective include list in Vorta.

#### 📁 **Directories to INCLUDE (Your precious data):**

*   `~/Documents`
*   `~/Pictures`
*   `~/Videos` (be mindful of size; you might only include final projects, not raw footage)
*   `~/Music`
*   `~/Source` (or `~/dev`, your code projects)
*   `~/Downloads` (be selective, it's often a graveyard of temporary files)
*   **Select Configs:** *Consider* including specific application config folders if they are critical and difficult to recreate. This is the one exception to the rule.
    *   `~/.config/Code` (VSCode/VSCodium settings)
    *   `~/.config/krita` (Krita brushes and settings)
    *   `~/.ssh` (SSH keys - ensure they are encrypted with a passphrase!)
    *   `~/.local/share/Plasma` (KDE Plasma customizations)

#### 🗑️ **Directories to EXCLUDE (You should not back these up):**

If you *do* go the "include all" route, this is your essential exclusion list. Most of these should be avoided by simply not including them in the first place.

*   `~/.cache` - **Always exclude.** Pure temporary files.
*   `~/.local/share/Steam` - Massive game files. Use Steam's backup feature for games.
*   `~/.var/app` (Flatpak data) - Can be huge. Be selective; maybe only include configs for specific apps.
*   `~/.local/share/Trash` - The trash bin.
*   `~/tmp`
*   `~/.npm`
*   `~/.gradle`
*   Any directory containing virtual machine disks, Docker data, or large databases.

### How to Implement This in Vorta

1.  **Do NOT** set the source to your entire `/home/username` folder.
2.  In the **Sources** tab, click **Add Folder**.
3.  Navigate to and add each of the important directories listed above (`Documents`, `Pictures`, `Source`, etc.).
4.  (Optional) In the **Exclude Patterns** tab, you can add a few broad patterns to catch any temporary files that might sneak into your included folders, e.g., `*.tmp`, `*.log`.

### Conclusion and Recommendation

**For the vast majority of users, the "Selective Inclusion" method is superior.** It is more efficient, more reliable, and encourages you to be mindful of what data is truly important.

Reserve the "Include All, Exclude Some" method for advanced users who have a very specific need to backup almost everything and are willing to maintain a complex and fragile exclusion list.

**For your personal setup, I strongly recommend creating a list of specific includes in Vorta (`Documents`, `Pictures`, `Videos`, `Source`, etc.) and leaving everything else out.** Your backups will be faster, your repository will be smaller, and the process will be more reliable.

---

## Resources
- [Borg Documentation](https://borgbackup.readthedocs.io/)
- [Vorta GitHub](https://github.com/borgbase/vorta)
- [BorgBase Hosting](https://www.borgbase.com/) (for remote backups)

---
