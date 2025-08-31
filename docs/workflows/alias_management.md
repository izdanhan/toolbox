# Alias Management Guide

## Why use aliases?
Aliases save time by shortening long commands.

Example:
```bash
alias ll='ls -alF'
```

Now typing `ll` runs `ls -alF`.

---

## Best practices
1. Keep aliases in one file, e.g. `~/.aliases`.
2. Source it in `~/.bashrc` or `~/.zshrc`:
   ```bash
   if [ -f ~/.aliases ]; then
       . ~/.aliases
   fi
   ```
3. Sync across machines with Git.

---

## Example alias file (`custom_aliases.sh`)
```bash
# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git
alias gs='git status'
alias gp='git pull'
alias gcm='git commit -m'

# System
alias cls='clear'
alias dfh='df -h'
```

---

## Keeping aliases in Git
1. Create an `aliases/` folder in your repo.  
2. Add `custom_aliases.sh`.  
3. Symlink it in your home dir:  
   ```bash
   ln -s ~/Projects/github/misc-scripts/aliases/custom_aliases.sh ~/.aliases
   ```
4. Update via `git pull`.  
