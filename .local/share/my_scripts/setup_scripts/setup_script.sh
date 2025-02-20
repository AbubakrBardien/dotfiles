#!/bin/bash

#  ___           _        _ _       _   _               ____       _                                 _   ____        _    __ _ _
# |_ _|_ __  ___| |_ __ _| | | __ _| |_(_) ___  _ __   / ___|  ___| |_ _   _ _ __     __ _ _ __   __| | |  _ \  ___ | |_ / _(_) | ___  ___
#  | || '_ \/ __| __/ _` | | |/ _` | __| |/ _ \| '_ \  \___ \ / _ \ __| | | | '_ \   / _` | '_ \ / _` | | | | |/ _ \| __| |_| | |/ _ \/ __|
#  | || | | \__ \ || (_| | | | (_| | |_| | (_) | | | |  ___) |  __/ |_| |_| | |_) | | (_| | | | | (_| | | |_| | (_) | |_|  _| | |  __/\__ \
# |___|_| |_|___/\__\__,_|_|_|\__,_|\__|_|\___/|_| |_| |____/ \___|\__|\__,_| .__/   \__,_|_| |_|\__,_| |____/ \___/ \__|_| |_|_|\___||___/
#                                                                           |_|

loadkeys us # Loads US keyboard layout (default)

echo "Enter name of disk to be partitioned: (default: /dev/sda)"
read -r diskName

cat <<EOF

Enter sizes in the following format: <number><size>
Size being 1 of the following:
K for Kilobytes
M for Megabytes
G for Gigabytes
T for Terabytes
P for Petabytes

EOF

#### Input ####
echo "Enter size of Boot partition:"
read -r bootSize
echo -e "\nEnter the size of RAM, in kibibytes:\n(Hint: If your RAM is 8GB, convert 8 gibibytes to kibybytes. Kilobytes is NOT the same as Kibybytes)"
read -r RAM_size
echo -e "\nEnter CPU type: (e.g. Intel or AMD) (default: Intel)"
read -r CPU_type
echo -e "\nEnter time-zone: (default: Africa/Johannesburg)"
read -r timeZone
echo -e "\nEnter root password:"
read -r -s rootPass
echo -e "\nEnter new user: (default: abubakr)"
read -r userName
if [ -z "$userName" ]; then
	userName="abubakr"
fi
echo -e "\nEnter password for $userName:"
read -r -s userPass

if [ -z "$diskName" ]; then
	diskName="/dev/sda"
fi

#### Creating the Partitions ####
fdisk "$diskName" <<EOF
g
n


+$bootSize
n



t
1
EFI System
w
EOF

if [ "$diskName" = "/dev/sda" ]; then
	bootPart="${diskName}1" # boot partition
	rootPart="${diskName}2" # root partition
elif [ "$diskName" = "/dev/nvme0n1" ]; then
	bootPart="${diskName}p1" # boot partition
	rootPart="${diskName}p2" # root partition
fi

#### Formatting the Partitions ####
mkfs.fat -F 32 "$bootPart"
mkfs.ext4 "$rootPart"

#### Mounting the File Systems ####
mount "$rootPart" /mnt
mount --mkdir "$bootPart" /mnt/boot

if [ -z "$CPU_type" ]; then
	microcode_pkg="intel-ucode"
else
	microcode_pkg="amd-ucode"
fi

#### Install Essential Packages ####
pacstrap -K /mnt base{,-devel} linux{,-firmware} grub efibootmgr $microcode_pkg vim git \
	networkmanager bluez{,-utils}

#### Create Swapfile ####
dd if=/dev/zero of=/swapfile bs=1M count="$RAM_size"
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

genfstab -U /mnt >>/mnt/etc/fstab

if [ -z "$timeZone" ]; then
	timeZone="Africa/Johannesburg"
fi

chosen_locale="en_US.UTF-8"

# Set Time-Zone and Locale
# The sed command uncomments the chosen Locale.
arch-chroot /mnt <<-EOF1
	ln -sf "/usr/share/zoneinfo/$timeZone" /etc/localtime
	hwclock --systohc
	timedatectl set-ntp true

	sed -i '/$chosen_locale UTF-8/s/^#\s*//g' /etc/locale.gen
	locale-gen
	echo "LANG=$chosen_locale" > /etc/locale.conf
	echo "arch-linux" > /etc/hostname

	exit
