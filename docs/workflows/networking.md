# Linux Networking Guide

## Check network interfaces
```bash
ip addr
```

## Test connectivity
```bash
ping -c 4 google.com
```

## View routes
```bash
ip route
```

## DNS lookup
```bash
dig example.com
```

## Show open ports
```bash
ss -tuln
```

---

## Best practices
- Use `ip` instead of deprecated `ifconfig`/`netstat`.
- Secure services with firewalls (`ufw`, `iptables`).
- Document static IPs in `/etc/netplan/` (Ubuntu).

