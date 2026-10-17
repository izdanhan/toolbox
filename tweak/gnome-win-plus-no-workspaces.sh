#!/bin/bash

# 1. Clear app-launching shortcuts (Super + 1..9)
for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

# 2. Re-apply workspace switching (Super + 1..9)
for i in {1..9}; do
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
done

# 3. Re-apply moving windows to workspace (Super + Shift + 1..9)
for i in {1..9}; do
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
done
