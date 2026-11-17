#!/usr/bin/env bash

# Uses clean Nerd Font glyphs: Network (󰖩), Audio (󰕾), Bluetooth (󰂯), Config Files (󱔗)
options="󰕾 Audio Mixer (wiremix)\n󰂯 Bluetooth (bluetui)\n󰖩 Network (nmtui-go)\n󱔗 Kitty Config\n󱔗 Sway Config"

# Kept strictly on one line to prevent Rofi parser errors
choice=$(echo -e "$options" | rofi -dmenu -p "System Config" -theme-str 'window { width: 320px; height: 160px; font: "AdwaitaMono Nerd Font 14"; } inputbar { enabled: false; } listview { scrollbar: false; }')    

case "$choice" in
    *"Audio"*)
        kitty --class "floating_tui" -e "wiremix" --tab output
        ;;
    *"Bluetooth"*)
        kitty --class "floating_tui" -e "$HOME/.cargo/bin/bluetui"
        ;;
    *"Network"*)
        kitty --class "floating_tui" -e nmtui-go
        ;;
    *"Kitty"*)
        kitty -e fresh ~/.config/kitty/kitty.conf
        ;;   
    *"Sway"*)
        kitty -e fresh ~/.config/sway/config
        ;;     
esac
