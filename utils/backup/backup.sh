#!/usr/bin/env bash
# Simple backup script

SOURCE="${1:-$HOME/Projects}"
DEST_DIR="${2:-$HOME/Backups}"
mkdir -p "$DEST_DIR"
DEST="$DEST_DIR/projects-$(date +%Y%m%d_%H%M%S).tar.gz"

echo "📦 Backing up $SOURCE to $DEST"
tar czf "$DEST" "$SOURCE"
echo "✅ Backup complete."
