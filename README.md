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

## Programs I Use

WM/Compositor: [Hyprland](https://hyprland.org/)\
Terminal: [Foot](https://codeberg.org/dnkl/foot)\
Shell: [Fish](https://fishshell.com/) with the [Tide](https://github.com/IlanCosman/tide) prompt theme.

- GTK Theme: [Arc Dark](https://github.com/jnsh/arc-theme)
- Icon Theme: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

- Browser: Firefox
- Luancher/Menu: [Wofi](https://github.com/SimplyCEO/wofi)
- Bar: [Waybar](https://github.com/Alexays/Waybar)

- SDDM Theme: [Mountain](https://github.com/c0rydoras/sddm-mountain-theme)
- Grub Theme: [Arch Linux](https://www.pling.com/p/1482847/)

- File Manager: [Yazi](https://github.com/sxyazi/yazi)
- Editor: [Neovim](https://neovim.io/) with the [NvChad](https://neovim.io/) config. 

- Video Player: VLC
- Image Viewer: [gThumb](https://gitlab.gnome.org/GNOME/gthumb)

- Notification Tool: [Dunst](https://github.com/dunst-project/dunst)

- Brightness Control: [Brillo](https://gitlab.com/cameronnemo/brillo)

- System Info Tool: [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- Lock Screen: [Hyprlock](https://github.com/hyprwm/hyprlock) (not configured yet)

- Screenshot Tool: [Hyprshot](https://github.com/Gustash/Hyprshot)
- Note-Taking App: [Obsidian](https://obsidian.md/)

- Disk Usage Analyzer: [NCDU](https://dev.yorhel.nl/ncdu)

- Office Suite: [OnlyOffice](https://www.onlyoffice.com/)

- Wallpaper Setter: [Swww](https://github.com/LGFae/swww)

### Graphical Programs
### Terminal-Based
