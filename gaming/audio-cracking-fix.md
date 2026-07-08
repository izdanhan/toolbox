# Audio cracking fix

The structural architecture of the audio stack on both Ubuntu 26.04 and Fedora 44 is identical: **PipeWire** manages the core engine, **WirePlumber** acts as the policy engine, and **`pipewire-pulse`** handles legacy/Flatpak audio hooks.

The universal, future-proof approach to fix latency/underrun crackling is to drop clean rule snippets into the user configuration directory (`~/.config/`). This bypasses the old, messy practice of copying monolithic, volatile system files into home space.

Here is the universal deployment blueprint for your ThinkPad and Desktop.

---

## The Drop-In Configuration Strategy

### 1. Fix Flatpak Emulation Under-runs (`pipewire-pulse`)

Flatpaks like RetroDeck use the PulseAudio compatibility layer. We need to raise the floor of the minimum quantum size.

Execute in the terminal (works universally on Ubuntu and Fedora):

```bash
mkdir -p ~/.config/pipewire/pipewire-pulse.conf.d

```

Create and write a persistent, clean drop-in snippet:

```bash
cat << 'EOF' > ~/.config/pipewire/pipewire-pulse.conf.d/99-retro-buffer.conf
pulse.properties = {
    pulse.min.quantum = 512/48000
}
EOF

```

### 2. Standardize Core Engine Clock Latency (`pipewire`)

Next, ensure the core PipeWire server doesn't allow applications to force erratic, ultra-low cycles that your hardware's internal clock wastes cycles processing.

Create the core configuration drop-in directory:

```bash
mkdir -p ~/.config/pipewire/pipewire.conf.d

```

Write the floor limits:

```bash
cat << 'EOF' > ~/.config/pipewire/pipewire.conf.d/99-core-latency.conf
context.properties = {
    default.clock.min-quantum = 512
}
EOF

```

---

## Activation Matrix

To commit these runtime changes without nuking your active user session, reload the user-level systemd units.

### For Ubuntu 26.04 LTS (Gnome / Systemd) & Fedora 44 (KDE Plasma)

```bash
systemctl --user restart wireplumber pipewire pipewire-pulse

```

### Verification Command

Run the execution monitor to ensure the state machine is operating at the targeted rate when RetroDeck is running audio:

```bash
pw-top

```

*Look at the **QUANT** column for the RetroDeck/RetroArch PID. It should read `512` consistently instead of jumping down to `64` or `128` during heavy emulation frames.*
