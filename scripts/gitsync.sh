#!/usr/bin/env bash
#
# gitsync — everyday git workflow in one command:
#   commit all changes -> pull (rebase) -> push
#
# Note the order: we commit FIRST, because `git pull --rebase`
# refuses to run with uncommitted changes in the worktree.
#
# Usage:
#   ./gitsync.sh                      # interactive: asks for commit message
#   ./gitsync.sh "my commit message"  # uses the message you give
#   ./gitsync.sh -n                   # dry run: show what would happen, change nothing
#
set -euo pipefail

DRY_RUN=false
MESSAGE=""

# ---------- parse arguments ----------
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run) DRY_RUN=true; shift ;;
    -h|--help)
      sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) MESSAGE="$1"; shift ;;
  esac
done

# ---------- sanity checks ----------
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not inside a git repository." >&2
  exit 1
fi

BRANCH="$(git branch --show-current)"
if [[ -z "$BRANCH" ]]; then
  echo "Error: detached HEAD state — checkout a branch first." >&2
  exit 1
fi

REMOTE_UPSTREAM="origin/$BRANCH"
if ! git rev-parse --verify "$REMOTE_UPSTREAM" >/dev/null 2>&1; then
  echo "Warning: no upstream branch '$REMOTE_UPSTREAM' yet — skipping pull."
  PULL=false
else
  PULL=true
fi

# ---------- step 1: check for changes ----------
if git diff --quiet && git diff --cached --quiet && [[ -z "$(git ls-files --others --exclude-standard)" ]]; then
  # Nothing to commit — maybe remote has new commits, so still try to fast-forward
  echo "Nothing to commit — checking for updates on remote..."
  if [[ "$PULL" == true && "$DRY_RUN" == false ]]; then
    git pull --rebase origin "$BRANCH"
  fi
  echo "Working tree is clean and up to date."
  exit 0
fi

echo "==> Changed files:"
git status --short

if [[ "$DRY_RUN" == true ]]; then
  echo "Dry run: stopping here, nothing was committed or pushed."
  exit 0
fi

# ---------- step 2: stage everything ----------
echo "==> Staging all changes (including new files)..."
git add -A

# ---------- step 3: commit FIRST (rebase needs a clean tree) ----------
if [[ -z "$MESSAGE" ]]; then
  read -r -p "Commit message: " MESSAGE
  if [[ -z "$MESSAGE" ]]; then
    echo "Empty message — aborting (nothing lost, changes are staged)."
    exit 1
  fi
fi
git commit -m "$MESSAGE"

# ---------- step 4: NOW pull with rebase ----------
if [[ "$PULL" == true ]]; then
  echo "==> Pulling latest changes (rebase) on '$BRANCH'..."
  if ! git pull --rebase origin "$BRANCH"; then
    echo ""
    echo "Rebase hit real conflicts between your commits and the remote."
    echo "Fix the conflicted files, then run:"
    echo "  git add <fixed files> && git rebase --continue"
    echo "or abort with:  git rebase --abort   (your commit is kept on the branch)"
    exit 1
  fi
fi

# ---------- step 5: push ----------
echo "==> Pushing to '$REMOTE_UPSTREAM'..."
git push origin "$BRANCH"

echo ""
echo "Done! '$BRANCH' is up to date on origin."
