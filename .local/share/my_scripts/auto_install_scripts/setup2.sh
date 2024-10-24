#!/bin/bash

pacman -S --noconfirm xdg-user-dirs
xdg-user-dirs-update

loginManager="sddm"
firewall="ufw"

# shellcheck disable=SC2046
pacman -S --noconfirm --needed $loginManager $firewall $(cat pacman_packages.txt)

mkdir ~/Documents/External_Repos/
# shellcheck disable=SC2164
cd ~/Documents/External_Repos/
git clone https://github.com/Morganamilo/paru.git
# shellcheck disable=SC2164
cd paru
makepkg -si

# shellcheck disable=SC2046
paru -S --noconfirm --needed $(cat aur_packages.txt)

# Make Fish the default Shell
chsh -s /usr/bin/fish

# Enable 32 Bit Support
sed -i '/\[multilib\]/s/^#\s*//g' /etc/pacman.conf # Uncomments '[multilib]'
sed -i '/\[multilib\]/{n;s/^#\s*//;}' /etc/pacman.conf # Uncomments the line after '[multilib]'
pacman -Syu --noconfirm

# Make Pacman look prettier
sed -i '/Color/s/^#\s*//g' /etc/pacman.conf # Uncomments 'Color'
sed -i '/Color/a ILoveCandy' /etc/pacman.conf # Inserts 'ILoveCandy' after 'Color'
sed -i '/VerbosePkgLists/s/^#\s*//g' /etc/pacman.conf
sed -i '/ParallelDownloads/s/^#\s*//g' /etc/pacman.conf


# Enable Numlock
sed -i 's/\(^HOOKS=\(.*\)consolefont\)/\1 numlock/' /etc/mkinitcpio.conf # Adds 'numlock' after 'consolefont' in the HOOKS array
mkinitcpio -P

systemctl enable paccache.timer # automatically cleans the pacman cache weekly
systemctl enable $loginManager
systemctl enable $firewall

systemctl start $loginManager
