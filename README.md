# Abubakr's Personal Dotfiles

## Screenshots

![Screenshot1](.local/share/screenshots/screenshot1.png)

![Screenshot2](.local/share/screenshots/screenshot2.png)

![Screenshot3](.local/share/screenshots/screenshot3.png)

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

| Graphical | Terminal-Based | Theming |
| --------- | -------------- | ------- |
| Bar: [Waybar](https://github.com/Alexays/Waybar) | Editor: [Neovim](https://neovim.io/) with the [NvChad](https://neovim.io/) config. | Wallpaper Setter: [Swww](https://github.com/LGFae/swww) |
| Luancher/Menu: [Wofi](https://github.com/SimplyCEO/wofi) | File Manager: [Yazi](https://github.com/sxyazi/yazi) | GTK Theme: [Arc Dark](https://github.com/jnsh/arc-theme) |
| Notification Tool: [Dunst](https://github.com/dunst-project/dunst) | System Info Tool: [Fastfetch](https://github.com/fastfetch-cli/fastfetch) | Icon Theme: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) |
| Browser: [Firefox](https://www.mozilla.org/en-US/firefox/new/) | Task Manager for Linux: [HTop](https://github.com/htop-dev/htop)  | Login Theme: [Mountain](https://github.com/c0rydoras/sddm-mountain-theme) for [SDDM](https://github.com/sddm/sddm) |
| Video Player: [VLC](https://www.videolan.org/vlc/) | System Monitoring Dashboard: [GoTop](https://github.com/xxxserxxx/gotop) | Bootloader Theme: [Unnamed](https://www.pling.com/p/1482847/) for [Grub](https://wiki.archlinux.org/title/GRUB) |
| Image Viewer: [gThumb](https://gitlab.gnome.org/GNOME/gthumb) | Disk Space Display: [Duf](https://github.com/muesli/duf) | Lock Screen: [Hyprlock](https://github.com/hyprwm/hyprlock) (not configured yet) |
| Music Player: [Spotify](https://open.spotify.com/)| Disk Usage Analyzer: [Dust](https://github.com/bootandy/dust) ||
| Note-Taking App: [Obsidian](https://obsidian.md/) | | |
| Office Suite: [OnlyOffice](https://www.onlyoffice.com/) | | |
| Video Recording: [OBS](https://obsproject.com/) | | |
| Cloud Service: [pCloud](https://www.pcloud.com/)| | |

### Fun Terminal Programs

[Cava](https://github.com/karlstav/cava) \
[CBonsai](https://gitlab.com/jallbrit/cbonsai) \
[CMatrix](https://github.com/abishekvashok/cmatrix) \
[Cowsay](https://github.com/cowsay-org/cowsay) \
[Figlet](https://github.com/cmatsuoka/figlet) \
[Pipes](https://github.com/pipeseroni/pipes.sh) \
[SL](https://github.com/mtoyoda/sl)
