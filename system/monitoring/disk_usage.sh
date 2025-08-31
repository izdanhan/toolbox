#!/usr/bin/env bash
# Simple disk usage overview
echo "Disk Usage Report"
df -h --total | grep -E "Filesystem|total"
