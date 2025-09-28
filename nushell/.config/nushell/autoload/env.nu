##########################
## XDG Base Directories ##
##########################

$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_CACHE_HOME =  ($env.HOME | path join ".cache")
$env.XDG_DATA_HOME =   ($env.HOME | path join ".local/share")
$env.XDG_STATE_HOME =  ($env.HOME | path join ".local/state")

#############################################
## Moving Files/Folders based on XDG Specs ##
#############################################

## Python Files
$env.PYTHONSTARTUP =  ($env.XDG_CONFIG_HOME | path join "python/pythonrc")
$env.IPYTHONDIR =     ($env.XDG_CONFIG_HOME | path join "ipython")
$env.PYTHON_HISTORY = ($env.XDG_DATA_HOME   | path join "python/history")

## Rust Files
$env.CARGO_HOME =  ($env.XDG_DATA_HOME | path join "cargo")
$env.RUSTUP_HOME = ($env.XDG_DATA_HOME | path join "rustup")

## .NET Core Files
$env.DOTNET_CLI_HOME = ($env.XDG_DATA_HOME  | path join "dotnet")
$env.NUGET_PACKAGES =  ($env.XDG_CACHE_HOME | path join "NuGetPackages")

## Other Files
$env.HISTFILE =              ($env.XDG_DATA_HOME   | path join "zsh/history") # Remove this later
$env.CUDA_CACHE_PATH =       ($env.XDG_CACHE_HOME  | path join "nv")
$env.GOPATH =                ($env.XDG_DATA_HOME   | path join "go")
$env.JUPYTER_CONFIG_DIR =    ($env.XDG_CONFIG_HOME | path join "jupyter")
$env.NPM_CONFIG_USERCONFIG = ($env.XDG_CONFIG_HOME | path join "npm/npmrc")
$env.PARALLEL_HOME =         ($env.XDG_CONFIG_HOME | path join "parallel")
$env.PASSWORD_STORE_DIR =    ($env.XDG_DATA_HOME   | path join "pass")
$env.W3M_DIR =               ($env.XDG_STATE_HOME  | path join "w3m")
$env.GNUPGHOME =             ($env.XDG_DATA_HOME   | path join "gnupg")
$env.STARSHIP_CONFIG =       ($env.XDG_CONFIG_HOME | path join "starship/starship.toml")

####################################
## My Other Environment Variables ##
####################################

$env.MASON_PKGS = ($env.XDG_DATA_HOME | path join "nvim/mason/bin")
$env.TRASHDIR = ($env.XDG_DATA_HOME   | path join "Trash")

##########################
## CLI Default Programs ##
##########################

$env.EDITOR =     "nvim"
$env.AUR_HELPER = "paru"

################################
## Path Environment Variables ##
################################

use std/util "path add"

# Ordered from Lowest to Highest priority
path add ($env.XDG_DATA_HOME | path join "npm/bin")
path add ($env.CARGO_HOME    | path join "bin")
path add ($env.SCRIPTS       | path join "hide_apps")
path add ($env.SCRIPTS       | path join "count_packages")
path add ($env.SCRIPTS)
path add ($env.HOME          | path join ".local/bin")
