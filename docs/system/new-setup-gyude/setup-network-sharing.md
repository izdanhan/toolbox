
# Helper Script: Network Sharing Setup

I'll create a comprehensive helper script to automate the network sharing setup process on your Fedora system. This script will handle Samba configuration, media streaming setup, and firewall configuration.

## Script: `setup-network-sharing.sh`

```bash
#!/bin/bash
# Network Sharing Setup Script for Creative Workstation
# Designed for Fedora Linux with Samba and MiniDLNA

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration variables
USERNAME=$(whoami)
SHARE_PATH="/mnt/archive"
MOVIES_PATH="$SHARE_PATH/MediaLibrary/Movies"
TV_PATH="$SHARE_PATH/MediaLibrary/TV"
PHOTOS_PATH="$SHARE_PATH/MediaLibrary/Photos"
SAMBA_CONFIG="/etc/samba/smb.conf"
MINIDLNA_CONFIG="/etc/minidlna.conf"
STATIC_IP="192.168.1.10"

# Function to print status messages
print_status() {
    echo -e "${GREEN}[+]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "Please run this script as root (use sudo)"
    exit 1
fi

# Check if Fedora
if ! grep -q "Fedora" /etc/os-release; then
    print_error "This script is designed for Fedora Linux"
    exit 1
fi

print_status "Starting network sharing setup"

# Install required packages
print_status "Installing required packages"
dnf install -y samba samba-client minidlna cifs-utils

# Create media library directory structure
print_status "Creating media library directory structure"
mkdir -p "$MOVIES_PATH" "$TV_PATH" "$PHOTOS_PATH"
chmod -R 775 "$SHARE_PATH"
chown -R "$USERNAME:$USERNAME" "$SHARE_PATH"

# Backup original configurations
print_status "Backing up original configuration files"
cp "$SAMBA_CONFIG" "${SAMBA_CONFIG}.bak"
cp "$MINIDLNA_CONFIG" "${MINIDLNA_CONFIG}.bak"

# Configure Samba
print_status "Configuring Samba"
cat > "$SAMBA_CONFIG" << EOF
[global]
   workgroup = WORKGROUP
   server string = Media Server
   security = user
   map to guest = Bad User
   name resolve order = bcast host
   socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072
   min receivefile size = 16384
   write cache size = 262144
   getwd cache = yes

[MediaArchive]
   path = $SHARE_PATH
   browsable = yes
   writable = yes
   read only = no
   guest ok = yes
   force user = $USERNAME
   create mask = 0664
   directory mask = 0775

[MediaLibrary]
   path = $SHARE_PATH/MediaLibrary
   browsable = yes
   writable = yes
   read only = no
   guest ok = yes
   force user = $USERNAME
   create mask = 0664
   directory mask = 0775
EOF

# Set Samba password
print_status "Setting up Samba user account"
if ! pdbedit -L | grep -q "$USERNAME"; then
    smbpasswd -a "$USERNAME"
else
    print_warning "User $USERNAME already exists in Samba database"
fi

# Configure MiniDLNA
print_status "Configuring MiniDLNA"
cat > "$MINIDLNA_CONFIG" << EOF
media_dir=V,$MOVIES_PATH
media_dir=V,$TV_PATH
media_dir=P,$PHOTOS_PATH
friendly_name=Media Server
inotify=yes
enable_subtitles=yes
port=8200
serial=12345678
model_number=1
db_dir=/var/cache/minidlna
log_dir=/var/log
EOF

# Configure firewall
print_status "Configuring firewall"
firewall-cmd --permanent --add-service=samba
firewall-cmd --permanent --add-port=8200/tcp  # MiniDLNA port
firewall-cmd --reload

# Enable and start services
print_status "Enabling and starting services"
systemctl enable smb nmb minidlna
systemctl start smb nmb minidlna
systemctl restart minidlna  # Ensure it picks up new config

# Set static IP (optional)
read -p "Do you want to set a static IP? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Setting static IP to $STATIC_IP"
    
    # Get network interface name
    INTERFACE=$(ip -o -4 route show to default | awk '{print $5}')
    
    # Create network manager connection profile
    nmcli con add type ethernet ifname "$INTERFACE" con-name "Static-IP" ip4 "$STATIC_IP/24" gw4 "192.168.1.1"
    nmcli con mod "Static-IP" ipv4.dns "192.168.1.1,8.8.8.8"
    nmcli con up "Static-IP"
fi

# Create utility scripts
print_status "Creating utility scripts in /usr/local/bin"

# Script to restart all sharing services
cat > /usr/local/bin/restart-sharing << 'EOF'
#!/bin/bash
systemctl restart smb nmb minidlna
systemctl status smb nmb minidlna
EOF

# Script to check sharing status
cat > /usr/local/bin/check-sharing << 'EOF'
#!/bin/bash
echo "=== Samba Status ==="
systemctl status smb nmb
echo ""
echo "=== MiniDLNA Status ==="
systemctl status minidlna
echo ""
echo "=== Firewall Rules ==="
firewall-cmd --list-all
echo ""
echo "=== Network Interfaces ==="
ip addr show
EOF

# Script to add new media directories
cat > /usr/local/bin/add-media-dir << 'EOF'
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: add-media-dir <path> <type>"
    echo "Types: V for video, P for photos, A for audio"
    exit 1
fi

MEDIA_PATH=$1
MEDIA_TYPE=${2:-V}

# Add to MiniDLNA config
echo "media_dir=$MEDIA_TYPE,$MEDIA_PATH" >> /etc/minidlna.conf

# Restart MiniDLNA to recognize new directory
systemctl restart minidlna

echo "Added $MEDIA_PATH to media library (type: $MEDIA_TYPE)"
EOF

# Make utility scripts executable
chmod +x /usr/local/bin/restart-sharing
chmod +x /usr/local/bin/check-sharing
chmod +x /usr/local/bin/add-media-dir

print_status "Network sharing setup complete!"
echo ""
echo "Summary of changes:"
echo "  - Samba configured with shares: MediaArchive, MediaLibrary"
echo "  - MiniDLNA configured for media streaming"
echo "  - Firewall rules added for Samba and MiniDLNA"
echo "  - Utility scripts created in /usr/local/bin/"
echo ""
echo "Next steps:"
echo "  1. Add your media files to $SHARE_PATH/MediaLibrary/"
echo "  2. On other devices, connect to: \\\\$STATIC_IP\\MediaArchive"
echo "  3. On your TV, look for 'Media Server' in media sources"
echo ""
echo "Use 'check-sharing' to verify everything is working"
echo "Use 'restart-sharing' to restart all sharing services"
```

