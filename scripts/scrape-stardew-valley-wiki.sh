#!/usr/bin/env bash

docker run --rm -v ~/Downloads/zim/stardew-wiki:/output:Z -it ghcr.io/openzim/zimit \
  zimit \
  --seeds https://stardewvalleywiki.com \
  --name stardew_valley_wiki \
  --adminEmail your-email@domain.com \
  --depth 3
  