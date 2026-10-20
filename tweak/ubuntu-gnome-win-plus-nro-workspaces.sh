#!/bin/bash

# 1. Disable Ubuntu Dock / Dash-to-Dock built-in Super + 1..9 app shortcuts
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false

# 2. Clear default GNOME shell app-launching shortcuts (Super + 1..9)
for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

# 3. Re-apply workspace switching (Super + 1..9)
for i in {1..9}; do
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
done

# 4. Re-apply moving windows to workspace (Super + Shift + 1..9)
for i in {1..9}; do
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
done

