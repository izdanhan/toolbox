# 🧰 Utilities (`utils/`)

This folder contains **general-purpose helper scripts**.  
They are small, reusable, and cover tasks that don’t belong to other categories.

---

## 📂 Structure

```
utils
├── backup/       # Backup & restore scripts
├── timers/       # Stopwatch, countdown, and time-tracking tools
└── misc/         # Small utilities that don’t fit elsewhere
```

---

## 📖 Navigation

- [backup/](backup/) → Scripts for creating and restoring backups.  
- [timers/](timers/) → Stopwatch, countdown, and productivity timers.  
- [misc/](misc/) → Miscellaneous helper scripts.  

---

## 🛠 Best Practices

- Keep scripts **modular** — one script = one job.  
- Use **clear filenames** (e.g., `backup_home.sh`, `countdown.sh`).  
- Add usage examples at the top of each script as comments.  
- Store **reusable functions** here that can be sourced in bigger projects.  
- Prefer **POSIX-compatible Bash** for portability across Linux distros.  

---

## 💡 Example Use Cases

- **Backup**: Archive important folders into `.tar.gz` or sync with `rsync`.  
- **Timers**: Run a countdown for a break, or measure execution time.  
- **Miscellaneous**: Small “glue” scripts for daily tasks like file renaming, cleaning temporary files, or formatting logs.  

---

This folder acts as your **Swiss Army knife**: quick, portable tools you can rely on in daily workflows.
