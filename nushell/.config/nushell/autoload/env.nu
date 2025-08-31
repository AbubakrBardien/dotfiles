##########################
## XDG Base Directories ##
##########################

$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CACHE_HOME =  $"($env.HOME)/.cache"
$env.XDG_DATA_HOME =   $"($env.HOME)/.local/share"
$env.XDG_STATE_HOME =  $"($env.HOME)/.local/state"

#############################################
## Moving Files/Folders based on XDG Specs ##
#############################################

## Python Files
$env.PYTHONSTARTUP =  $"($env.XDG_CONFIG_HOME)/python/pythonrc"
$env.IPYTHONDIR =     $"($env.XDG_CONFIG_HOME)/ipython"
$env.PYTHON_HISTORY = $"($env.XDG_DATA_HOME)/python/history"

## Rust Files
$env.CARGO_HOME =  $"($env.XDG_DATA_HOME)/cargo"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"

## .NET Core Files
$env.DOTNET_CLI_HOME = $"($env.XDG_DATA_HOME)/dotnet"
$env.NUGET_PACKAGES =  $"($env.XDG_CACHE_HOME)/NuGetPackages"

## Other Files
$env.HISTFILE =              $"($env.XDG_DATA_HOME)/zsh/history" # Remove this later
$env.CUDA_CACHE_PATH =       $"($env.XDG_CACHE_HOME)/nv"
$env.GOPATH =                $"($env.XDG_DATA_HOME)/go"
$env.JUPYTER_CONFIG_DIR =    $"($env.XDG_CONFIG_HOME)/jupyter"
$env.NPM_CONFIG_USERCONFIG = $"($env.XDG_CONFIG_HOME)/npm/npmrc"
$env.PARALLEL_HOME =         $"($env.XDG_CONFIG_HOME)/parallel"
$env.PASSWORD_STORE_DIR =    $"($env.XDG_DATA_HOME)/pass"
$env.W3M_DIR =               $"($env.XDG_STATE_HOME)/w3m"
$env.GNUPGHOME =             $"($env.XDG_DATA_HOME)/gnupg"

####################################
## My Other Environment Variables ##
####################################

$env.SCRIPTS =    $"($env.XDG_DATA_HOME)/my_scripts"
$env.MASON_PKGS = $"($env.XDG_DATA_HOME)/nvim/mason/bin"

## Default Programs
$env.EDITOR = "nvim"
$env.AUR_HELPER = "paru"
$env.BROWSER = "brave"

###########
## Other ##
###########

$env.TRASHDIR = $"($env.XDG_DATA_HOME)/Trash"
$env.QT_STYLE_OVERRIDE = "kvantum"

################################
## Path Environment Variables ##
################################

$env.Path = ($env.Path | append [
	$"($env.CARGO_HOME)/bin"
	$"($env.XDG_DATA_HOME)/npm/bin"
	$env.SCRIPTS
	$"($env.SCRIPTS)/hide_apps"
	$"($env.SCRIPTS)/count_packages"
	$"($env.HOME)/.local/bin"
])
