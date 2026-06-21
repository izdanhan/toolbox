#!/usr/bin/env bash

docker run -v ~/Downloads/rimworld-wiki:/output:Z -ti ghcr.io/openzim/mwoffliner \
  mwoffliner \
  --mwUrl=https://rimworldwiki.com/ \
  --mwActionApiPath=/api.php \
  --adminEmail=your-email@domain.com \
  --outputDirectory=/output \
  --speed=1.0
  
