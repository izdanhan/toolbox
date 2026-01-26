Absolutely 👍
Below are **clean, copy-paste terminal scripts** for **firewalld** on **Arch Linux + KDE**, one for a **laptop** and one for a **desktop**.
They assume **plasma-firewall + firewalld**.

---

# 🔹 Before you start (once)

```bash
sudo pacman -S firewalld plasma-firewall
sudo systemctl enable --now firewalld
```

(Optional reset if you experimented before)

```bash
sudo firewall-cmd --complete-reload
```

---

# 💻 LAPTOP SCRIPT (Wi-Fi roaming, secure by default)

### Policy

* Wi-Fi → `public`
* Ethernet (home) → `home`
* KDE Connect works at home
* SSH optional (commented)

---

### 🔧 Laptop setup script

```bash
#!/bin/bash

# === INTERFACES ===
WIFI_IF="wlp0s20f3"    # change to your Wi-Fi interface
ETH_IF="enp3s0"       # change if you have Ethernet

# === ZONES ===
sudo firewall-cmd --set-default-zone=public

# Assign interfaces
sudo firewall-cmd --zone=public --add-interface=$WIFI_IF --permanent
sudo firewall-cmd --zone=home   --add-interface=$ETH_IF  --permanent

# === HOME ZONE SERVICES ===
sudo firewall-cmd --zone=home --add-service=kdeconnect --permanent
sudo firewall-cmd --zone=home --add-service=mdns       --permanent
sudo firewall-cmd --zone=home --add-service=ipp        --permanent

# Optional SSH on home network only
# sudo firewall-cmd --zone=home --add-service=ssh --permanent

# === RELOAD ===
sudo firewall-cmd --reload

echo "✅ Laptop firewall configured"
sudo firewall-cmd --get-active-zones
```

---

# 🖥 DESKTOP SCRIPT (Trusted LAN)

### Policy

* Ethernet → `home`
* KDE Connect enabled
* LAN services allowed
* SSH optional

---

### 🔧 Desktop setup script

```bash
#!/bin/bash

# === INTERFACE ===
ETH_IF="enp3s0"   # change to your Ethernet interface

# === ZONES ===
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --zone=home --add-interface=$ETH_IF --permanent

# === SERVICES ===
sudo firewall-cmd --zone=home --add-service=kdeconnect --permanent
sudo firewall-cmd --zone=home --add-service=mdns       --permanent
sudo firewall-cmd --zone=home --add-service=ipp        --permanent
sudo firewall-cmd --zone=home --add-service=samba      --permanent

# Optional SSH
# sudo firewall-cmd --zone=home --add-service=ssh --permanent

# === RELOAD ===
sudo firewall-cmd --reload

echo "✅ Desktop firewall configured"
sudo firewall-cmd --get-active-zones
```

---

# 🔍 Find your interface names (important)

```bash
ip link
```

Typical names:

* Wi-Fi → `wlp*`
* Ethernet → `enp*`

---

# 🧪 Test rules safely

```bash
firewall-cmd --zone=home --list-all
firewall-cmd --zone=public --list-all
```

KDE Connect test:

```bash
firewall-cmd --list-services --zone=home
```

---

# 🔒 Extra hardening (optional, laptop)

Block all incoming except established:

```bash
sudo firewall-cmd --zone=public --set-target=DROP --permanent
sudo firewall-cmd --reload
```

---

## Want more?

I can give you:

* 🔁 **Single script that auto-detects Wi-Fi vs Ethernet**
* 🧳 **Travel mode toggle script**
* 🧪 **Rollback / panic reset script**
* 🛡 **Ultra-locked laptop preset**

Just tell me which one you want.
