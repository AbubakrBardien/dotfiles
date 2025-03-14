alias ls="lsd --group-dirs=first"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -Al"
alias tree="ls --tree"

alias grep="grep --color=auto"
alias diff="diff --color=auto"

alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias cstatus="config status"
alias cdiff="config diff"
alias add="config add"
alias commit="config commit"
alias push="config push"

alias cat="bat"
alias pipes="pipes.sh"
alias ping="gping"

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

alias disks="duf /" # Display Disk Space
alias dir_size="du -sh" # Directory Size
alias disk_usage="dust -r" # Disk Usage Viewer

alias benchmark="hyperfine" # Very useful benchmarking tool

alias fk="sudo !!"
