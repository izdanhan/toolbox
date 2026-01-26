#!/bin/bash

# Update the package list and upgrade existing packages
sudo pacman -Syu

# Paru is your standard pacman wrapping AUR helper with lots of features and minimal interaction.
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
