#!/bin/bash

# Get the wallpapers from an external hard drive instead of downloading packages for it.
# Assuming the manual base installation process is already done, including alacritty, nano, lightdm, i3, git, etc. And that the AUR-Helper 'yay' is installed.

sudo pacman -Syu

sudo pacman -S -y fastfetch firefox fish cmatrix htop nitrogen tree zip unzip lxappearance fisher vlc lsd bat screenkey polybar pulseaudio{,-alsa,-bluetooth,-equalizer,-ctl} pavucontrol rofi{,-calc,-greenclip,-emoji} qalculate-gtk papirus-icon-theme breeze-gtk awk xclip noto-fonts-emoji

yay -S qimgv-light vscodium-bin
