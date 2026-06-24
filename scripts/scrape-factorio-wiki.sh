#!/usr/bin/env bash

mkdir -p ~/Downloads/zim/factorio-wiki

docker run --rm \
  -v ~/Downloads/zim/factorio-wiki:/output \
  -e CRAWLER_KWARGS='{"exclude": [".*index\\.php.*", ".*Special:.*"]}' \
  -it ghcr.io/openzim/zimit \
  zimit \
  --seeds https://wiki.factorio.com/ \
  --name factorio_wiki \
  --adminEmail your-email@domain.com \
  --depth 3

sudo chown -R $(id -u):$(id -g) ~/Downloads/zim/factorio-wiki
