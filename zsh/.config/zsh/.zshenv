##########################
## XDG Base Directories ##
##########################

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

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
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

###########
## Zinit ##
###########

ZINIT_HOME=$XDG_DATA_HOME/zinit/zinit.git # Set the directory to store Zinit and Plugins

####################################
## My Other Environment Variables ##
####################################

export SCRIPTS="$XDG_DATA_HOME/my_scripts"
export MASON_PKGS="$XDG_DATA_HOME/nvim/mason/bin"

## Default Programs
export EDITOR="/usr/bin/nvim"
export AUR_HELPER="/usr/bin/paru"
export BROWSER="/usr/bin/brave"

################################
## Path Environment Variables ##
################################

# Make the 'path' array unique first. This handles any existing duplicates in the system's PATH.
typeset -U path

path=(
    "$CARGO_HOME/bin"
    "$HOME/.local/bin"
    "$SCRIPTS"
    "$SCRIPTS/count_packages"
    "$SCRIPTS/hide_apps"
    "$XDG_DATA_HOME/npm/bin"
    $path # the system paths need to be at the end, for the system to prioritize user-specified paths
)

###########
## Other ##
###########

export TRASHDIR="$XDG_DATA_HOME/Trash"
export QT_STYLE_OVERRIDE="kvantum"
