#!/usr/bin/env bash

# Uses clean Nerd Font glyphs: Network (󰖩), Audio (󰕾), Bluetooth (󰂯), Config Files (󱔗)
options="󰕾 Audio Mixer (wiremix)\n󰂯 Bluetooth (bluetui)\n󰖩 Network (nmtui)\n󱔗 Alacritty Config\n󱔗 Hyprland Config\n󱔗 Waybar Config"

# Kept strictly on one line to prevent Rofi parser errors
choice=$(echo -e "$options" | rofi -dmenu -p "System Config" -theme-str 'window { width: 320px; height: 170px; font: "UbuntuMono Nerd Font 14"; } inputbar { enabled: false; } listview { scrollbar: false; }')

case "$choice" in
    *"Audio"*)
        alacritty --class "floating_tui" -e "$HOME/.cargo/bin/wiremix" --tab output
        ;;
    *"Bluetooth"*)
        alacritty --class "floating_tui" -e "$HOME/.cargo/bin/bluetui"
        ;;
    *"Network"*)
        alacritty --class "floating_tui" -e nmtui
        ;;
    *"Alacritty"*)
        alacritty -e fresh ~/.config/alacritty/alacritty.toml
        ;;   
    *"Hyprland"*)
        alacritty -e fresh ~/.config/hypr/hyprland.conf
        ;;     
    *"Waybar"*)
        alacritty -e fresh ~/.config/waybar/config.jsonc
        ;; 
esac