## Usage Instructions

1. Save the script as `setup-network-sharing.sh`
2. Make it executable: `chmod +x setup-network-sharing.sh`
3. Run with sudo: `sudo ./setup-network-sharing.sh`

## Additional Helper Script: `mount-windows-shares.sh`

For accessing Windows shares from your Fedora system:

```bash
#!/bin/bash
# Script to mount Windows shares on Fedora

set -e

# Configuration
WINDOWS_IP="192.168.1.10"  # Change to your Windows machine's IP
SHARE_NAME="MediaArchive"
MOUNT_POINT="/mnt/windows-share"
CREDENTIALS_FILE="$HOME/.windows-credentials"

# Check if mount point exists
if [ ! -d "$MOUNT_POINT" ]; then
    sudo mkdir -p "$MOUNT_POINT"
    sudo chown $USER:$USER "$MOUNT_POINT"
fi

# Create credentials file if it doesn't exist
if [ ! -f "$CREDENTIALS_FILE" ]; then
    echo "Creating credentials file at $CREDENTIALS_FILE"
    read -p "Enter Windows username: " username
    read -s -p "Enter Windows password: " password
    echo
    echo "username=$username" > "$CREDENTIALS_FILE"
    echo "password=$password" >> "$CREDENTIALS_FILE"
    chmod 600 "$CREDENTIALS_FILE"
fi

# Mount the share
sudo mount -t cifs "//$WINDOWS_IP/$SHARE_NAME" "$MOUNT_POINT" -o credentials=$CREDENTIALS_FILE,uid=$(id -u),gid=$(id -g)

echo "Windows share mounted at $MOUNT_POINT"
```

## Usage Instructions for Windows Shares Script

1. Save as `mount-windows-shares.sh`
2. Make executable: `chmod +x mount-windows-shares.sh`
3. Run: `./mount-windows-shares.sh`

These scripts will automate the process of setting up network sharing on your Fedora system and make it easier to manage your media library across all devices.
