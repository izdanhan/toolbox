# Linux Tips

Some handy Linux commands and tricks.

## File & Directory
```bash
ls -lh        # list with sizes
du -sh *      # folder sizes
find . -name "*.log"   # search for log files
```

## Processes & System
```bash
htop          # interactive process viewer
ps aux | grep name   # search for process
df -h         # disk usage
free -h       # memory usage
```

## Networking
```bash
ip a          # show IP addresses
ping 8.8.8.8  # test connectivity
ss -tuln      # show open ports
```

## Package Management
```bash
sudo apt update && sudo apt upgrade
sudo dnf update
```

---
Add your own useful one-liners here as you discover them!
