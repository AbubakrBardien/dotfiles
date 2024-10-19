if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting	# Supresses Fish's intro message

alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" 
alias ls "lsd"
alias cat "bat"
alias tree "lsd --tree"
alias pipes "pipes.sh"
alias ping "gping"
alias cp "cp -v"
alias mv "mv -v"
alias rm "rm -v"
alias disk_usage "dust -r" # Disk Usage Viewer
alias dir_size "du -sh"
alias disks "duf --hide special --hide-mp /boot" # Display Disk Space
alias benchmark "hyperfine" # Very useful benchmarking tool
alias unset "set --erase" # unset environment variable
alias delete_orphaned "sudo pacman -Rns \$(pacman -Qdtq)"

alias wget "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\""

# Set Environment Variables

## XDG Variables
set -xg XDG_CONFIG_HOME "$HOME/.config"
set -xg XDG_CACHE_HOME "$HOME/.cache"
set -xg XDG_DATA_HOME "$HOME/.local/share"
set -xg XDG_STATE_HOME "$HOME/.local/state"

## Default Variables
set -x EDITOR "/usr/bin/nvim"
set -x TERMINAL "/usr/bin/foot"

## Other
set -xg HISTFILE "$XDG_STATE_HOME/bash/history"
#set -xg CARGO_HOME "$XDG_DATA_HOME/cargo"
set -xg CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -xg GOPATH "$XDG_DATA_HOME/go"
set -xg GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc" # The old path still auto-generated by programs
set -xg LESSHISTFILE "$XDG_STATE_HOME/less/history"
set -xg NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
#set -xg RUSTUP_HOME "$XDG_DATA_HOME/rustup" # This works but involves cargo, so I'll rather play it safe
set -xg SCRIPTS "$XDG_DATA_HOME/my_scripts"


# Custom Starship Prompt
starship init fish | source


# Functions

## Fuction to be able to change directory when exiting. Call it with 'yy'
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
