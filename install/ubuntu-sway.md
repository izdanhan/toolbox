# Installing Sway on Ubuntu

Good choice. **Sway + AMD ThinkPad + dock + 144 Hz monitor** is a very nice Linux setup.

I’ll walk you through a **clean Sway setup on Linux Mint 22.3 (Ubuntu 24.04 base)**.

---

# 1. Install Sway and basic tools

Everything you need is in Ubuntu 24.04 repos, no PPA required.

```bash
sudo apt update

sudo apt install \
  sway \
  swaybg \
  swayidle \
  swaylock \
  waybar \
  wofi \
  foot \
  mako-notifier \
  grim \
  slurp \
  wl-clipboard \
  thunar \
  network-manager-gnome \
  blueman
```

This gives you a full usable environment:

* Window manager
* Bar
* Launcher
* Terminal
* Notifications
* Screenshots
* File manager
* Network & Bluetooth GUI

---

# 2. Log into Sway

After install:

1. Log out
2. On login screen
3. Click session icon / gear
4. Choose **Sway**
5. Log in

First start will ask:

> Create default config? → **Yes**

---

# 3. Important default keybindings (very important)

Sway uses **Super key (Windows key)** as modifier.

| Key                   | Action                    |
| --------------------- | ------------------------- |
| Super + Enter         | Open terminal             |
| Super + D             | App launcher              |
| Super + Shift + E     | Exit Sway                 |
| Super + Shift + Q     | Close window              |
| Super + Arrow keys    | Move focus                |
| Super + Shift + Arrow | Move window               |
| Super + 1–9           | Switch workspace          |
| Super + Shift + 1–9   | Move window to workspace  |
| Super + F             | Fullscreen                |
| Super + H/V           | Split horizontal/vertical |

Memorize these and you’re good.

---

# 4. Config file location

Your config:

```bash
~/.config/sway/config
```

Edit with:

```bash
nano ~/.config/sway/config
```

---

# 5. Set your monitor (important for your 144Hz display)

First check display name:

```bash
swaymsg -t get_outputs
```

You’ll see something like:

```
DP-1
eDP-1
HDMI-A-1
```

Then add to config:

```bash
output DP-1 resolution 2560x1440 refresh 144Hz
output eDP-1 resolution 1920x1200
```

For dock setups this is very important.

---

# 6. Autostart important programs

Add to bottom of config:

```bash
exec waybar
exec mako
exec nm-applet
exec blueman-applet
```

---

# 7. Screenshot keybinding

Add to config:

```bash
bindsym Print exec grim -g "$(slurp)" - | wl-copy
```

Then **Print Screen → select area → screenshot copied to clipboard**

---

# 8. Lock screen + suspend

Add:

```bash
exec swayidle -w \
 timeout 300 'swaylock -f -c 000000' \
 timeout 600 'swaymsg "output * dpms off"' \
 resume 'swaymsg "output * dpms on"' \
 before-sleep 'swaylock -f -c 000000'
```

---

# 9. Recommended programs for tiling setup

Install these too:

```bash
sudo apt install \
  firefox \
  kitty \
  neovim \
  htop \
  btop \
  brightnessctl \
  pavucontrol
```

---

# 10. Very common Sway ecosystem apps

These are worth knowing:

| Purpose       | App          |
| ------------- | ------------ |
| Bar           | waybar       |
| Launcher      | wofi         |
| Terminal      | foot / kitty |
| Notifications | mako         |
| Lock          | swaylock     |
| Screenshots   | grim + slurp |
| Clipboard     | wl-clipboard |
| File manager  | thunar       |
| Audio control | pavucontrol  |
| Network       | nm-applet    |

This is basically a full desktop built from components.

---

# 11. Next things you will probably want later

After you use Sway for a bit, people usually start customizing:

* Waybar config
* Themes / GTK theme
* Fonts
* Gaps between windows
* Laptop lid dock behavior
* Workspace per monitor
* Autostart apps
* Power management

---

# If you want, next I can help you with:

**Dock + laptop workflow**, like:

* Laptop screen workspace
* External monitor workspace
* Auto switch when docking
* Lid closed when docked

That’s very common ThinkPad + dock setup.
