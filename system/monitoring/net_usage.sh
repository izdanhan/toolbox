#!/usr/bin/env bash
# Simple network usage monitor
echo "Network Usage (TX/RX):"
ifstat 1 1 2>/dev/null || cat /proc/net/dev
