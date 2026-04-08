#!/bin/bash

git config --global user.name "Daniel Hanikka"
git config --global user.email daniel.hanikka@proton.me

ssh-keygen -t ed25519 -C "daniel.hanikka@proton.me"
eval "$(ssh-agent -s)"                                                                                                             130 ↵
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
