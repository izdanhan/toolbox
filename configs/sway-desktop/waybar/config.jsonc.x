{
    "layer": "top",
    "position": "top",
    "height": 32,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["network", "cpu", "memory", "pulseaudio", "battery"],

    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{name}"
    },
    "clock": {
        "format": "{:%Y-%m-%d %H:%M}"
    },
"cpu": {
        "format": "CPU: {usage}%",
        "tooltip": false,
        "on-click": "alacritty --class floating_tui -e btop"
    },
    "memory": {
        "format": "RAM: {}%",
        "on-click": "alacritty --class floating_tui -e btop"
    },
    "network": {
        "interval": 2,
        "format-wifi": "󰖩  {essid}   {bandwidthUpBytes}  {bandwidthDownBytes}",
        "format-ethernet": "󰈀  {ifname}   {bandwidthUpBytes}  {bandwidthDownBytes}",
        "format-disconnected": "󰖪  Disconnected",
        "tooltip-format": "{ifname} via {gwaddr}",
        "tooltip-format-wifi": "{essid} ({signalStrength}%)",
        "tooltip-format-ethernet": "{ifname} 󰈀",
        "tooltip-format-disconnected": "Disconnected",
        "on-click": "alacritty --class floating_tui -e nmtui"
    },
    "pulseaudio": {
        "format": "VOL: {volume}%",
        "format-muted": "MUTED",
        "on-click": "alacritty --class floating_tui -e /home/daniel/.cargo/bin/wiremix --tab output"
    },
    "battery": {
        "bat": "BAT0",
        "interval": 10,
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": "󱐌 {icon} {capacity}%",
        "format-plugged": " {icon} {capacity}%",
        "format-full": "󰂅 {capacity}%",
        "format-not-charging": "󰚥 {icon} {capacity}%",
        "format-icons": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
        "on-click": "alacritty --class floating_tui -e sudo powertop"
    }
}    