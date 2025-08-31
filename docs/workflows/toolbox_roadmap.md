# 🗺 Toolbox Roadmap

This document provides a **growth plan** for the `toolbox` repository.  
It outlines ideas, scripts, and docs to add over time, keeping the repo useful and well-structured.

---

## Purpose
- Track potential improvements and scripts to add.
- Ensure every addition has a logical place in the folder structure.
- Keep growth **organized** instead of turning into a dumping ground.

---

## Roadmap by Folder

### 🔑 aliases/
- [ ] Add `git_aliases.sh` → shortcuts for Git commands (gs, gp, glog).
- [ ] Add `sysadmin_aliases.sh` → helpers for `systemctl`, `journalctl`, etc.
- [ ] Keep alias files **topic-specific** instead of one big file.

💡 **Best practice:** Modular aliases → easier to sync across machines.

---

### 📚 docs/
- [ ] Add `process_management.md` → managing processes with `top`, `htop`, `kill`.
- [ ] Add `backup_strategy.md` → system/personal backup plan.
- [ ] Add `security_basics.md` → SSH hardening, firewall, update routines.

💡 **Best practice:** Add guides you actually reference in daily work.

---

### 🤖 ollama/
- [ ] Create `prompt_examples/` → curated prompts (guides, coding, system help).
- [ ] Add `ollama_notes.md` → performance tuning, model comparisons, tricks.

💡 **Best practice:** Treat this folder as your **personal LLM playbook**.

---

### 🖥 system/
- [ ] Add `disk_usage.sh` → quick disk space overview.
- [ ] Add `net_usage.sh` → lightweight network usage monitor.
- [ ] Add `cache_clean.sh` → safe cleanup of package caches/logs.
- [ ] Add `cpu_benchmark.sh` / `ram_benchmark.sh` → extend benchmarks.

💡 **Best practice:** Group system scripts by purpose (benchmarks, cleanup, monitoring).

---

### 🛠 utils/
- [ ] Create `encryption/` folder → `encrypt_file.sh` / `decrypt_file.sh` with gpg/openssl.
- [ ] Create `notes/` folder → markdown quick notes with timestamped files.
- [ ] Add `pomodoro.sh` under `timers/` → 25/5 productivity timer.

💡 **Best practice:** Small, reusable helpers. Each utility should do one thing well.

---

### 🧩 templates/
- [ ] Add `python/script_template.py` → logging, argparse, exit codes.
- [ ] Add `docker/Dockerfile` → minimal Python or Bash runtime environment.

💡 **Best practice:** Templates save time and enforce consistency.

---

## General Best Practices
- 📂 Always add a **folder-level README.md** when creating a new directory.
- 📝 Document scripts in Markdown (`docs/`) as much as possible.
- 🔑 Keep scripts executable and consistently named (`snake_case.sh`).
- 🌱 Add features only when useful — grow organically.

---

✅ Use this file as a **living roadmap**. Check off items as you complete them!
