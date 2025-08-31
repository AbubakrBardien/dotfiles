alias benchmark = hyperfine # Very useful benchmarking tool
alias cat = bat
alias delta = delta --side-by-side --syntax-theme=none
alias ping = gping
alias pipes = pipes.sh
alias tree = lsd --tree
alias web-search = surfraw
alias xdg-ninja = xdg-ninja --skip-unsupported

# For XDG Base Directory Compliance
alias mysql-workbench = mysql-workbench --configdir=$"($env.XDG_DATA_HOME)/mysql/workbench"
