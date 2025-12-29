Perfect. I’ll walk you through **Fedora manual partitioning (Anaconda)** for **LUKS2 + Btrfs subvolumes**, step by step, **exactly** as I would do it on your ThinkPad.

This is distro-native, clean, and future-proof.

---

# Fedora Manual Partitioning

**Goal:**

* Full-disk encryption (LUKS2)
* Single Btrfs filesystem
* Subvolumes instead of separate partitions
* Works perfectly with Timeshift

---

## 0️⃣ Before you start (important)

In the Fedora installer:

* Choose **Fedora KDE Plasma**
* Keyboard / locale as usual
* When you reach **Installation Destination** → select your **2 TB NVMe**
* Click **Custom** (not Automatic)

---

## 1️⃣ Create the EFI System Partition (unencrypted)

1. Click **+**
2. Mount point:

   ```
   /boot/efi
   ```
3. Size:

   ```
   512 MiB
   ```
4. Filesystem:

   ```
   EFI System Partition
   ```
5. Device type: Standard partition
6. Encryption: ❌ **OFF**

✅ This is mandatory and correct.

---

## 2️⃣ Create the encrypted LUKS2 container

1. Click **+**
2. Mount point:

   ```
   /
   ```

   (temporary — we’ll change this)
3. Size:

   ```
   Max available space
   ```
4. Device type:

   ```
   LUKS
   ```
5. Encryption: ✅ **ON**
6. Set a **strong passphrase**

Click **Modify…**

* Encryption type: **LUKS2**
* Leave defaults (Fedora does the right thing)

---

## 3️⃣ Create Btrfs inside the LUKS container

Still in the same screen:

1. Select the **LUKS device**
2. Click **Modify**
3. Filesystem:

   ```
   Btrfs
   ```
4. Label (optional but recommended):

   ```
   fedora
   ```

Now click **Done** — Fedora will warn you that no mount points are defined. That’s expected.

---

## 4️⃣ Create Btrfs subvolumes (this is the key part)

Now select the **Btrfs filesystem** (inside LUKS) and click **+** for subvolumes.

### Subvolume 1: Root (`/`)

* Mount point:

  ```
  /
  ```
* Subvolume name:

  ```
  @
  ```
* Check **Mount subvolume**
* Leave compression default (zstd)

---

### Subvolume 2: Home (`/home`)

* Mount point:

  ```
  /home
  ```
* Subvolume name:

  ```
  @home
  ```

---

### (Optional but recommended) Subvolume 3: Snapshots

* Mount point:

  ```
  /.snapshots
  ```
* Subvolume name:

  ```
  @snapshots
  ```

---

### (Optional) Subvolume 4: Logs (advanced, optional)

Only if you want to exclude logs from snapshots:

* Mount point:

  ```
  /var/log
  ```
* Subvolume name:

  ```
  @var_log
  ```

You can skip this safely.

---

## 5️⃣ Verify final layout (sanity check)

You should see something like:

```
NVMe 2 TB
├── EFI System Partition 512 MiB → /boot/efi
└── LUKS2 encrypted volume
    └── Btrfs
        ├── @ → /
        ├── @home → /home
        ├── @snapshots → /.snapshots
        └── (@var_log → /var/log) [optional]
```

If it looks like this → **you’re golden**.

---

## 6️⃣ Finish installation

Click **Done** → accept changes → install Fedora.

At first boot:

* You’ll be prompted once for your LUKS passphrase
* Plasma should load normally

---

## 7️⃣ Post-install: Timeshift (important)

### Install Timeshift

```bash
sudo dnf install timeshift
```

### Configure Timeshift

* Snapshot type: **Btrfs**
* Select root filesystem
* Include `/home`
* Exclude:

  * `~/.cache`
  * `~/.local/share/Trash`
  * Large project / VM dirs if needed

### Snapshot schedule (recommended)

* Daily: 3–5
* Weekly: 2–3
* Manual before upgrades

---

## 8️⃣ Why this setup is ideal for *your* usage

* One password at boot
* Full encryption (including `/home`)
* Easy rollbacks while learning/tinkering
* No space juggling between partitions
* Works perfectly docked or mobile
* Desktop-class reliability

This matches:

* Fedora philosophy
* KDE usage
* Your Samsung T7 backup strategy
* “Laptop as primary machine” reality

---

## ⚠️ Common mistakes to avoid

* ❌ Separate `/home` partition
* ❌ LVM + Btrfs together (unnecessary)
* ❌ Rsync Timeshift when Btrfs is available
* ❌ Encrypting `/boot` manually (Fedora doesn’t need it)

---

If you want, next I can:

* Verify **Timeshift exclusions** for photo/video work
* Show how to **snapshot before updates automatically**
* Help you add **automatic unlock with TPM** (ThinkPad supports it)
* Design **desktop ↔ laptop backup & sync** with the T7

Just tell me what you want next.
