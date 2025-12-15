#!/usr/bin/env bash
# Manage Ollama models (list size, backup)

set -e
MODELS_DIR="$HOME/.ollama/models"

echo "📂 Models directory: $MODELS_DIR"

case "${1:-}" in
  list) ls -lh "$MODELS_DIR" ;;
  size) du -sh "$MODELS_DIR" ;;
  backup)
    OUT="$HOME/ollama-models-backup-$(date +%Y%m%d).tar.gz"
    tar czf "$OUT" -C "$HOME/.ollama" models
    echo "✅ Backup saved to $OUT"
    ;;
  *) echo "Usage: $0 [list|size|backup]" ; exit 1 ;;
esac
