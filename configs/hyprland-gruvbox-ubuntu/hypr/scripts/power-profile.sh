#!/usr/bin/env bash

# Get profiles and clean up the output
CHOSEN=$(echo -e "performance\nbalanced\npower-saver" | rofi -dmenu -p "Power Profile:")

# If using wofi, uncomment below and comment out the rofi line:
# CHOSEN=$(echo -e "performance\nbalanced\npower-saver" | wofi --dmenu --pmenu "Power Profile:")

if [ -n "$CHOSEN" ]; then
    powerprofilesctl set "$CHOSEN"
    notify-send "Power Profile" "Switched to $CHOSEN" -i bst-battery
fi
