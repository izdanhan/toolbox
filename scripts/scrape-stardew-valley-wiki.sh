#!/usr/bin/env bash

# Luodaan kansio etukäteen Ubuntun puolella
mkdir -p ~/Downloads/zim/stardew-wiki

# Ajetaan zimit
docker run --rm \
  -v ~/Downloads/zim/stardew-wiki:/output \
  -it ghcr.io/openzim/zimit \
  zimit \
  --seeds https://stardewvalleywiki.com \
  --name stardew_valley_wiki \
  --adminEmail your-email@domain.com \
  --depth 3

# Korjataan .zim-tiedoston oikeudet omalle käyttäjällesi
sudo chown -R $(id -u):$(id -g) ~/Downloads/zim/stardew-wiki
