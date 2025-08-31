# ⚡ Quick Start Guide

This guide explains how to use the ready-to-go scripts included in your toolbox.  
They are meant to save time and act as examples for building new tools.

---

## 1. Git Aliases

**File:** `aliases/git_aliases.sh`  

Load the aliases in your shell:  
```bash
source aliases/git_aliases.sh
```

### Examples
- `gs` → `git status`  
- `gpo main` → `git push origin main`  
- `glog` → compact Git log with graph  

👉 Tip: Add `source ~/Projects/toolbox/aliases/git_aliases.sh` to your `~/.zshrc` or `~/.bashrc` for automatic loading.

---

## 2. Disk Usage Check

**File:** `system/monitoring/disk_usage.sh`  

Run directly:  
```bash
./system/monitoring/disk_usage.sh
```

Output:  
Shows a summary of disk usage for all mounts, including a **total row**.

---

## 3. Network Usage Check

**File:** `system/monitoring/net_usage.sh`  

Run directly:  
```bash
./system/monitoring/net_usage.sh
```

Output:  
A snapshot of **TX/RX bandwidth** using `ifstat`.  
Falls back to `/proc/net/dev` if `ifstat` is not installed.

---

## 4. Quick Backup

**File:** `utils/backup/quick_backup.sh`  

Usage:  
```bash
./utils/backup/quick_backup.sh ~/Projects
```

This creates a timestamped `.tar.gz` backup inside `~/Backups/`.  

👉 Tip: Add to a cron job for daily or weekly automatic backups.

---

## 5. Python Script Template

**File:** `templates/python/script_template.py`  

Run with:  
```bash
python3 templates/python/script_template.py --name Daniel
```

Output:  
```
Hello, Daniel!
```

Includes:  
- `argparse` for handling arguments  
- `logging` with timestamps  

👉 Use this template to start any new Python utility.

---

## ✅ Next Steps

- Add more aliases (e.g., system shortcuts) under `aliases/`.  
- Extend monitoring scripts for CPU, memory, or GPU.  
- Use the Python template as a base for larger automation tools.  
