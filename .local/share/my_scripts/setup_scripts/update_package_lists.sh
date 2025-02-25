#!/bin/bash

paru -Qenq >pacman_packages.txt
paru -Qemq >aur_packages.txt
flatpak list --app --columns=application >flatpak_packages.txt

# This file only updates the package lists that are likely to change
