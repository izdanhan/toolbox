# Git Cheat Sheet

This cheat sheet provides common Git workflows and commands for daily use.

---
## 🔑 SSH Setup for GitHub

1. Generate SSH key (if not already created):
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. Start ssh-agent and add the key:
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. Copy the key to clipboard and add to GitHub (Settings → SSH and GPG keys):
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

4. Test connection:
   ```bash
   ssh -T git@github.com
   ```

---
## 📥 Cloning Repositories

Clone an existing repository:
```bash
git clone git@github.com:USERNAME/REPO.git
```

---
## 🆕 Creating a New Repository

1. Create new repo on GitHub (via website).
2. Locally initialize and push:
   ```bash
   mkdir my-repo && cd my-repo
   git init
   git remote add origin git@github.com:USERNAME/my-repo.git
   touch README.md
   git add README.md
   git commit -m "Initial commit"
   git push -u origin main
   ```

---
## 🔄 Syncing Changes

Check status:
```bash
git status
```

Stage & commit changes:
```bash
git add .
git commit -m "Your message"
```

Push to remote:
```bash
git push
```

Pull latest from remote:
```bash
git pull
```

---
## 🌿 Branching

Create new branch:
```bash
git checkout -b feature-branch
```

Switch branches:
```bash
git checkout main
```

Merge branch:
```bash
git merge feature-branch
```

Push branch to remote:
```bash
git push -u origin feature-branch
```

---
## 🧹 Maintenance

View remotes:
```bash
git remote -v
```

Remove a file from tracking (keep locally):
```bash
git rm --cached file.txt
```

Undo last commit (soft reset):
```bash
git reset --soft HEAD~1
```

Stash changes:
```bash
git stash
git stash pop
```

---
