##########################
## XDG Base Directories ##
##########################

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

## Place all other Zsh related config files in this directory. And source the files that have been renamed
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

#############################################
## Moving Files/Folders based on XDG Specs ##
#############################################

## Python Files
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"

## Rust Files
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

## .NET Core Files
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

## Other Files
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GOPATH="$XDG_DATA_HOME/go"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export W3M_DIR="$XDG_STATE_HOME/w3m"

##############################
## My Environment Variables ##
##############################

export SCRIPTS="$XDG_DATA_HOME/my_scripts"

## Default Programs
export EDITOR="/usr/bin/nvim"
export AUR_HELPER="/usr/bin/paru"
export BROWSER="/usr/bin/brave"

################################
## Path Environment Variables ##
################################

typeset -U addPath
addPath=($PATH $CARGO_HOME/bin $XDG_DATA_HOME/npm/bin $SCRIPTS $SCRIPTS/hide_apps $SCRIPTS/count_packages $HOME/.local/bin)
export PATH=$(echo $addPath | tr ' ' ':')

###########
## Other ##
###########

export TRASHDIR="$XDG_DATA_HOME/Trash"
