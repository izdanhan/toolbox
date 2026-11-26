#!/usr/bin/env bash

mkdir -p ~/Downloads/zim/stardew-wiki

docker run --rm \
  -v ~/Downloads/zim/stardew-wiki:/output \
  -e CRAWLER_KWARGS='{"exclude": [".*index\\.php.*", ".*Special:.*"]}' \
  -it ghcr.io/openzim/zimit \
  zimit \
  --seeds https://stardewvalleywiki.com/ \
  --name stardew_valley_wiki \
  --adminEmail your-email@domain.com \
  --depth 3

sudo chown -R $(id -u):$(id -g) ~/Downloads/zim/stardew-wiki
