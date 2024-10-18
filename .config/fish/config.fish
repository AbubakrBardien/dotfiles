if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting	# Supresses Fish's into message

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

# Set Environment Variables
set -x EDITOR "/usr/bin/nvim"
set -x TERMINAL "/usr/bin/foot"

# Fuction to be able to change directory when exiting. Call it with 'yy'
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# Custom Starship Prompt
starship init fish | source
