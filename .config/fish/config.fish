#############
## Aliases ##
#############

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

###########################
## Environment Variables ##
###########################

## XDG Variables
set -xg XDG_CONFIG_HOME "$HOME/.config"
set -xg XDG_CACHE_HOME "$HOME/.cache"
set -xg XDG_DATA_HOME "$HOME/.local/share"
set -xg XDG_STATE_HOME "$HOME/.local/state"

## Variables according to the XDG specifications
set -xg HISTFILE "$XDG_STATE_HOME/bash/history"
#set -xg CARGO_HOME "$XDG_DATA_HOME/cargo"
set -xg CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -xg GOPATH "$XDG_DATA_HOME/go"
set -xg GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc" # The old path still auto-generated by programs
set -xg LESSHISTFILE "$XDG_STATE_HOME/less/history"
set -xg NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
#set -xg RUSTUP_HOME "$XDG_DATA_HOME/rustup" # This works but involves cargo, so I'll rather play it safe
set -xg IPYTHONDIR "$XDG_CONFIG_HOME/ipython"
set -xg JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -xg PARALLEL_HOME "$XDG_CONFIG_HOME/parallel"
set -xg PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"
set -xg W3M_DIR "$XDG_STATE_HOME/w3m"

## My Environment Variables
set -xg SCRIPTS "$XDG_DATA_HOME/my_scripts"

### Default Variables
set -x EDITOR "/usr/bin/nvim"
set -x TERMINAL "/usr/bin/foot"

################################
## Path Environment Variables ##
################################

set -U fish_user_paths $SCRIPTS  $fish_user_paths
set -U fish_user_paths $SCRIPTS/count_packages  $fish_user_paths

###############
## Functions ##
###############

## Fuction to be able to change directory when exiting. Call it with 'yy'
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

###########
## Other ##
###########

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Supresses Fish's intro message
set fish_greeting

# Custom Starship Prompt
starship init fish | source

# Syntax Highlighting for Man pages
batman --export-env | source
