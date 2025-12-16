# Btrfs Swap File Setup on Ubuntu

Dealing with Btrfs attributes requires precision. I will provide a completely rewritten and corrected guide, ensuring the crucial steps for disabling Copy-on-Write and Compression are correct.

This guide is the most reliable method for setting up a swap file on an Ubuntu 24.04 Btrfs system.

-----

## 💾 Corrected Guide: Btrfs Swap File Setup

This guide sets up a dedicated subvolume named `@swap` to host your swap file, preventing Btrfs snapshots of your main root filesystem from failing due to the active swap file.

### Prerequisites

  * You are running a modern Linux kernel (5.0+) that supports Btrfs swap files.
  * Your Btrfs filesystem is a single-device volume (not Btrfs RAID/multi-device).
  * The root of your Btrfs partition is mounted at `/`.

### 1\. Create a Dedicated Subvolume

We create a subvolume to isolate the swap file.

```bash
# Create the swap subvolume at the root of your Btrfs partition
sudo btrfs subvolume create /@swap
```

### 2\. Disable Essential Btrfs Features (CRITICAL STEP)

The swap file **MUST** have Copy-on-Write (CoW) disabled and should not be compressed. We use the `chattr` command to apply these attributes to the new subvolume so that the swap file inherits them.

| Attribute | Command | Description |
| :--- | :--- | :--- |
| **No-CoW** | `+C` | Essential for swap files on Btrfs. |
| **No-Compression** | `-c` | Prevents compression inheritance. |

```bash
# Set No-Copy-on-Write (CRITICAL)
sudo chattr +C /@swap

# Ensure No-Compression is set for all files created within
sudo chattr -R -c /@swap
```

### 3\. Create the Swap File

Use the `fallocate` command to create a pre-allocated file. **Do not use `cp /dev/zero` or `dd`** as they may introduce CoW data structures.

**For a 4GB swap file:** (Adjust `4G` as needed)

```bash
sudo fallocate -l 4G /@swap/swapfile
```

### 4\. Verify Attributes on the File (Optional but Recommended)

You can confirm the file attributes are set correctly *after* creation:

```bash
sudo lsattr /@swap/swapfile
```

Look for the letter `c` (no compression) and `C` (no copy-on-write) in the output. The output should look something like:

> `-------------C------ /@swap/swapfile` (The `-c` flag doesn't always show up if compression isn't globally enabled, but the `C` is essential).

### 5\. Secure and Format the Swap File

Set restrictive permissions and format the file as Linux swap space.

```bash
# Set secure permissions (read/write for root only)
sudo chmod 600 /@swap/swapfile

# Format the file as swap
sudo mkswap /@swap/swapfile
```

### 6\. Activate and Make Permanent

Activate the swap file immediately and add an entry to `/etc/fstab` to make it persist across reboots.

#### A. Activate Now

```bash
# Turn the swap on
sudo swapon /@swap/swapfile
```

#### B. Verification

Check if the swap file is active:

```bash
free -h
```

#### C. Make Permanent (Add to /etc/fstab)

Open the file for editing:

```bash
sudo nano /etc/fstab
```

Add the following line to the end of the file. This tells the system to use the swap file on every boot:

```
# Btrfs Swap File Entry
/@swap/swapfile none swap sw 0 0
```

After saving and closing the file, your swap file is ready and will be activated automatically after the next reboot.

-----

Do you want to change the size of the swap file, or would you like to proceed with setting up a reminder to check on the Btrfs snapshots later?
