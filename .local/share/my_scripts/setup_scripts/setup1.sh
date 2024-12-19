#!/bin/bash

#  ____                   ____            _
# | __ )  __ _ ___  ___  / ___| _   _ ___| |_ ___ _ __ ___
# |  _ \ / _` / __|/ _ \ \___ \| | | / __| __/ _ \ '_ ` _ \
# | |_) | (_| \__ \  __/  ___) | |_| \__ \ ||  __/ | | | | |
# |____/ \__,_|___/\___| |____/ \__, |___/\__\___|_| |_| |_|
#                               |___/

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

# Input
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

# Creating the Partitions
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

bootPart="${diskName}1" # boot partition
rootPart="${diskName}2" # root partition

# Formatting the Partitions
mkfs.fat -F 32 "$bootPart"
mkfs.ext4 "$rootPart"

# Mounting the File Systems
mount "$rootPart" /mnt
mount --mkdir "$bootPart" /mnt/boot

if [ -z "$CPU_type" ]; then
	microcode_pkg="intel-ucode"
else
	microcode_pkg="amd-ucode"
fi

# Install Essential Packages
pacstrap -K /mnt base{,-devel} linux{,-firmware} grub efibootmgr $microcode_pkg vim git \
	networkmanager bluez{,-utils}

# Create Swapfile
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

	sed -i '/$chosen_locale UTF-8/s/^#\s*//g' /etc/locale.gen
	locale-gen
	echo "LANG=$chosen_locale" > /etc/locale.conf
	echo "arch-linux" > /etc/hostname

	exit
EOF1

# Set passwords, add user, and give user Sudo Permissions
# The sed command uncomments the "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" line.
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
	sed -i '/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^#\s*//g' /etc/sudoers

	exit
EOF1

# Configure Grub, Enable 32 Bit Support
# The sed commands uncomment the "[multilib]" line, and the line directly after that.
arch-chroot /mnt <<-EOF1
	grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg

	sed -i '/\[multilib\]/s/^#\s*//g' /etc/pacman.conf
	sed -i '/\[multilib\]/{n;s/^#\s*//;}' /etc/pacman.conf

	exit
EOF1

loginManager="sddm"
terminalEmulator="foot"

# Install SDDM, Hyprland, nvidia drivers, and terminal emulators. (kitty terminal is for temporary use)
# Configure SDDM to luanch Hyprland
# The sed commands do the following:
# - Matches a line starting with "DisplayServer=", and sets it equal to "x11-user"
# - Matches a line starting with "CompositorCommand=", and sets it equal to "Hyprland"
arch-chroot /mnt <<-EOF1
	pacman -S --noconfirm $loginManager nvidia{,-utils} lib32-nvidia-utils hyprland kitty $terminalEmulator

	mkdir /etc/sddm.conf.d/
	cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/sddm.conf
	sed -i 's/^DisplayServer=.*/DisplayServer=x11-user/' /etc/sddm.conf.d/sddm.conf
	sed -i 's/^CompositorCommand=.*/CompositorCommand=Hyprland/' /etc/sddm.conf.d/sddm.conf

	exit
EOF1

arch-chroot /mnt <<-EOF1
	systemctl enable NetworkManager
	systemctl enable bluetooth
	systemctl enable $loginManager
	exit
EOF1

umount /mnt/boot
umount /mnt
reboot
