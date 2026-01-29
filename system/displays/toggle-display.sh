#!/usr/bin/env bash
# ~/toggle-monitor.sh

DP="DP-0"
HDMI="HDMI-0"

# If DP is currently primary → switch to HDMI
if xrandr | grep -q "$DP connected primary"; then
    xrandr --output "$HDMI" --auto --primary \
           --output "$DP"   --off
else
    xrandr --output "$DP"   --auto --primary \
           --output "$HDMI" --off
fi
