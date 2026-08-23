#!/usr/bin/env bash

# Toggle Wi-Fi state
nmcli radio wifi $(nmcli radio wifi | grep -q "enabled" && echo "off" || echo "on")

# Get new state for notification
STATUS=$(nmcli radio wifi)

if [ "$STATUS" = "enabled" ]; then
    notify-send -u low -i network-wireless-full "Wi-Fi" "Interface Enabled"
else
    notify-send -u low -i network-wireless-offline "Wi-Fi" "Interface Disabled"
fi
