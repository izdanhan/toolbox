#!/usr/bin/env bash

mkdir -p ~/Downloads/zim/factorio-wiki

docker run --rm \
  -v ~/Downloads/zim/factorio-wiki:/output \
  --shm-size=2gb \
  ghcr.io/openzim/zimit \
  zimit \
  --seeds https://wiki.factorio.com/ \
  --name factorio_wiki \
  --scopeExcludeRx ".*index\.php.*" \
  --scopeExcludeRx ".*Special:.*" \
  --depth 3 \
  --diskUtilization 0 \
  --pageLimit 5000 \
  --workers 2 \
  --waitUntil domcontentloaded \
  --keep

sudo chown -R $(id -u):$(id -g) ~/Downloads/zim/factorio-wiki
