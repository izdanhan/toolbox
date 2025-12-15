#!/usr/bin/env bash
# Ollama helper commands

set -e

usage() {
  echo "🦙 Ollama Helper"
  echo "Usage: $0 [list|pull MODEL|run MODEL|stop]"
  exit 1
}

case "${1:-}" in
  list) ollama list ;;
  pull) [ -n "$2" ] || usage; ollama pull "$2" ;;
  run)  [ -n "$2" ] || usage; ollama run "$2" ;;
  stop) ollama stop ;;
  *) usage ;;
esac
