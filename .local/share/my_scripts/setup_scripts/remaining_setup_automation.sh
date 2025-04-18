#!/bin/bash

#######################################
## Download and Configure Grub Theme ##
#######################################

# shellcheck disable=SC2164
cd /boot/grub/themes

latest_tag=$(curl -s "https://api.github.com/repos/AdisonCavani/distro-grub-themes/tags" | jq -r ".[0].name")
download_url="https://github.com/AdisonCavani/distro-grub-themes/archive/$latest_tag.tar.gz"
# shellcheck disable=SC2086
curl -L -o distro-grub-themes.tar.gz $download_url

mkdir distro-grub-themes
tar -xfz distro-grub-themes.tar.gz -C distro-grub-themes --strip-components=1

grub_theme_path="distro-grub-themes/themes/arch-linux.tar"
mkdir arch-linux
tar -xf $grub_theme_path -C arch-linux

sed -i 's/^#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/arch-linux\/theme.txt"/' /etc/default/grub
rm -r distro-grub-themes.tar.gz distro-grub-themes

grub-mkconfig -o /boot/grub/grub.cfg

# shellcheck disable=SC2162
read -p "Downloaded and Configured Grub Theme... " input
[[ $input == "q" ]] && exit 0

########################################
## Installed and Configure SDDM Theme ##
########################################

pacman -S sddm-theme-mountain-git
sed -i 's/^Current=.*/Current=mountain/' /etc/sddm.conf.d/sddm.conf
sed -i 's/^FormPosition=.*/FormPosition="center"/' /usr/share/sddm/themes/mountain/theme.conf

# shellcheck disable=SC2162
read -p "Installed and Configured SDDM Theme... " input
[[ $input == "q" ]] && exit 0

######################
## Configure Pacman ##
######################

# The sed commands uncomment the "[multilib]" line, and the line directly after that. (For 32 Bit Support)
sed -i '/\[multilib\]/s/^#\s*//g' /etc/pacman.conf
sed -i '/\[multilib\]/{n;s/^#\s*//;}' /etc/pacman.conf

# Other Pacman Configurations
sed -i '/Color/s/^#\s*//g' /etc/pacman.conf
sed -i '/Color/a ILoveCandy' /etc/pacman.conf
sed -i '/VerbosePkgLists/s/^#\s*//g' /etc/pacman.conf
sed -i '/ParallelDownloads/s/^#\s*//g' /etc/pacman.conf

# shellcheck disable=SC2162
read -p "Configured Pacman... " input
[[ $input == "q" ]] && exit 0

###################################
## Creating XDG User Directories ##
###################################

# shellcheck disable=SC2086
cd $HOME

mkdir Desktop Downloads Documents Music Pictures Videos

# shellcheck disable=SC2162
read -p "Created XDG User Directories... " input
[[ $input == "q" ]] && exit 0

################################
## Install All Other Packages ##
################################

curl -o pacman_packages.txt \
	-o aur_packages.txt \
	-o flatpak_packages.txt \
	-o yazi_plugins.txt \
	https://raw.githubusercontent.com/AbubakrBardien/dotfiles/main/.local/share/my_scripts/setup_scripts/{{pacman,aur,flatpak}_packages,yazi_plugins}.txt

# shellcheck disable=SC2046
pacman -S --noconfirm --needed $(cat pacman_packages.txt)

mkdir Documents/External_Repos
git clone "https://github.com/Morganamilo/paru.git" Documents/External_Repos
cd Documents/External_Repos/paru
makepkg -si

# shellcheck disable=SC2046
paru -S --noconfirm --needed $(cat aur_packages.txt)

# shellcheck disable=SC2046
flatpak install --assumeyes $(cat flatpak_packages.txt)

# shellcheck disable=SC2046
ya pack -a $(cat yazi_plugins.txt)

# shellcheck disable=SC2086
cd $HOME
rm {{pacman,aur,flatpak}_packages,yazi_plugins}.txt

# shellcheck disable=SC2162
read -p "Installed other packages according to your Package Lists... " input
[[ $input == "q" ]] && exit 0

############################
## Set Minimum Brightness ##
############################
brillo -c -S 5

# shellcheck disable=SC2162
read -p "Set Min Brightness... " input
[[ $input == "q" ]] && exit 0

##########################
## Change Default Shell ##
##########################

# shellcheck disable=SC2162
read -p "Enter Username: " userName

# shellcheck disable=SC2086
sudo chsh -s /usr/bin/zsh $userName

