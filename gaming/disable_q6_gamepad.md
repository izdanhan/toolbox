# Keychron Q6 Pro disable "joystick"



### The Universal Universal Deployment Guide

#### 1. Create the Unified Rule File

Open a terminal on either machine. Use this command to create a rule file under the standard administrative path `/etc/udev/rules.d/`:

```bash
sudo nano /etc/udev/rules.d/99-block-keychron-joystick.rules

```

#### 2. Insert the Code Blocks

Paste the following block exactly as written. This accomplishes two things: it wipes out the `ID_INPUT_JOYSTICK` environment flags so Steam/SDL ignores it, and it forcefully nukes the `/dev/input/jsX` legacy node if the kernel tries to spawn it for Vendor `3434`.

```text
# Disable Keychron virtual joystick/gamepad interfaces universally
SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ENV{ID_INPUT_JOYSTICK}="", ENV{ID_INPUT_GAMEPAD}=""
KERNEL=="js*", ATTRS{idVendor}=="3434", RUN+="/bin/rm /dev/input/%k"

```

Save and exit (`Ctrl+O`, `Enter`, then `Ctrl+X`).

#### 3. Trigger and Apply (No Reboot Required)

Force `udev` to parse the new configuration and apply it to currently connected devices:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger

```

#### 4. Power Cycle the Hardware Connection

For the hardware to register under the new rules, reset the interface:

* **If wired:** Unplug the USB-C cable and plug it back in.
* **If Bluetooth:** Toggle the physical switch on the back of the Q6 Pro to **OFF**, then back to **BT**.

### Verification

To ensure the ghost joystick is dead on both environments, check if any legacy joystick mappings remain for the input devices:

```bash
ls /dev/input/js*

```

If it returns `ls: cannot access '/dev/input/js*': No such file or directory`, the rule executed flawlessly. Your keyboard will now behave exclusively as a keyboard on both machines.
