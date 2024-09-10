#!/usr/bin/bash

# 'pacman -Qe' to see only programs explicitly installed, meaning no dependencies listed 

pacman_pkgs=$(pacman -Qen | wc -l)
aur_pkgs=$(pacman -Qem | wc -l)
orphened_pkgs=$(pacman -Qdt | wc -l)

echo "$pacman_pkgs (Pacman), $aur_pkgs (AUR), $orphened_pkgs (orphaned)"
