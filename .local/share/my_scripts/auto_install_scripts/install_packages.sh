#!/bin/bash

pacman -S --noconfirm xdg-user-dirs
xdg-user-dirs-update

mkdir ~/Documents/External_Repos/
cd ~/Documents/External_Repos/
git clone https://github.com/Morganamilo/paru.git
cd paru
makepkg -si

# Handle this later
# echo -e "\nEnter NVIDIA GPU Family Name: (for more details: https://nouveau.freedesktop.org/CodeNames.html)"
# read GPU_Family
#
# if [ $GPU_Family == "Tesla" ]; then
# 	nvidia_driver=nvidia-340xx-dkms
# fi

# SDDM is in "pacman_packages.txt"

pacman -S --noconfirm --needed $(cat pacman_packages.txt)
paru -S --noconfirm --needed $(cat aur_packages.txt)

sudo systemctl enable sddm
sudo systemctl start sddm
