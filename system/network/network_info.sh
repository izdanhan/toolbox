#!/usr/bin/env bash
# network_info.sh - Show useful system networking information
# Usage: ./network_info.sh

echo "=== Network Information ==="
hostname -I | awk '{print "IP Addresses: "$0}'
ip route | grep default | awk '{print "Default Gateway: "$3}'
cat /etc/resolv.conf | grep nameserver | awk '{print "DNS: "$2}'
echo "Active connections:"
ss -tulpn
