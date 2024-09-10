# Abubakr's Personal Dotfiles

## Screenshots

![Screenshot1](screenshot1.png)

![Screenshot2](screenshot2.png)

![Screenshot3](screenshot3.png)

## Installation

During your Arch Installation process, after running `pacstrap -K /mnt base{,-devel} linux{,-firmware} grub efibootmgr networkmanager neovim git`.

Run `pacstrap -K amd-ucode` if you have an AMD CPU, or `pacstrap -K intel-ucode` if you have an Intel CPU.

Then, clone the 'auto-install-packages' repo, as shown below:

```Shell
mkdir /home/abubakr/.scripts/
cd /home/abubakr/.scripts/

git clone https://github.com/AbubakrBardien/auto-install-packages.git
# Or
git clone git@github.com:AbubakrBardien/auto-install-packages.git
```

Then run `auto-install-packages/install_packages.sh` to auto-install the packages.

At the end of the Arch Installation process, after logging in, run the `auto-install-packages/bare_repo.sh` script to download the dotfiles.

## Configuration

- WM/Compositor: [Hyprland](https://hyprland.org/)
- Shell: [Fish](https://fishshell.com/) with the [Tide](https://github.com/IlanCosman/tide) prompt theme.
- GTK Theme: [Arc Dark](https://github.com/jnsh/arc-theme)
- Icon Theme: Papirus

