# Steam firewall ports

Standard Steam client traffic (logging in, downloading, matchmaking) initiates outbound connections and does not require opening inbound ports in `ufw`. However, **Steam Local Network Game Transfers** (and Remote Play) require specific inbound ports open on **both** the host and receiving machines.

### 1. Open Required Ports in UFW

Run the following commands to allow client discovery and file transfers:

```bash
# Client discovery (also covers Remote Play discovery)
sudo ufw allow 27031:27036/udp

# Local network game file transfer stream
sudo ufw allow 27040/tcp

```

*(Optional)* If you also use **Steam Remote Play** to stream games between your desktop and laptop, open the streaming control ports:

```bash
sudo ufw allow 27036:27037/tcp

```

**Tightening OPSEC (Recommended):** By default, those rules expose the ports to any network your laptop connects to. Restrict them to your local subnet (e.g., `192.168.1.0/24` or `10.0.0.0/24` — check yours with `ip -br a`):

```bash
sudo ufw allow from 192.168.1.0/24 to any port 27031:27036 proto udp
sudo ufw allow from 192.168.1.0/24 to any port 27040 proto tcp

```

*Verification:* Run `sudo ufw status` and confirm `27031:27036/udp` and `27040/tcp` are listed as `ALLOW`.

---

### 2. Enable Local Transfers in Steam

1. Open **Steam > Settings > Downloads** on both machines.
2. Toggle **Game File Transfer over Local Network** on.
3. Set the permission level to **Only my own devices** (default, requires the same Steam account logged in on both) or **Only my friends**.

**Operational constraints to keep in mind:**

* **No Big Picture / Gamescope:** A host PC running in Big Picture mode cannot send game files over LAN — keep the host in standard Desktop mode.
* **Fedora Note:** If you are doing this on Fedora, Fedora uses `firewalld` by default rather than `ufw`. Unless you explicitly disabled `firewalld` and installed `ufw`, use `sudo firewall-cmd --add-service=steam-lan-transfer --permanent && sudo firewall-cmd --reload` instead.
* **What transfers:** Only base game depot files transfer. Shader pre-caching, Workshop mods, and save files are skipped and pulled from Valve's servers.

*Verification:* Start a game installation on the receiving machine. The download banner on the **Downloads** page should explicitly state **"Transferring from local network"** alongside the host PC's name.