# 📝 Repo Maintenance Workflow

This guide provides a lightweight checklist for maintaining the **toolbox** repo.  
It helps keep everything tidy, consistent, and easy to use across machines.

---

## 1. Create / Add a New Script
- ✅ Place it in the correct **logical folder** (`system/`, `utils/`, `ollama/`, etc.).  
- ✅ Make the script **executable**:
  ```bash
  chmod +x my_script.sh
  ```  
- ✅ Add a **header comment** inside the script:
  ```bash
  # my_script.sh - Short description
  # Usage: ./my_script.sh [options]
  # Example: ./my_script.sh /path/to/file
  ```  

---

## 2. Update Documentation
- ✅ Add a short explanation in the **folder’s README.md**.  
- ✅ If it’s a more complex tool, create or expand a doc in `docs/workflows/`.  
- ✅ Update the **top-level README.md directory tree** if you added a new folder.  

---

## 3. Git Workflow
- ✅ Check repo status before committing:
  ```bash
  git status
  ```  
- ✅ Stage & commit:
  ```bash
  git add .
  git commit -m "Add: my_script.sh (short description)"
  ```  
- ✅ Sync with GitHub:
  ```bash
  git pull --rebase origin main   # ensure you’re up-to-date
  git push origin main
  ```  

---

## 4. Sync Across Machines
- ✅ On another machine (laptop/desktop):
  ```bash
  cd ~/Projects/github/toolbox
  git pull origin main
  ```  
- ✅ Use `sync_repos.sh` if you want to batch-sync multiple repos.  

---

## 5. Best Practices
- 🗂 Keep scripts **modular** → don’t dump everything into one folder.  
- 📝 Use **consistent naming** → `snake_case.sh` for scripts.  
- 📚 Write docs in **Markdown** for readability + GitHub rendering.  
- 🔑 Keep **aliases modular** (group by topic in separate files).  
- 🌱 Treat `toolbox` as a **living repo** → update docs whenever you learn something new.  