EOF1

# Set passwords, add user, and give user Sudo Permissions
# The sed command uncomments the "%wheel ALL=(ALL:ALL) ALL" line.
arch-chroot /mnt <<-EOF1
	passwd <<-EOF2
		$rootPass
		$rootPass
	EOF2

	useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash "$userName"
	passwd "$userName" <<-EOF2
		$userPass
		$userPass
	EOF2
	sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^#\s*//g' /etc/sudoers

	exit
EOF1

#### Configure Grub ####
arch-chroot /mnt <<-EOF1
	grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id="Arch Linux"

	cd /boot/grub/themes/
	curl -L -o arch-linux.tar https://raw.githubusercontent.com/AdisonCavani/distro-grub-themes/master/themes/arch-linux.tar
	mkdir arch-linux
	tar -xf arch-linux.tar -C arch-linux
	sed -i 's/^#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/arch-linux\/theme.txt"/' /etc/default/grub
	rm arch-linux.tar

	grub-mkconfig -o /boot/grub/grub.cfg
	exit
EOF1

# The sed commands uncomment the "[multilib]" line, and the line directly after that. (For 32 Bit Support)
# And other Pacman Configurations
arch-chroot /mnt <<-EOF1
	sed -i '/\[multilib\]/s/^#\s*//g' /etc/pacman.conf
	sed -i '/\[multilib\]/{n;s/^#\s*//;}' /etc/pacman.conf

	sed -i '/Color/s/^#\s*//g' /etc/pacman.conf
	sed -i '/Color/a ILoveCandy' /etc/pacman.conf
	sed -i '/VerbosePkgLists/s/^#\s*//g' /etc/pacman.conf
	sed -i '/ParallelDownloads/s/^#\s*//g' /etc/pacman.conf

	exit
EOF1

loginManager="sddm"
loginManagerTheme="sddm-theme-mountain-git"
firewall="ufw"
terminalEmulator="foot"

# Install SDDM and a theme for SDDM
# Configure SDDM to luanch Hyprland
# Set the sddm-mountain-theme
arch-chroot /mnt <<-EOF1
	pacman -S --noconfirm $loginManager $loginManagerTheme

	mkdir /etc/sddm.conf.d/
	cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/sddm.conf
	sed -i 's/^DisplayServer=.*/DisplayServer=x11-user/' /etc/sddm.conf.d/sddm.conf
	sed -i 's/^CompositorCommand=.*/CompositorCommand=Hyprland/' /etc/sddm.conf.d/sddm.conf

	cd /etc/sddm.conf.d/sddm.conf
	sed -i 's/^Current=.*/Current=mountain/' /etc/sddm.conf.d/sddm.conf
	sed -i 's/^FormPosition=.*/FormPosition="center"/' /usr/share/sddm/themes/mountain/theme.conf

	exit
EOF1

#### Creating XDG User Directories ####
arch-chroot /mnt <<-EOF1
	if [ ! -d "/home/$userName/.config" ]; then
		mkdir /home/$userName/.config
	fi

	cd /home/$userName/.config
	touch user-dirs.dirs
	mkdir /home/$userName/.unused_user_dirs

	for dir in Desktop Downloads Documents Music Pictures Videos; do
		echo "XDG_${dir}_DIR=\"\$HOME/${dir}\"" >> user-dirs.dirs
	done

	echo "XDG_TEMPLATES_DIR=\"\$HOME/.unused_user_dirs/Templates\"" >> user-dirs.dirs
	echo "XDG_PUBLICSHARE_DIR=\"\$HOME/.unused_user_dirs/Public\"" >> user-dirs.dirs

	cd /home/$userName
	mkdir Desktop Downloads Documents Music Pictures Videos
	cd .unused_user_dirs
	mkdir Templates Public

	exit
EOF1

#### Enable Backaground Services ####
arch-chroot /mnt <<-EOF1
	pacman -S --noconfirm $firewall 

	systemctl enable NetworkManager
	systemctl enable bluetooth
	systemctl enable paccache.timer 
	systemctl enable $loginManager
	systemctl enable $firewall

	exit
EOF1

