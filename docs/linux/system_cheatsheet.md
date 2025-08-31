# System Cheatsheet

Handy system administration commands.

## Users & Permissions
```bash
id            # show current user/groups
whoami        # show current username
chmod +x file # make script executable
chown user:group file
```

## Services
```bash
systemctl status service
systemctl start service
systemctl enable service
journalctl -u service --since today
```

## Logs
```bash
dmesg | less
journalctl -xe
tail -f /var/log/syslog
```

## Hardware Info
```bash
lscpu
lsblk
lspci
lsusb
```

---
Keep extending this file with your daily admin commands.
