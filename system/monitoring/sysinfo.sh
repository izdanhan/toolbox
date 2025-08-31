#!/usr/bin/env bash
# Display basic system info

echo "🖥️ System Information"
echo "----------------------"
echo "Hostname: $(hostname)"
if [ -f /etc/os-release ]; then
  . /etc/os-release
  echo "OS: $PRETTY_NAME"
else
  echo "OS: $(uname -s)"
fi
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "CPU: $(lscpu | awk -F: '/Model name/{gsub(/^ +/,"",$2); print $2; exit}')"
echo "Memory (used/total): $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
echo

if command -v nvidia-smi &>/dev/null; then
  echo "GPU (NVIDIA):"
  nvidia-smi --query-gpu=name,memory.total --format=csv,noheader
elif command -v lspci &>/dev/null; then
  echo "GPU:"
  lspci | grep -Ei 'vga|3d|display' | sed 's/^/  /'
fi
