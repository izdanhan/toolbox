# 🔄 Backup & Restore Workflow

This guide explains how to back up and restore files using scripts in `utils/backup/`.

---

## 📦 Backup
Run:
```bash
./utils/backup/backup.sh /path/to/source /path/to/destination
```
This will create a compressed `.tar.gz` archive with timestamp.

---

## ♻️ Restore
To restore:
```bash
tar -xvzf backup-YYYYMMDD-HHMMSS.tar.gz -C /path/to/restore/location
```

---

## ✅ Best Practices
- Store backups on **external disk or NAS**.
- Automate using **cron** or `systemd` timer.
- Regularly test restores.
