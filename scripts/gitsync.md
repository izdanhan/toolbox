Here's a `gitsync.sh` script that wraps the whole everyday flow: it pulls with rebase first (so your local commits stay on top), stages everything including new files, commits, and pushes.

How to use it:

```bash
chmod +x gitsync.sh          # once, to make it executable
./gitsync.sh                 # asks you for a commit message interactively
./gitsync.sh "fixed bug X"   # or pass the message directly
./gitsync.sh -n              # dry run: just shows what it would do
```

A few notes on what it handles for you:

- **Clean tree check** — if there's nothing to commit, it stops after the pull and says so, instead of failing at `git commit`.
- **No upstream yet** — for a brand-new branch it skips the pull and still commits/pushes fine.
- **Conflicts** — if `pull --rebase` hits a conflict, it stops and tells you exactly which commands to run to resolve or abort; it won't guess.
- **Safety first** — `set -euo pipefail` means it stops on any failed command rather than continuing half-broken.

If you'd rather review files one by one before staging (instead of `git add -A` grabbing everything), or want it to auto-push a tag as well, I can adjust it.
