#!/bin/bash

uncomment_line () {
	line=$1
	file=$2
	awk "/#$line/ { print \"$line\" } { print }" $file > /my_tmp && mv /my_tmp $file
}

loadkeys us # Loads US keyboard layout (default)

echo "Enter name of disk to be partitioned: (e.g. /dev/sda)"
read diskName

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
read bootSize
echo -e "\nEnter size of Swap partition:"
read swapSize
echo -e "\nEnter CPU type: (e.g. Intel or AMD)"
read CPU_type
echo -e "\nEnter time-zone: (e.g. Africa/Johannesburg)"
read timeZone
echo -e "\nEnter root password:"
read rootPass
echo -e "\nEnter new user:"
read userName
echo -e "\nEnter password for $userName:"
read userPass


# Creating the Partitions
fdisk diskName <<EOF
g
n
1

+$bootSize
n
2

+$swapSize
n
3


t
1
1
t
2
19
w
EOF

bootPart="${diskName}1" # boot partition
swapPart="${diskName}2" # swap partition
rootPart="${diskName}3" # root partition

# Formatting the Partitions
mkfs.fat -F 32 $bootPart
mkswap $swapPart
mkfs.ext4 $rootPart

# Mounting the File Systems
mount $rootPart /mnt
mount --mkdir $bootPart /mnt/boot
swapon $swapPart

if [ $CPU_type == "Intel" ]; then
	microcode_pkg="intel-ucode"
else
	microcode_pkg="amd-ucode"
fi

# Install Essential Packages
pacstrap -K /mnt base{,-devel} linux{,-firmware} grub efibootmgr $microcode_pkg vim git networkmanager bluez{,-utils}

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

# Set Time-Zone
ln -sf "/usr/share/zoneinfo/$timeZone" /etc/localtime
hwclock --systohc

# Set Locale
uncomment_line "en_US.UTF-8 UTF-8" /etc/locale.gen
locale-gen
awk "BEGIN { print \"LANG=en_US.UTF-8\" }" > /etc/locale.conf
awk "BEGIN { print \"arch-linux\" }" > /etc/hostname

# Set Root Password
passwd <<EOF
$rootPass
$rootPass
EOF

# Create a New User
useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash $userName
passwd $userName <<EOF
$userPass
$userPass
EOF

uncomment_line "%wheel ALL=(ALL:ALL) ALL" /etc/sudoers

grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/sys/firmware/efi --bootloader-id=GRUB --boot-target=efi $bootPart

systemctl enable NetworkManager
systemctl enable bluetooth

exit
umount -a
reboot
