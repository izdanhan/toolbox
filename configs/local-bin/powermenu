#!/usr/bin/env bash

# Uses standard Nerd Font glyphs: Lock (󰌾), Logout (󰍃), Reboot (), Suspend (󰤄), Power Off (󰐥)
op=$(echo -e "󰌾 Lock\n󰍃 Logout\n Reboot\n󰤄 Suspend\n󰐥 Power Off" | rofi -dmenu -p "Power menu" -theme-str 'window { width: 320px; height: 160px; font: "JetBrainsMono Nerd Font 11"; } inputbar { enabled: false; } listview { scrollbar: false; }')

case "$op" in
    *"Lock"*)
        hyprlock
        ;;
    *"Logout"*)
        hyprctl dispatch exit
        ;;
    *"Reboot"*)
        systemctl reboot
        ;;
    *"Suspend"*)
        systemctl suspend
        ;;
    *"Power Off"*)
        systemctl poweroff
        ;;
esac
