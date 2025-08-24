#!/bin/bash

$AUR_HELPER -Qenq >pacman_packages.txt
$AUR_HELPER -Qemq >aur_packages.txt
flatpak list --app --columns=application >flatpak_packages.txt
ya pkg list | grep -E '^\s+\w+' | awk '{$1=$1; print $1}' >yazi_plugins.txt
