#!/bin/bash

#  ___           _        _ _       _   _                                   _   ____        _    __ _ _           
# |_ _|_ __  ___| |_ __ _| | | __ _| |_(_) ___  _ __  ___    __ _ _ __   __| | |  _ \  ___ | |_ / _(_) | ___  ___ 
#  | || '_ \/ __| __/ _` | | |/ _` | __| |/ _ \| '_ \/ __|  / _` | '_ \ / _` | | | | |/ _ \| __| |_| | |/ _ \/ __|
#  | || | | \__ \ || (_| | | | (_| | |_| | (_) | | | \__ \ | (_| | | | | (_| | | |_| | (_) | |_|  _| | |  __/\__ \
# |___|_| |_|___/\__\__,_|_|_|\__,_|\__|_|\___/|_| |_|___/  \__,_|_| |_|\__,_| |____/ \___/ \__|_| |_|_|\___||___/

sudo pacman -S --noconfirm xdg-user-dirs
xdg-user-dirs-update

# Pacman Configurations
sudo sed -i '/Color/s/^#\s*//g' /etc/pacman.conf				# Uncomments 'Color'
sudo sed -i '/Color/a ILoveCandy' /etc/pacman.conf				# Inserts 'ILoveCandy' after 'Color'
sudo sed -i '/VerbosePkgLists/s/^#\s*//g' /etc/pacman.conf		# Uncomments 'VerbosePkgLists'
sudo sed -i '/ParallelDownloads/s/^#\s*//g' /etc/pacman.conf	# Uncomments 'ParallelDownloads'

firewall="ufw"
sddm_theme="sddm-theme-mountain-git"

# shellcheck disable=SC2046
sudo pacman -S --noconfirm --needed $firewall $sddm_theme $(cat pacman_packages.txt)

# Setup SSH
eval "$(ssh-agent -s)"
ssh-add "$1"

# Setting up AUR Helper
mkdir "$HOME/Documents/External_Repos/"
# shellcheck disable=SC2164
cd "$HOME/Documents/External_Repos/"
git clone https://github.com/Morganamilo/paru.git
# shellcheck disable=SC2164
cd paru
makepkg -si

# shellcheck disable=SC2046
sudo paru -S --noconfirm --needed $(cat aur_packages.txt)

# Make Fish the default Shell
chsh -s fish

# Enable Numlock
sudo sed -i 's/\(^HOOKS=\(.*\)consolefont\)/\1 numlock/' /etc/mkinitcpio.conf # Adds 'numlock' after 'consolefont' in the HOOKS array
mkinitcpio -P

sudo systemctl enable paccache.timer # automatically cleans the pacman cache weekly
sudo systemctl enable $firewall

###### Import the dotfiles ######

git clone --bare https://github.com/AbubakrBardien/dotfiles.git "$HOME/.dotfiles/"
# shellcheck disable=SC2139
alias config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Removing files to avoid getting an error from git
if [ -f .bashrc ]; then
    rm .bashrc
fi
if [ -f .gitignore ]; then
    rm .gitignore
fi

config checkout
config config --local status.showUntrackedFiles no


###### Modify Desktop Entries ######

# shellcheck disable=SC2164
cd /usr/share/applications/

while IFS= read -r line; do
	apps_to_hide+=("$line")
done < apps_to_hide.txt

for app in "${apps_to_hide[@]}"; do
	# Appends to the file, with sudo permissions
	echo -e "\nHidden=true" | sudo tee -a "${app}.desktop"
done

create_CLI_desktop_entry () {
	packageName=$1
	desktopName=$2	
	command=$3

	{
		echo "[Desktop Entry]"
		echo "Name=$desktopName"
		echo "Icon=foot"
		echo "Type=Application"
		echo "Exec=$command"
		echo "Terminal=true"
	} | \
	sudo tee -a "${packageName}.desktop"
}

create_CLI_desktop_entry "cava" "Cava" "cava"
create_CLI_desktop_entry "cbonsai" "CBonsai" "cbonsai -li"
create_CLI_desktop_entry "cmatrix" "CMatrix" "cmatrix -b"
create_CLI_desktop_entry "gotop" "GoTop" "gotop"
create_CLI_desktop_entry "pipes" "Pipes" "pipes.sh"

###### Grub Theme ######

# shellcheck disable=SC2164
cd /boot/grub/themes/

curl -L -o arch-linux.tar https://raw.githubusercontent.com/AdisonCavani/distro-grub-themes/master/themes/arch-linux.tar
mkdir arch-linux
tar -xf arch-linux.tar -C arch-linux

sudo sed -i 's/^#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/arch-linux\/theme.txt"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

rm arch-linux.tar

###### SDDM Theme ######

# shellcheck disable=SC2164
cd /etc/sddm.conf.d/sddm.conf
sudo sed -i 's/^Current=.*/Current=mountain/' /etc/sddm.conf.d/sddm.conf

###### Finishing Up ######

sudo pacman -Rns --noconfirm kitty

# Comments out "%wheel ALL=(ALL:ALL) NOPASSWD: ALL", and Uncomments "%wheel ALL=(ALL:ALL) ALL"
sudo sed -i '/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^/# /;/%wheel ALL=(ALL:ALL) ALL/s/^#\s*//g' /etc/pacman.conf	

reboot
