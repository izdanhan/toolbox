# Ubuntu 26.04 LTS Server deployment

## Phase 1: Base System, Docker, & Tailscale Setup

Execute these steps directly in your terminal post-installation to ready the host.

### 1. Install Docker & Docker Compose

```bash
sudo apt update && sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker

```

### 2. Install & Connect Tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

```

* Follow the authentication link printed in the terminal to bind the machine to your Tailscale network. Your laptop can now reach this server securely from anywhere using its Tailscale IP address or MagicDNS hostname.

---

## Phase 2: Directory & Stack Architecture

We will structure your deployment files inside `/opt/stacks` so **Dockge** can manage everything natively via its web UI.

### 1. Initialize Folders

```bash
sudo mkdir -p /opt/stacks/homeserver
sudo chown -R $USER:$USER /opt/stacks

```

### 2. Create the Unified `docker-compose.yml`

Create and open the configuration file:

```bash
nano /opt/stacks/homeserver/docker-compose.yml

```

Paste the complete stack configuration matching your specific paths (`/mnt/alpha`, `/mnt/beta`, `/mnt/xanadu`):

```yaml
services:
  # --------------------------------------------------
  # Dockge (Web GUI Manager)
  # --------------------------------------------------
  dockge:
    image: louislam/dockge:latest
    container_name: dockge
    restart: unless-stopped
    ports:
      - "5001:5001"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /opt/stacks:/opt/stacks
      - ./dockge_data:/app/data
    environment:
      - DOCKGE_STACKS_DIR=/opt/stacks

  # --------------------------------------------------
  # Jellyfin (Media Server)
  # --------------------------------------------------
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Auto
    volumes:
      - ./jellyfin/config:/config
      - ./jellyfin/cache:/cache
      - /mnt/alpha/Videos:/mnt/alpha/Videos
      - /mnt/beta/Videos:/mnt/beta/Videos
    devices:
      - /dev/dri:/dev/dri

  # --------------------------------------------------
  # Minecraft Server (Fabric)
  # --------------------------------------------------
  minecraft:
    image: itzg/minecraft-server:latest
    container_name: minecraft-server
    restart: unless-stopped
    ports:
      - "25565:25565"
    environment:
      EULA: "TRUE"
      TYPE: "FABRIC"
      VERSION: "LATEST"
      MEMORY: "6G"
    volumes:
      - ./minecraft:/data

  # --------------------------------------------------
  # Ollama + Web UI (AI Stack)
  # --------------------------------------------------
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: unless-stopped
    ports:
      - "11434:11434"
    volumes:
      - ./ollama_data:/root/.ollama
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]

  ollama-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: ollama-webui
    restart: unless-stopped
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    volumes:
      - ./open_webui:/app/backend/data

  # --------------------------------------------------
  # Kiwix (Offline Knowledge Server)
  # --------------------------------------------------
  kiwix:
    image: kiwix/kiwix-serve:latest
    container_name: kiwix
    restart: unless-stopped
    ports:
      - "8080:8080"
    volumes:
      - /mnt/xanadu:/data
    command: "*.zim"

  # --------------------------------------------------
  # Samba File Server
  # --------------------------------------------------
  samba:
    image: dperson/samba:latest
    container_name: samba-fileserver
    restart: unless-stopped
    network_mode: host
    environment:
      - TZ=Auto
    volumes:
      - /mnt/alpha:/mnt/alpha
      - /mnt/beta:/mnt/beta
    command: >
      -u "username;password"
      -s "Alpha;/mnt/alpha;yes;no;no;username"
      -s "Beta;/mnt/beta;yes;no;no;username"

```

*(Note: Change `username` and `password` under the Samba section to your desired credentials).*

---

## Phase 3: Launch & Verification

### 1. Start the Stack via CLI (First Time)

```bash
cd /opt/stacks/homeserver
docker compose up -d

```

### 2. Accessing Services (Local & via Tailscale)

From your laptop on the road (connected to Tailscale), point your browser or client to your server's Tailscale IP address:

* **Dockge GUI (Manage all apps):** `http://<tailscale-ip>:5001`
* **Jellyfin:** `http://<tailscale-ip>:8096`
* **Minecraft Fabric:** `<tailscale-ip>:25565`
* **Ollama Web UI:** `http://<tailscale-ip>:3000`
* **Kiwix:** `http://<tailscale-ip>:8080`
* **Samba File Shares:** `smb://<tailscale-ip>/Alpha` or `smb://<tailscale-ip>/Beta`
