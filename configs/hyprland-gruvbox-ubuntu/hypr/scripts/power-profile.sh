#!/usr/bin/env bash

# Get currently active profile
CURRENT=$(powerprofilesctl get)

# Map profiles to clean UI names with icons (Requires Nerd Fonts)
declare -A PROFILES=(
    ["performance"]=" Performance"
    ["balanced"]="  Balanced"
    ["power-saver"]="  Power Saver"
)

# Format the list for Rofi
OPTIONS=""
for key in "${!PROFILES[@]}"; do
    if [ "$key" == "$CURRENT" ]; then
        # Highlight the current profile in the menu list
        OPTIONS+="${PROFILES[$key]} (Active)\n"
    else
        OPTIONS+="${PROFILES[$key]}\n"
    fi
done

# Run Rofi in dmenu mode
# -dmenu: acts as a filter
# -p: sets the prompt text
# -i: case-insensitive matching
SELECTION=$(echo -e -n "$OPTIONS" | rofi -dmenu -p "Power Profile" -i)

# Match selection and apply
case "$SELECTION" in
    *"Performance"*)
        powerprofilesctl set performance
        notify-send "Power Profile" "Switched to Performance Mode" --icon=battery-level-100-charging
        ;;
    *"Balanced"*)
        powerprofilesctl set balanced
        notify-send "Power Profile" "Switched to Balanced Mode" --icon=battery-level-50
        ;;
    *"Power Saver"*)
        powerprofilesctl set power-saver
        notify-send "Power Profile" "Switched to Power Saver Mode" --icon=battery-level-10-low
        ;;
    *)
        # Exit if escaped or closed without selection
        exit 0
        ;;
esac
