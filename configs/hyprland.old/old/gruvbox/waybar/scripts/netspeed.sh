#!/bin/bash

# Get the default interface
IFACE=$(ip route | awk '/default/ {print $5; exit}')

# Read previous values
RX1=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)

sleep 1

RX2=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)

# Calculate MB/s (decimal)
RX_MB=$(echo "scale=1; ($RX2 - $RX1) / 1000000" | bc)
TX_MB=$(echo "scale=1; ($TX2 - $TX1) / 1000000" | bc)

# Clean output
printf "↑%.1f ↓%.1f MB/s" "$TX_MB" "$RX_MB"
