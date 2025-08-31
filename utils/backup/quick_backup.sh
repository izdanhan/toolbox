#!/usr/bin/env bash
# Quick tarball backup of a folder
# Usage: quick_backup.sh ~/Projects
set -e

TARGET_DIR=$1
BACKUP_DIR=~/Backups
mkdir -p "$BACKUP_DIR"

STAMP=$(date +"%Y-%m-%d_%H-%M-%S")
tar -czf "$BACKUP_DIR/backup_$(basename "$TARGET_DIR")_$STAMP.tar.gz" "$TARGET_DIR"

echo "Backup created at $BACKUP_DIR"
