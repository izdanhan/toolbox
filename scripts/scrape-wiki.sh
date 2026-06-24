#!/usr/bin/env bash

# --- TACTICAL FAULT-TOLERANT WIKI SCRAPER ---
# Usage: ./scrape_wiki.sh <WIKI_URL> <OUTPUT_DIRECTORY>

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "[-] Error: Missing arguments."
    echo "Usage: $0 <WIKI_URL> <OUTPUT_DIRECTORY>"
    exit 1
fi

# Strip any trailing slashes cleanly from the input URL
WIKI_URL="${1%/}"
OUTPUT_DIR=$(eval echo "$2")
ADMIN_EMAIL="your-email@domain.com"

mkdir -p "$OUTPUT_DIR"

# Specific fallback handling for ArchWiki to avoid known firewall bans
if [[ "$WIKI_URL" == *"archlinux.org"* ]]; then
    echo "[!] Target identified as ArchWiki. Local crawling restricted by infrastructure."
    echo "[+] Fetching the latest official pre-compiled OpenZIM payload..."
    wget -P "$OUTPUT_DIR" https://download.kiwix.org/zim/archlinux/archlinux_en_all_2026-06.zim
    exit 0
fi

# Standard probing protocol for other wikis
echo "[+] Probing Wiki API endpoint configuration..."
if curl -s -G --connect-timeout 5 "${WIKI_URL}/api.php" --data-urlencode "action=query" --data-urlencode "format=json" | grep -q "query"; then
    API_PATH="/api.php"
else
    API_PATH="/w/api.php"
fi

echo "[+] Detected API Endpoint Path: ${API_PATH}"
echo "[+] Initializing container crawl against: ${WIKI_URL}"

# Wrapped container execution to catch runtime syntax drops
if ! docker run \
  -v "${OUTPUT_DIR}":/output:Z \
  -ti ghcr.io/openzim/mwoffliner \
  mwoffliner \
  --mwUrl="${WIKI_URL}/" \
  --mwActionApiPath="${API_PATH}" \
  --adminEmail="${ADMIN_EMAIL}" \
  --outputDirectory=/output \
  --speed=1.0; then
    
    echo "[-] Local scraper execution encountered an error."
    echo "[*] If this target is a major public wiki, download the pre-compiled bundle from: https://download.kiwix.org/zim/"
    exit 1
fi

echo "[+] Execution sequence completed cleanly. Target asset sits in: ${OUTPUT_DIR}"
