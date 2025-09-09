# 06 - Network Sharing & Media Distribution Guide

## Table of Contents
1.  [Network Architecture Overview](#network-architecture-overview)
2.  [Samba File Sharing Setup](#samba-file-sharing-setup)
3.  [Media Streaming Options](#media-streaming-options)
4.  [Cross-Platform Access](#cross-platform-access)
5.  [Access Control & Security](#access-control--security)
6.  [Performance Optimization](#performance-optimization)
7.  [Troubleshooting](#troubleshooting)

## Network Architecture Overview

### Recommended Network Layout
```
[Desktop] --(Gigabit Ethernet)--> [Router] <--(WiFi 6/Ethernet)-- [Laptop]
    |                                  |
    |                                  +--(WiFi 6)--> [Samsung TV]
    |                                  |
    +--(HDMI 2.1)--> [Samsung TV]      +--(Ethernet)--> [ThinkPad Dock]
```

### IP Address Planning
Assign static IPs to critical devices:
- Desktop: 192.168.1.10
- Laptop: 192.168.1.20
- TV: 192.168.1.30

## Samba File Sharing Setup

### Linux Samba Server Configuration
```bash
# Install Samba on Fedora
sudo dnf install samba samba-client

# Create backup of original config
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Edit Samba configuration
sudo nano /etc/samba/smb.conf
```

### Sample Samba Configuration
Add to `/etc/samba/smb.conf`:
```ini
[global]
   workgroup = WORKGROUP
   server string = Media Server
   security = user
   map to guest = Bad User
   name resolve order = bcast host

[MediaArchive]
   path = /mnt/archive
   browsable = yes
   writable = yes
   read only = no
   guest ok = yes
   force user = yourusername
   create mask = 0664
   directory mask = 0775

[Projects]
   path = /home/yourusername/MediaProjects
   browsable = yes
   writable = yes
   valid users = yourusername
   read only = no
   create mask = 0664
   directory mask = 0775
```

### User and Service Management
```bash
# Set Samba password for your user
sudo smbpasswd -a yourusername

# Enable and start Samba services
sudo systemctl enable smb nmb
sudo systemctl start smb nmb

# Configure firewall
sudo firewall-cmd --permanent --add-service=samba
sudo firewall-cmd --reload
```

## Media Streaming Options

### Kodi as Media Center
```bash
# Install Kodi on Fedora
sudo dnf install kodi

# Configure Kodi sources.xml
mkdir -p ~/.kodi/userdata/
cat > ~/.kodi/userdata/sources.xml << EOF
<sources>
  <video>
    <default pathversion="1"></default>
    <source>
      <name>Movies</name>
      <path pathversion="1">/mnt/archive/MediaLibrary/Movies/</path>
    </source>
    <source>
      <name>TV Shows</name>
      <path pathversion="1">/mnt/archive/MediaLibrary/TV/</path>
    </source>
  </video>
</sources>
EOF
```

### MiniDLNA for TV Compatibility
```bash
# Install MiniDLNA
sudo dnf install minidlna

# Configure MiniDLNA
sudo nano /etc/minidlna.conf
```

```ini
# MiniDLNA Configuration
media_dir=V,/mnt/archive/MediaLibrary/Movies
media_dir=V,/mnt/archive/MediaLibrary/TV
media_dir=P,/mnt/archive/MediaLibrary/Photos
friendly_name=Media Server
inotify=yes
enable_subtitles=yes
```

```bash
# Start MiniDLNA service
sudo systemctl enable minidlna
sudo systemctl start minidlna
```

## Cross-Platform Access

### Windows Access to Linux Shares
1. **Map Network Drives:**
   - Open File Explorer
   - Right-click "This PC" → "Map network drive"
   - Enter: `\\192.168.1.10\MediaArchive`
   - Check "Connect using different credentials"

2. **Command Line Mapping:**
```powershell
# Map network drive with credentials
net use Z: \\192.168.1.10\MediaArchive /persistent:yes /user:yourusername
```

### Linux Access to Windows Shares
```bash
# Install CIFS utilities
sudo dnf install cifs-utils

# Create mount point
sudo mkdir /mnt/windows-share

# Manual mount
sudo mount -t cifs //192.168.1.10/MediaArchive /mnt/windows-share -o username=yourusername

# Auto-mount via fstab
echo "//192.168.1.10/MediaArchive /mnt/windows-share cifs credentials=/etc/samba/win-credentials,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab

# Create credentials file
sudo nano /etc/samba/win-credentials
```
```ini
username=yourusername
password=yourpassword
```

### TV Access Configuration
On Samsung Q70A TV:
1. Go to Settings → General → Network → Network Status
2. Select "IP Settings" to set static IP if needed
3. Open Media Browser → Select Network Share
4. Enter server IP: 192.168.1.10
5. Access shared folders

## Access Control & Security

### User Permissions Management
```bash
# Set correct permissions on shared directories
sudo chmod -R 775 /mnt/archive/
sudo chown -R yourusername:yourusername /mnt/archive/

# Set ACL for better control
sudo setfacl -R -m g:media:rwx /mnt/archive/
sudo setfacl -R -m d:g:media:rwx /mnt/archive/
```

### SSH Access for Secure Transfers
```bash
# Enable SSH on Fedora
sudo dnf install openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd

# Generate SSH keys for passwordless access
ssh-keygen -t ed25519
ssh-copy-id yourusername@192.168.1.10

# Remote file transfers
rsync -avz ~/Documents/ yourusername@192.168.1.10:/mnt/archive/Backups/
```

## Performance Optimization

### Network Tuning
```bash
# Increase network buffers
sudo sysctl -w net.core.rmem_max=26214400
sudo sysctl -w net.core.wmem_max=26214400
sudo sysctl -w net.core.rmem_default=26214400
sudo sysctl -w net.core.wmem_default=26214400

# Make changes permanent
echo 'net.core.rmem_max=26214400' | sudo tee -a /etc/sysctl.conf
echo 'net.core.wmem_max=26214400' | sudo tee -a /etc/sysctl.conf
```

### Samba Performance Optimization
```ini
# Add to smb.conf [global] section
socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072
min receivefile size = 16384
write cache size = 262144
getwd cache = yes
```

### Wireless Optimization
For laptop and TV wireless connections:
```bash
# Use 5GHz band for better throughput
# Set WiFi regulatory domain for maximum power
sudo iw reg set US
sudo iwconfig wlan0 txpower 30

# Monitor wireless performance
sudo dnf install iperf3
# On server: iperf3 -s
# On client: iperf3 -c 192.168.1.10
```

## Troubleshooting

### Common Issues and Solutions

**Connection Timeouts:**
```bash
# Check firewall settings
sudo firewall-cmd --list-all

# Verify Samba running
sudo systemctl status smb nmb

# Test connectivity
smbclient -L 192.168.1.10 -U yourusername
```

**Permission Denied:**
```bash
# Check SELinux context
sudo ls -Z /mnt/archive/

# Set proper context if needed
sudo chcon -t samba_share_t /mnt/archive/

# Verify UNIX permissions
ls -la /mnt/archive/
```

**Slow Transfer Speeds:**
```bash
# Test network speed
iperf3 -c 192.168.1.10

# Check disk I/O
sudo hdparm -Tt /dev/sdX

# Monitor real-time transfer
sudo iftop -i eth0
```

### Diagnostic Commands
```bash
# Network diagnostics
ping 192.168.1.10
traceroute 192.168.1.10
mtr 192.168.1.10

# Samba diagnostics
testparm
smbstatus

# Connection testing
nmblookup -A 192.168.1.10
```

### Log Files for Troubleshooting
```bash
# Samba logs
tail -f /var/log/samba/log.smbd

# System logs
journalctl -u smb -f

# Connection logs
sudo tcpdump -i eth0 port 445
```

This network sharing setup provides seamless access to your media files across all devices while maintaining good performance and security. The combination of Samba for file sharing and DLNA for media streaming ensures compatibility with all your devices including the Samsung TV.

Would you like me to create any additional documentation or helper scripts for this setup?
