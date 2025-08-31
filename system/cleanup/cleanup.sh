#!/usr/bin/env bash
# Cleanup system caches and unused packages (Fedora/Ubuntu aware)

set -e

if command -v dnf &>/dev/null; then
  echo "🧹 Fedora cleanup with dnf"
  sudo dnf autoremove -y || true
  sudo dnf clean all -y || true
elif command -v apt-get &>/dev/null; then
  echo "🧹 Ubuntu cleanup with apt"
  sudo apt-get autoremove -y || true
  sudo apt-get autoclean -y || true
else
  echo "⚠️ Unsupported package manager. Skipping package cleanup."
fi

echo "🧼 Clearing user cache (~/.cache)"
rm -rf "$HOME/.cache/"* 2>/dev/null || true
echo "✅ Done."
