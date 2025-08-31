# 🛠 Toolbox Maintenance Checklist

A lightweight workflow to keep your **`toolbox`** repo clean, consistent, and valuable over time.  

---

## 🔄 Weekly / Regular Maintenance
- [ ] **Sync repos**:  
  ```bash
  ./sync_repos.sh
  ```
  to pull latest changes on all machines.  

- [ ] **Check new scripts**: Did you make any new scripts on your machine that belong in `toolbox`?  
  - Move them into the right folder (`system/`, `utils/`, etc.).  
  - Add a short description in the folder’s `README.md`.  

- [ ] **Prune clutter**: If a script is experimental, put it in a `sandbox/` folder (not in main directories).  

---

## 📚 Documentation
- [ ] **Update `docs/`** whenever you solve a problem worth remembering.  
  - `git/` → Git tips, workflows.  
  - `linux/` → Useful one-liners or references.  
  - `system/` → Admin/security best practices.  
  - `workflows/` → Step-by-step guides for repeatable tasks.  

- [ ] **Cross-reference**: If you add a new doc, update the parent `README.md` so you don’t forget it exists.  

---

## 🛠 Scripts Best Practices
- [ ] Always add **usage examples** at the top of scripts.  
- [ ] Use **clear filenames** (`backup_home.sh` instead of `backup.sh`).  
- [ ] Keep scripts **POSIX-compatible** where possible.  
- [ ] Test both on **desktop and laptop** if relevant.  

---

## 🗂 Structure & Organization
- [ ] Stick to existing categories (`system/`, `utils/`, etc.).  
- [ ] If a new domain grows (e.g., **AI experiments**), create a new folder with a `README.md`.  
- [ ] Keep **examples/** folders alive with reference files.  

---

## 🚀 Bigger Picture
- [ ] Every 3–6 months:  
  - Read through all `README.md`s.  
  - Remove outdated references.  
  - Add missing links.  

- [ ] Consider adding a **CHANGELOG.md** if repo evolves rapidly.  
- [ ] Optionally, tag GitHub releases if you want version snapshots.  

---
