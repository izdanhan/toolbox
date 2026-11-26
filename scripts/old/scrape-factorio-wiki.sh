#!/usr/bin/env bash

mkdir -p ~/Downloads/zim/factorio-wiki

docker run --rm \
  -v ~/Downloads/zim/factorio-wiki:/output \
  --shm-size=1gb \
  ghcr.io/openzim/zimit \
  zimit \
  --seeds https://wiki.factorio.com/ \
  --name factorio_wiki \
  --scopeExcludeRx ".*index\.php.*" \
  --scopeExcludeRx ".*Special:.*" \
  --diskUtilization 0 \
  --depth 3

sudo chown -R $(id -u):$(id -g) ~/Downloads/zim/factorio-wiki
