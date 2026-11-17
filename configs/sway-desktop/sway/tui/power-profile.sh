#!/usr/bin/env bash

# Query active profile directly from tuned-ppd over D-Bus (no sudo needed)
CURRENT=$(gdbus call --system --dest net.hadess.PowerProfiles \
  --object-path /net/hadess/PowerProfiles \
  --method org.freedesktop.DBus.Properties.Get \
  net.hadess.PowerProfiles ActiveProfile | awk -F"'" '{print $2}')

declare -A PROFILES=(
    ["performance"]=" Performance"
    ["balanced"]="  Balanced"
    ["power-saver"]="  Power Saver"
)

OPTIONS=""
for key in performance balanced power-saver; do
    if [ "$key" == "$CURRENT" ]; then
        OPTIONS+="${PROFILES[$key]} (Active)\n"
    else
        OPTIONS+="${PROFILES[$key]}\n"
    fi
done

SELECTION=$(echo -e -n "$OPTIONS" | rofi -dmenu -p "Power Profile" -i)

set_profile() {
    gdbus call --system --dest net.hadess.PowerProfiles \
      --object-path /net/hadess/PowerProfiles \
      --method org.freedesktop.DBus.Properties.Set \
      net.hadess.PowerProfiles ActiveProfile "<'$1'>" >/dev/null
}

case "$SELECTION" in
    *"Performance"*)
        set_profile "performance"
        notify-send "Power Profile" "Switched to Performance Mode"
        ;;
    *"Balanced"*)
        set_profile "balanced"
        notify-send "Power Profile" "Switched to Balanced Mode"
        ;;
    *"Power Saver"*)
        set_profile "power-saver"
        notify-send "Power Profile" "Switched to Power Saver Mode"
        ;;
    *)
        exit 0
        ;;
esac
