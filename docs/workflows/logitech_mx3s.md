
---

# 🖱️ Logitech MX Master 3S on Fedora 42 (with logiops/logid)

This guide sets up the **Logitech MX Master 3S** mouse on Fedora 42, enabling the **side scroll wheel (thumbwheel)** to control **Zoom In/Out**, plus advanced features like SmartShift, gestures, and button remapping.

---

## 1. Install Dependencies

```bash
# sudo dnf install cmake gcc-c++ systemd-devel libevdev-devel libudev-devel yaml-cpp-devel git glib2-devel libconfig-devel

# From https://github.com/PixlOne/logiops
# sudo dnf install cmake libevdev-devel systemd-devel libconfig-devel gcc-c++ glib2-devel
```

---

## 2. Clone & Build `logiops`

```bash
git clone https://github.com/PixlOne/logiops.git
cd logiops
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
```

To install, run `sudo make install` after building. You can set the daemon to start at boot by running `sudo systemctl enable logid` or `sudo systemctl enable --now logid` if you want to enable and start the daemon.

---

## 3. Create Config Directory

```bash
sudo mkdir -p /etc
```

---

## 4. Create/Edit Config File

Open `/etc/logid.conf` in your editor:

```bash
sudo nano /etc/logid.conf
```

```yaml
devices: (
  {
    name: "MX Master 3S";

    # ─────────────────────────────
    # General settings
    # ─────────────────────────────
    smartshift: {
      on: true;        # auto switch smooth/ratchet scroll
      threshold: 30;   # force required to switch mode
    };

    hiresscroll: {
      hires: true;     # enable high-resolution scrolling
      invert: false;   # normal direction
      target: false;
    };

    thumbwheel: {
      divert: true;    # divert side wheel events so we can remap
      invert: false;
    };

    # ─────────────────────────────
    # Button / wheel mappings
    # ─────────────────────────────
    buttons: (
      # Gesture button (under thumb) -> virtual desktop navigation
      {
        cid: 0x53;
        action = {
          type: "Gestures";
          gestures: (
            { direction: "Up";    action = { type: "Keypress"; keys: ["CTRL", "ALT", "Up"];    }; },
            { direction: "Down";  action = { type: "Keypress"; keys: ["CTRL", "ALT", "Down"];  }; },
            { direction: "Left";  action = { type: "Keypress"; keys: ["CTRL", "ALT", "Left"];  }; },
            { direction: "Right"; action = { type: "Keypress"; keys: ["CTRL", "ALT", "Right"]; }; }
          );
        };
      },

      # Back button -> Open terminal
      # {
      #  cid: 0x56;
      #  action = { type: "Keypress"; keys: ["CTRL", "ALT", "T"]; };
      # },

      # Forward button -> Volume down
      #{
      #  cid: 0x57;
      #  action = { type: "Keypress"; keys: ["XF86AudioLowerVolume"]; };
      #},

       Side scroll wheel left -> Zoom Out
      {
        cid: 0x5b;
        action = { type: "Keypress"; keys: ["CTRL", "KPMinus"]; };
      },

      # Side scroll wheel right -> Zoom In
      {
        cid: 0x5c;
        action = { type: "Keypress"; keys: ["CTRL", "KPPlus"]; };
      }
    );
  }
);

# ─────────────────────────────
# Common keybindings reference
# Uncomment and swap into actions
# ─────────────────────────────
#
# XF86AudioMute           → mute/unmute audio
# XF86AudioLowerVolume    → volume down
# XF86AudioRaiseVolume    → volume up
# XF86AudioPlay           → play/pause
# XF86AudioPause          → pause
# XF86AudioNext           → next track
# XF86AudioPrev           → previous track
#
# XF86MonBrightnessUp     → brightness up
# XF86MonBrightnessDown   → brightness down
#
# CTRL, ALT, SHIFT, SUPER → modifiers (combine with letters/arrows)
#
# Examples:
#
# { cid: 0x57; action = { type: "Keypress"; keys: ["XF86AudioMute"]; }; }
# { cid: 0x57; action = { type: "Keypress"; keys: ["XF86AudioRaiseVolume"]; }; }
# { cid: 0x57; action = { type: "Keypress"; keys: ["XF86AudioNext"]; }; }
# { cid: 0x57; action = { type: "Keypress"; keys: ["CTRL", "ALT", "L"]; }; } # lock screen
# { cid: 0x57; action = { type: "Keypress"; keys: ["CTRL", "SHIFT", "N"]; }; } # new window

```

## 5. Enable & Start Service

```bash
sudo systemctl enable --now logid
```

Check that it’s running:

```bash
systemctl status logid
```

---

## 6. Test Your Setup

* **Side scroll wheel left** → Zoom Out (`CTRL + -`)
* **Side scroll wheel right** → Zoom In (`CTRL + +`)
* **Gesture button + mouse movement** → switch desktops (`CTRL+ALT+Arrow`).
* **Back button** → open terminal.
* **Forward button** → lower volume.
* **SmartShift** → auto toggles between ratchet/smooth scrolling.

---

## 7. Optional: Battery + Quick Settings (Solaar)

```bash
sudo dnf install solaar
```

Run it from apps menu → battery info + simple toggles (hi-res scroll, thumbwheel diversion).

---

## 🔑 MX Master 3S CID Reference Table

| **Button / Control**         | **CID** | **Notes**               |
| ---------------------------- | ------- | ----------------------- |
| Left Click                   | `0x50`  | Rarely remapped         |
| Right Click                  | `0x51`  | Rarely remapped         |
| Middle Click (wheel press)   | `0x52`  | Scroll wheel button     |
| Gesture Button (under thumb) | `0x53`  | Used for gestures       |
| Scroll Wheel Up              | `0x54`  | Main wheel up           |
| Scroll Wheel Down            | `0x55`  | Main wheel down         |
| Thumb Button (Back)          | `0x56`  | Default: Back           |
| Thumb Button (Forward)       | `0x57`  | Default: Forward        |
| Side Scroll Wheel (Left)     | `0x5b`  | Used above for Zoom Out |
| Side Scroll Wheel (Right)    | `0x5c`  | Used above for Zoom In  |

---

# ✅ Summary

* Side scroll wheel is remapped to **Zoom In/Out**.
* Gesture button, SmartShift, and other buttons can be customized.
* `cid` table lets you expand mappings.
* Config is stored in `/etc/logid.conf`.

---
