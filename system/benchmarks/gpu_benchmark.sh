#!/usr/bin/env bash
# Quick GPU benchmark using nvidia-smi (NVIDIA) or glxgears as a fallback.

set -e

if command -v nvidia-smi &>/dev/null; then
  echo "📊 NVIDIA GPU Info"
  nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader
  echo
  echo "Running 10s utilization sample (1s interval)..."
  nvidia-smi dmon -s pucvmt -d 1 -c 10 || true
elif command -v rocminfo &>/dev/null; then
  echo "📊 AMD ROCm detected (rocminfo)"
  rocminfo | grep -m1 'Name' || true
  echo "Consider using rocm-smi / rocprof for deeper benchmarks."
elif command -v glxgears &>/dev/null; then
  echo "📊 Running glxgears (not a real benchmark, just FPS preview)"
  glxgears -info
else
  echo "❌ No GPU tool found. Install 'nvidia-smi' (NVIDIA) or 'mesa-utils' (glxgears)."
fi
