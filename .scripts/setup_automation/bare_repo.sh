#!/bin/fish

git clone --bare https://github.com/AbubakrBardien/dotfiles.git $HOME/.dotfiles/

alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

echo "alias config \"/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME\"" >> $HOME/.config/fish/config.fish

# Removing files to avoid getting an error from git

if [ -f .bashrc ]; then
    rm .bashrc
fi

if [ -f .gitignore ]; then
    rm .gitignore
fi

config checkout

config config --local status.showUntrackedFiles no
