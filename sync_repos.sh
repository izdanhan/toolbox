#!/usr/bin/env bash
# sync_repos.sh - Pull latest changes, then commit & push updates for all repos

set -e

# If no commit message is given, generate one with a timestamp
if [ -z "$1" ]; then
  MSG="update-$(date +'%Y-%m-%d-%H%M%S')"
else
  MSG="$1"
fi

### Misc Scripts ###
echo "🔄 Pulling misc-scripts..."
cd ~/Projects/github/misc-scripts
git pull
git add .
git commit -m "$MSG" || echo "ℹ️ No changes to commit in misc-scripts"
git push

### Ollama Starter ###
echo "🔄 Pulling ollama..."
cd ~/Projects/github/ollama-starter
git pull
git add .
git commit -m "$MSG" || echo "ℹ️ No changes to commit in ollama"
git push

echo "✅ All repos synced with message: $MSG"

