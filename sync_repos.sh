#!/usr/bin/env bash
# sync_repos.sh - Pull and push updates for Toolbox and Ollama-Starter

REPOS=(
  "$HOME/Projects/github/toolbox"
  "$HOME/Projects/github/ollama-starter"
)

for repo in "${REPOS[@]}"; do
  echo "============================================="
  echo "📂 Syncing repo: $repo"
  echo "---------------------------------------------"
  if [ -d "$repo/.git" ]; then
    cd "$repo" || continue

    echo "🔄 Pulling latest changes..."
    git pull --ff-only

    echo "⬆️ Pushing local commits..."
    git push

    echo "✅ Finished syncing $repo"
  else
    echo "⚠️ Not a git repository: $repo"
  fi
  echo
done
