#!/bin/bash

pacman -S --noconfirm xdg-user-dirs
xdg-user-dirs-update

mkdir ~/Documents/External_Repos/
cd ~/Documents/External_Repos/
git clone https://github.com/Morganamilo/paru.git
cd paru
makepkg -si

loginManager="sddm"

pacman -S --noconfirm --needed $loginManager $(cat pacman_packages.txt)
paru -S --noconfirm --needed $(cat aur_packages.txt)

sudo systemctl enable $loginManager
sudo systemctl start $loginManager
