#!/usr/bin/env bash

# Define the display configurations based on your hardware
# Format: name, resolution@hz, position, scale
EDP="eDP-1,1920x1200@60,auto,1, vrr, 1"
DP="DP-6,2560x1440@120,auto,1"
HDMI="HDMI-A-1,3840x2160@120,auto,2, vrr, 1"

# Menu options for Rofi
OPTIONS="󰍹 Laptop display(eDP-1)\n󰑭 Desktop display (DP-6)\n󰗺 TV (HDMI-A-1)"

# Run Rofi
SELECTION=$(echo -e "$OPTIONS" | rofi -dmenu -p "Display Profile" -i)

case "$SELECTION" in
    *"Laptop"*)
        hyprctl keyword monitor "$EDP"
        hyprctl keyword monitor "DP-6,disable"
        hyprctl keyword monitor "HDMI-A-1,disable"
        notify-send "Display Profile" "Switched to laptop display" --icon=video-display
        ;;
    *"Desktop"*)
        hyprctl keyword monitor "$DP"
        hyprctl keyword monitor "eDP-1,disable"
        hyprctl keyword monitor "HDMI-A-1,disable"
        notify-send "Display Profile" "Switched to desktop display" --icon=video-display
        ;;
    *"TV"*)
        hyprctl keyword monitor "$HDMI"
        hyprctl keyword monitor "eDP-1,disable"
        hyprctl keyword monitor "DP-6,disable"
        notify-send "Display Profile" "Switched to TV" --icon=video-display
        ;;
esac
