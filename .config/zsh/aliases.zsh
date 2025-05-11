alias ls="lsd"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -Al"
alias tree="ls --tree"

alias grep="grep --color=auto"
alias diff="diff --color=auto"

alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias cdiff="config diff"
alias status="config status"
alias add="config add"
alias commit="config commit"
alias push="config push"

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -vi"

alias fk="sudo !!"

alias disks="duf /"        # Display Disk Space
alias folder_size="du -sh"    # Directory Size
alias disk_usage="dust -r" # Disk Usage Viewer

alias benchmark="hyperfine" # Very useful benchmarking tool
alias cat="bat"
alias pipes="pipes.sh"
alias ping="gping"
alias web_search="surfraw"

alias gs="git status"
alias bm="bat -l man --style=plain" # Example usage: "paru --help | bm"
alias xdg-ninja="xdg-ninja --skip-unsupported"

# For XDG Base Directory Compliance
alias mysql-workbench="mysql-workbench --configdir=\"$XDG_DATA_HOME/mysql/workbench\""
