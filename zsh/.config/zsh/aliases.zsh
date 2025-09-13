alias ls="lsd"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -Al"
alias tree="ls --tree"

alias grep="grep --color=auto"

alias gl="git log"
alias glg="git log --graph"
alias glo="git log --oneline"
alias glgo="git log --graph --oneline"

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -vi"

alias disks="duf /"        # Display Disk Space
alias folder_size="du -sh" # Directory Size
alias disk_usage="dust -r" # Disk Usage Viewer

alias benchmark="hyperfine" # Very useful benchmarking tool
alias cat="bat"
alias pipes="pipes.sh"
alias ping="gping"
alias web-search="surfraw"
alias delta="delta --side-by-side --syntax-theme=none"

alias bm="bat -l help --style=plain" # Example usage: "paru --help | bm"
alias lsblk="lsblk | bat -l conf -p"
alias rg="batgrep"
alias xdg-ninja="xdg-ninja --skip-unsupported"
