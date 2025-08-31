$env.config.buffer_editor = "nvim" # To use Neovim as the default editor

### History ###
$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 5_000_000
$env.config.history.isolation = true      # New history session is created for each new shell session

### Miscellaneous Settings ###
$env.config.show_banner = false           # No 'Welcome' banner at startup
$env.config.rm.always_trash = true        # Move to Recycle Bin by default

### Terminal Integration ###
$env.config.use_kitty_protocol = true     # Additional keybindings are available when using this protocol in a supported terminal
$env.config.shell_integration.osc2 = true # When true, the current directory and running command are shown in the terminal tab/window title.

## Table Display ###
$env.config.table.mode = "single"
$env.config.table.show_empty = false      # Don't show an empty table

## Yazi Wrapper ##
def --env yy [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# Start Starship Prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Setup Carapace for completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
source ~/.cache/carapace/init.nu
