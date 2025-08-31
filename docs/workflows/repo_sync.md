# 🔄 Repo Sync Workflow

This guide explains how to keep multiple machines (e.g. laptop and desktop) in sync with your GitHub repos.

---

## Best Practices

1. **Always pull before you start work**
   ```bash
   git pull
   ```

2. **Commit and push your changes**
   ```bash
   git add .
   git commit -m "update: added new script"
   git push
   ```

3. **On your other machine → pull again**
   ```bash
   git pull
   ```

---

## Common Pitfalls
- ❌ Don’t edit on both machines without pulling → leads to merge conflicts.  
- ❌ Don’t forget `git add .` → new files won’t be tracked.  
- ❌ Don’t skip commit messages → keep history clean.  

---

## Automating with `sync_repos.sh`

Instead of typing commands manually, you can use the included script:

```bash
./sync_repos.sh
```

It will:
- Pull the latest changes  
- Push your local commits  
- Do this for both `toolbox` and `ollama-starter` automatically  

---

## Where this fits
This guide is stored in:

```
toolbox/docs/workflows/repo_sync.md
```

to keep all workflow documentation organized in one place.
