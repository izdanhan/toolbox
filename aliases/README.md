# 🔗 Aliases (`aliases/`)

This folder centralizes **custom shell aliases** to make your workflow faster, more consistent, and easier to maintain across systems.

---

## 📂 Structure

```
aliases
├── custom_aliases.sh   # Your main alias collection
├── examples/           # Example alias sets for reference
│   └── README.md
```

---

## 📖 Navigation

- [custom_aliases.sh](custom_aliases.sh) → Your active aliases.  
- [examples/](examples/) → Example aliases to copy or adapt.  

---

## 🛠 Best Practices

- **Organization**:  
  - Group aliases by category (system, git, navigation, productivity).  
  - Keep each alias short but memorable.  
  - Document non-obvious aliases with comments.  

- **Portability**:  
  - Keep your alias file in this repo → so you can sync it across machines.  
  - Source it from your shell config (`.zshrc` / `.bashrc`) with:  
    ```bash
    source ~/Projects/github/toolbox/aliases/custom_aliases.sh
    ```

- **Versioning**:  
  - Use Git to track alias changes over time.  
  - Add/remove aliases in commits with meaningful messages.  

---

## 💡 Example Aliases

```bash
# System shortcuts
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# Navigation
alias proj='cd ~/Projects/github'
alias docs='cd ~/Projects/github/toolbox/docs'

# Workflow helpers
alias reload!='source ~/.zshrc'
alias ports='sudo lsof -i -P -n | grep LISTEN'
```

---

This folder is your **personal shortcut hub**. Keep it tidy, documented, and in sync with your daily workflow.
