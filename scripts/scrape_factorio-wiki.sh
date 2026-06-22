#!/usr/bin/env bash

docker run --rm -v ~/Downloads/zim/factorio-wiki:/output:Z -it ghcr.io/openzim/zimit \
  zimit \
  --seeds https://wiki.factorio.com/ \
  --name factorio_wiki \
  --adminEmail your-email@domain.com \
  --depth 3
