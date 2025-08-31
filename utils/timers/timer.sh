#!/usr/bin/env bash
# Simple timer utility

if [ -z "$1" ]; then
  echo "Usage: $0 <seconds>"
  exit 1
fi

SECONDS="$1"
echo "⏳ Timer started for $SECONDS seconds..."
sleep "$SECONDS"
echo "⏰ Time's up!"
