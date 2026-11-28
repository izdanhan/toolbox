# WirePlumber (0.5+) Bluetooth Audio Fixes: Prevent HFP/HSP Autoswitch & Force SBC-XQ

Two common Linux desktop Bluetooth audio issues solved cleanly at the user level (`~/.config/wireplumber/`) without modifying system files:

1. **Prevent automatic switching to Hands-Free (HSP/HFP)** when an application or game (e.g., *Elite Dangerous*, Discord, Steam) opens a microphone stream.
2. **Force `SBC-XQ` as the default A2DP codec** to prevent audio dropouts in congested 2.4 GHz environments (where higher-bitrate codecs like `aptX` / `aptX HD` stutter).

**Requirements:** PipeWire + WirePlumber **0.5.0 or newer** (check with `wireplumber --version`). Tested on Pop!_OS / Fedora.

---

## 1. Stop Automatic Switching to Hands-Free (HSP/HFP)

When no dedicated USB/XLR microphone is connected, apps that initialize voice chat force Bluetooth headphones into low-quality mono call mode (`HSP/HFP`).

### Option A: Disable Autoswitch Only (Recommended)
Keeps the `HSP/HFP` profile available in your sound settings if you ever actually need the headset mic, but stops apps from switching to it automatically.

Create `~/.config/wireplumber/wireplumber.conf.d/50-disable-hfp-autoswitch.conf`:

```bash
mkdir -p ~/.config/wireplumber/wireplumber.conf.d

cat << 'EOF' > ~/.config/wireplumber/wireplumber.conf.d/50-disable-hfp-autoswitch.conf
wireplumber.settings = {
  bluetooth.autoswitch-to-headset-profile = false
}
EOF

```

### Option B: Disable HSP/HFP Roles Completely (Strict A2DP-Only)

If you **never** use the built-in Bluetooth headset microphone and want to strip `HSP/HFP` profiles entirely so nothing can ever activate them:

Create `~/.config/wireplumber/wireplumber.conf.d/50-disable-hfp-roles.conf`:

```bash
mkdir -p ~/.config/wireplumber/wireplumber.conf.d

cat << 'EOF' > ~/.config/wireplumber/wireplumber.conf.d/50-disable-hfp-roles.conf
monitor.bluez.properties = {
  bluez5.roles = [ a2dp_sink a2dp_source ]
}
EOF

```

*(Note: Use **either** Option A or Option B. Option A is safer if you ever use the headset for calls without an external mic.)*

---

## 2. Force `SBC-XQ` as the Default A2DP Codec

In dense apartment buildings with dozens of 2.4 GHz Wi-Fi networks, `aptX` and `aptX HD` frequently stutter. `SBC-XQ` delivers near-aptX HD audio quality while maintaining a much more resilient connection.

Restricting the allowed codec list on the device forces WirePlumber to pick `sbc_xq` on every connect/reconnect instead of defaulting to higher-priority `aptX` profiles.

### Step 1: Find Your Device Name

Connect your headphones and run:

```bash
pactl list cards | grep -E "Name: bluez_card|device.description"

```

Copy the card name (for example: `bluez_card.80_C3_BA_52_A1_D4`).

### Step 2: Create the Codec Rule

Replace `bluez_card.XX_XX_XX_XX_XX_XX` below with your actual device name (or use `"~bluez_card.*"` to apply it to **all** Bluetooth audio devices):

```bash
cat << 'EOF' > ~/.config/wireplumber/wireplumber.conf.d/51-force-sbc-xq.conf
monitor.bluez.rules = [
  {
    matches = [
      {
        device.name = "bluez_card.XX_XX_XX_XX_XX_XX"
      }
    ]
    actions = {
      update-props = {
        bluez5.codecs = [ "sbc_xq" "sbc" ]
      }
    }
  }
]
EOF

```

---

## 3. Apply & Verify

Restart WirePlumber and PipeWire:

```bash
systemctl --user restart wireplumber pipewire pipewire-pulse

```

Reconnect your Bluetooth headphones and verify the active profile:

```bash
pactl list cards | grep -A 25 "bluez_card"

```

Expected output:

* `Active Profile: a2dp-sink-sbc_xq`
* Launching a game or voice-enabled app without an external mic keeps the profile locked to `a2dp-sink-sbc_xq`.

---

## Troubleshooting & Rollback

* **No audio after editing config:** Check for typos or missing braces `{}` in `~/.config/wireplumber/wireplumber.conf.d/`. You can test syntax by running `wireplumber` in a terminal to see exact parser errors.
* **Revert to defaults:**
```bash
rm ~/.config/wireplumber/wireplumber.conf.d/50-*.conf ~/.config/wireplumber/wireplumber.conf.d/51-*.conf
systemctl --user restart wireplumber pipewire pipewire-pulse

```
