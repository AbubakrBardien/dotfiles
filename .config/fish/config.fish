set fish_greeting	# Supresses Fish's into message

alias config "/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME" 
alias ls "lsd"
alias cat "bat"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
