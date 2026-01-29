#!/usr/bin/env bash

# Change these if your xrandr names are different
DP="DP-0"
HDMI="HDMI-0"

xrandr --output "$HDMI" --auto --primary \
       --output "$DP"   --off
       