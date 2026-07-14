#!/usr/bin/env bash
# ~/.config/hypr/scripts/dock-handler.sh

INTERNAL="eDP-1"
EXTERNAL="DP-5"

# Check if the external monitor is physically connected
if hyprctl monitors all | grep -q "$EXTERNAL"; then
    # We are docked. Disable internal screen, enable DP-5
    hyprctl keyword monitor "$INTERNAL, disable"
    hyprctl keyword monitor "$EXTERNAL, 2560x1440@143.97, 0x0, 1, vrr, 1"
else
    # Undocked. Fallback to laptop screen
    hyprctl keyword monitor "$INTERNAL, 1920x1200@60, auto, 1, vrr, 1"
    hyprctl keyword monitor "$EXTERNAL, disable"
fi
