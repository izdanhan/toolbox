#!/bin/bash

# Ensure script halts on error
set -e

echo "Configuring KDE Plasma virtual desktop shortcuts..."

for i in {1..4}; do
    # Switch to Desktop i -> Meta + i
    kwriteconfig6 --file kglobalshortcutsrc --group "kwin" --key "Switch to Desktop $i" "Meta+$i,,Switch to Desktop $i"
    
    # Move Window to Desktop i -> Meta + Shift + i
    kwriteconfig6 --file kglobalshortcutsrc --group "kwin" --key "Window to Desktop $i" "Meta+Shift+$i,,Window to Desktop $i"
done

echo "Updating global shortcut daemon..."
systemctl --user restart plasma-kglobalaccel.service || true

echo "Configuration applied. If keys do not bind instantly, log out and log back in."