# shellcheck disable=SC2162
read -p "Changed Default Shell... " input
[[ $input == "q" ]] && exit 0

########################
## Enable Hibernation ##
########################

# Add 'resume' after 'udev' in the HOOKS array
sed -i 's/\(^HOOKS=\(.*\)udev\)/\1 resume/' /etc/mkinitcpio.conf

mkinitcpio -P # Reload Initramfs

# shellcheck disable=SC2162
read -p "Enabled Hibernation... " input
[[ $input == "q" ]] && exit 0

#####################
## Import Dotfiles ##
#####################

git clone --bare "https://github.com/AbubakrBardien/dotfiles.git" .dotfiles

# You'll need to provide your PAT (Personal Access Token) as a password the next to you push to GitHub.
# This is only required the 1st time.
# Your existing PAT is found in your GitHub settings, under 'Developer Settings'.
git config --global credential.helper store

# shellcheck disable=SC2139
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

config checkout --force .config/                   # Forcefully overwrite everything in the ".config/"
config checkout                                    # Copy the rest of the dotfiles over to your local machine
config config --local status.showUntrackedFiles no # Don't show untracked files in the output of "config status"

# shellcheck disable=SC2162
read -p "Imported Dotfiles... " input
[[ $input == "q" ]] && exit 0

##################################
## Setup Firefox userChrome.css ##
##################################

# Run Firefox to create the ".mozilla" directory
firefox &
sleep 3

# shellcheck disable=SC2012
browserProfileDir=$(ls -d .mozilla/firefox/*.default-release | head -n 1)
ln -s .config/custom_firefox/user.js "$browserProfileDir/user.js"
ln -s .config/custom_firefox/userChrome.css "$browserProfileDir/chrome/userChrome.css"

################
## Setup Pipx ##
################

# pipx allows the user to manage seperate python packages that are NOT system wide
pipx ensurepath
pipx install argcomplete virtualenv

# shellcheck disable=SC2162
read -p "Setup Pipx... " input
[[ $input == "q" ]] && exit 0

##################################################
## Create Desktop Entries for Terminal Programs ##
##################################################

terminalEmulator="foot"

cd /usr/share/applications

create_CLI_desktop_entry() {
	packageName=$1
	desktopName=$2
	command=$3

	{
		echo "[Desktop Entry]"
		echo "Name=$desktopName"
		echo "Icon=$terminalEmulator"
		echo "Type=Application"
		echo "Exec=$command"
		echo "Terminal=true"
	} |
		sudo tee "${packageName}.desktop" >/dev/null
}

create_CLI_desktop_entry "cava" "Cava" "cava"
create_CLI_desktop_entry "cbonsai" "CBonsai" "cbonsai -li"
create_CLI_desktop_entry "cmatrix" "CMatrix" "cmatrix -b"
create_CLI_desktop_entry "gotop" "GoTop" "gotop"
create_CLI_desktop_entry "pipes" "Pipes" "pipes.sh"

# shellcheck disable=SC2162
read -p "Created Desktop Entries for Terminal Programs... " input
[[ $input == "q" ]] && exit 0

################################################
## Import My other Repos that I use Regularly ##
################################################

# Download my Python Password Manager Script
download_url="https://raw.githubusercontent.com/AbubakrBardien/dotfiles/main/.local/share/my_scripts/setup_scripts/password_manager/password_manager.py"
# shellcheck disable=SC2086
cd $HOME/.local/share/my_scripts
mkdir password_manager
curl -L -o password_manager/password_manager.py $download_url

# shellcheck disable=SC2086
cd $HOME

# Clone my Neovim config
git clone "https://github.com/AbubakrBardien/nvim.git" .config/nvim

# Cloned the forked 'browser-startpage' repo
git clone "https://github.com/AbubakrBardien/browser-startpage.git" Documents/External_Repos/browser-startpage

# shellcheck disable=SC2162
read -p "Imported Password Manager, Neovim config, and Browser Startpage... " input
[[ $input == "q" ]] && exit 0

######################################
## Enable Custom Systemd Unit Files ##
######################################

systemctl --user enable battery_monitor.timer system_update_reminder.timer

# shellcheck disable=SC2162
read -p "Enabled Custom Systemd Unit Files" input
[[ $input == "q" ]] && exit 0

if pacman -Q foot 1>/dev/null 2>/dev/null; then
	echo "The 'foot' terminal was installed, so you can safely remove the default 'kitty' terminal and replace it with 'foot'"
else
	echo "The 'foot' terminal was not installed"
fi

echo "Ready to Reboot"

# reboot
