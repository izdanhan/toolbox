This is a known issue with **Keychron Q-series** keyboards on Linux. Because they are highly programmable, they identify themselves as multiple devices to the OS, including a "System Control" device that Linux mistakenly flags as a **joystick**.

Since Linux sees it as a joystick, it grabs "Port 1" in RetroArch before you even turn on your Xbox controller.

### The Fix: Create a udev Rule

You need to tell Linux to ignore the Keychron's "joystick" identity. This is a permanent fix that won't interfere with the keyboard's normal typing functions.

1. **Find your IDs:** Open a terminal and run:
```bash
lsusb | grep Keychron

```


You should see something like `ID 3434:0661`. The first part is the **Vendor ID** (`3434`), and the second is the **Product ID** (`0361`). **Note yours down.**
2. **Create the rule file:**
```bash
sudo nano /etc/udev/rules.d/99-keychron-ignore-joy.rules

```


3. **Paste this inside** (replace `3434` and `0661` with your actual IDs from step 1):
```text
# Keychron Q6 Pro - Disable Joystick Mode
SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0661", ENV{ID_INPUT_JOYSTICK}=""

```


4. **Save and Reload:**
Press `Ctrl+O`, `Enter`, then `Ctrl+X`. Then run:
```bash
sudo udevadm trigger

```



### Why this works

This rule tells the Linux kernel: "If you see this specific device, clear its `ID_INPUT_JOYSTICK` property." Now, when RetroArch starts, it will ignore the keyboard and look for the next available device—your Xbox Elite 2—and put it on **Port 1**.

---

### The "Quick & Dirty" RetroArch Fix

If you don't want to mess with system rules, you can force RetroArch to use a specific index, though it’s less stable:

* Go to **Settings** → **Input** → **RetroPad Binds** → **Port 1 Controls**.
* Manually change **Device Index** from "Keychron" to "Xbox Wireless Controller."
* **Save Configuration** immediately.

**Note:** The udev rule is much better because it solves the problem for *all* your emulators (including standalone ones) at once.