# Import package lists
# Install ALL other packages
# Setup AUR Helper
# Install ALL flatpaks
# Install ALL plugins for Fish, and Yazi
# Use brillo to set minimum screen brightness to 5%
arch-chroot /mnt <<-EOF1
	curl -o pacman_packages.txt \
	-o aur_packages.txt \
	-o flatpak_packages.txt \
	-o fish_shell_plugins.txt \
	-o yazi_plugins.txt \
	https://raw.githubusercontent.com/AbubakrBardien/dotfiles/main/.local/share/my_scripts/setup_scripts/{{pacman,aur,flatpak}_packages,{fish_shell,yazi}_plugins}.txt

	pacman -S --noconfirm --needed $(cat pacman_packages.txt)

	mkdir /home/$userName/Documents/External_Repos
	cd /home/$userName/Documents/External_Repos
	git clone https://github.com/Morganamilo/paru.git
	cd paru
	makepkg -si
	paru -S --noconfirm $(cat aur_packages.txt)

	fisher install $(cat fish_shell_plugins.txt)
	flatpak install --assumeyes $(cat flatpak_packages.txt)
	ya pack -a $(cat yazi_plugins.txt)

	brillo -c -S 5

	exit
EOF1

# Make Fish the default Shell
# Enable Hibernate
#	Add 'resume' after 'udev' in the HOOKS array
arch-chroot /mnt <<-EOF1
	chsh -s /usr/bin/fish $userName

	sed -i 's/\(^HOOKS=\(.*\)udev\)/\1 resume/' /etc/mkinitcpio.conf
	mkinitcpio -P

	exit
EOF1

#### Import Dotfiles ####
arch-chroot /mnt <<-EOF1
	cd /home/$userName

	git clone --bare https://github.com/AbubakrBardien/dotfiles.git "/home/$userName/.dotfiles/"
	alias config="git --git-dir=/home/$userName/.dotfiles/ --work-tree=/home/$userName"

	[ -f .bashrc ] && rm .bashrc
	[ -f .gitignore ] && rm .gitignore

	config checkout
	config config --local status.showUntrackedFiles no

	exit
EOF1

# Store Git PAT (Personal Access Token)
#	You'll need to provide your PAT as a password the next to you push to GitHub. This is only required the 1st time.
#	Your existing PAT is found in your GitHub settings, under 'Developer Settings'.
arch-chroot /mnt <<-EOF1
	su $userName <<-EOF2
		$userPass
		git config --global credential.helper store
		exit
	EOF2
	exit
EOF1

# Setup pipx so the user can manage seperate python packages that are NOT system wide
arch-chroot /mnt <<-EOF1
	su $userName <<-EOF2
		$userPass
		fish
		pipx ensurepath
		pipx install argcomplete
		register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish
		pipx install virtualenv
		exit
		exit
	EOF2
	exit
EOF1

# Create Desktop Entries for Terminal Programs
arch-chroot /mnt <<-EOF1
	pacman -S --noconfirm $terminalEmulator

	cd /usr/share/applications/

	create_CLI_desktop_entry () {
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
		} | \
		sudo tee "${packageName}.desktop" >/dev/null
	}

	create_CLI_desktop_entry "cava" "Cava" "cava"
	create_CLI_desktop_entry "cbonsai" "CBonsai" "cbonsai -li"
	create_CLI_desktop_entry "cmatrix" "CMatrix" "cmatrix -b"
	create_CLI_desktop_entry "gotop" "GoTop" "gotop"
	create_CLI_desktop_entry "pipes" "Pipes" "pipes.sh"

	exit
EOF1

# Import Password Manager
arch-chroot /mnt <<-EOF1
	git clone https://github.com/AbubakrBardien/password-manager.git "/home/$userName/.local/share/my_scripts/password_manager"
	cd "/home/$userName/.local/share/my_scripts/password_manager"
	rm -rf .git README.md
	exit
EOF1

# Setup Custom Firefox Theme
#	Run Firefox to create the ".mozilla" directory
arch-chroot /mnt <<-EOF1
	firefox --no-remote &
	sleep 5
	cd /home/abubakr/.mozilla/firefox/
	browserProfileDir=\$(ls -d *.default-release | head -n 1)
	ln -s /home/$userName/.config/custom_firefox/user.js /home/$userName/.mozilla/firefox/$browserProfileDir/user.js
	ln -s /home/$userName/.config/custom_firefox/userChrome.css /home/$userName/.mozilla/firefox/$browserProfileDir/Chrome/userChrome.css
EOF1

umount /mnt/boot
umount /mnt
reboot
