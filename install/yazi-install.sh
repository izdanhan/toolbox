#!/usr/bin/env bash
set -euo pipefail

echo "==> Updating system and installing Yazi + required/recommended ecosystem dependencies..."

# 1. Enable community COPR repository for Yazi on Fedora, or fallback to cargo if preferred.
# The COPR repo maintains clean native DNF packages and pulls recommended weak deps automatically.
if ! dnf copr list | grep -q "lihaohong/yazi"; then
    echo "==> Enabling lihaohong/yazi COPR repository..."
    sudo dnf install -y dnf-plugins-core
    sudo dnf copr enable -y lihaohong/yazi
fi

# 2. Install Yazi and all optimal preview/search dependencies
echo "==> Installing Yazi and core CLI tools (ffmpeg, 7zip, jq, poppler, fd, ripgrep, fzf, zoxide, imagemagick)..."
sudo dnf install -y \
    yazi \
    ffmpeg \
    p7zip \
    jq \
    poppler-utils \
    fd-find \
    ripgrep \
    fzf \
    zoxide \
    ImageMagick \
    file

echo "==> Installation complete!"
yazi --version
