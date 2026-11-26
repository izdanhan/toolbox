#!/usr/bin/env bash

docker run --rm -v ~/Downloads/bg3-wiki:/output:Z -it ghcr.io/openzim/zimit \
  zimit \
  --url https://bg3.wiki/ \
  --output /output/bg3_wiki_complete.zim \
  --adminEmail your-email@domain.com \
  --depth 3
  
