#!/usr/bin/env bash

# Create directory cleanly
mkdir -p ~/Downloads/zim/factorio-wiki

# Run Zimit with dedicated shared memory and modern exclude flags
docker run --rm \
  -v ~/Downloads/zim/factorio-wiki:/output \
  --shm-size=1gb \
  ghcr.io/openzim/zimit \
  zimit \
  --seeds https://wiki.factorio.com/ \
  --name factorio_wiki \
  --scopeExcludeRx ".*index\.php.*" \
  --scopeExcludeRx ".*Special:.*" \
  --depth 3

# Fix permissions back to host user
echo "sudo chown -R $(id -u):$(id -g) ~/Downloads/zim/factorio-wiki"

