#!/usr/bin/env bash

# --- TACTICAL COMMAND-LINE WIKI SCRAPER ---
# Usage: ./scrape_wiki.sh <WIKI_URL> <OUTPUT_DIRECTORY>
# Example: ./scrape_wiki.sh https://minecraft.wiki/ ~/Downloads/minecraft-wiki

set -e

# Validate that both parameters were provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "[-] Error: Missing arguments."
    echo "Usage: $0 <WIKI_URL> <OUTPUT_DIRECTORY>"
    echo "Example: $0 https://minecraft.wiki/ ~/Downloads/minecraft-wiki"
    exit 1
fi

WIKI_URL="$1"
# Expand relative paths (like ~/) into absolute paths cleanly
OUTPUT_DIR=$(eval echo "$2")
ADMIN_EMAIL="your-email@domain.com"

# Smart Endpoint Detection:
# Standard wikis use /w/api.php. Subdomains or independent wikis often use root level /api.php.
# This curl test handshakes with the root endpoint to check for a valid JSON response.
echo "[+] Probing Wiki API endpoint configuration..."
if curl -s -G --connect-timeout 5 "${WIKI_URL}api.php" --data-urlencode "action=query" --data-urlencode "format=json" | grep -q "query"; then
    API_PATH="/api.php"
else
    API_PATH="/w/api.php"
fi

echo "[+] Detected API Endpoint Path: ${API_PATH}"

# Ensure output workspace exists
mkdir -p "$OUTPUT_DIR"

# Execute Payload
echo "[+] Initializing container crawl against: ${WIKI_URL}"
docker run \
  -v "${OUTPUT_DIR}":/output:Z \
  -ti ghcr.io/openzim/mwoffliner \
  mwoffliner \
  --mwUrl="${WIKI_URL}" \
  --mwActionApiPath="${API_PATH}" \
  --adminEmail="${ADMIN_EMAIL}" \
  --outputDirectory=/output \
  --speed=1.0

echo "[+] Execution sequence completed cleanly. Target file sits in: ${OUTPUT_DIR}"
