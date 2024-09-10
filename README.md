# Abubakr's Personal Dotfiles

## Screenshots

![Screenshot1](screenshot1.png)

![Screenshot2](screenshot2.png)

![Screenshot3](screenshot3.png)

## Installation

After running `pacstrap -K /mnt base{,-devel} linux{,-firmware} grub efibootmgr networkmanager neovim git`.

Run `pacstrap -K amd-ucode` if you have an AMD CPU, or `pacstrap -K intel-ucode` if you have an Intel CPU.

Then, clone the 'auto-install-packages' repo, as shown below:

```Shell
mkdir /home/abubakr/.scripts/
cd /home/abubakr/.scripts/

git clone https://github.com/AbubakrBardien/auto-install-packages.git
# Or
git clone git@github.com:AbubakrBardien/auto-install-packages.git
```
