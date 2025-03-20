source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"

### History ###
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # Erase any duplicates in history (during a session)
setopt hist_save_no_dups    # Erase any duplicates in history (at the end of session)
setopt share_history        # Share history between sessions (e.g. between multiple windows) (Note: this is not instantaneous, and it's not meant to be)

setopt auto_cd      # (e.g. allows you to enter "Desktop" instead of "cd Desktop")
setopt menucomplete # Auto-select an option when pressing tab
unsetopt beep       # No error noise

bindkey -e # Emacs keybindings (more beginner friendly than Vim keybindings)
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

eval "$(starship init zsh)"   # Prompt customization       ("~/.config/starship.toml")
eval "$(batman --export-env)" # colorize man pages         ("~/.config/bat/")
eval "$(batpipe)"             # Colorize the "less" output ("~/.config/bat/") (only works with files)

source /usr/share/zinit/zinit.zsh
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light marlonrichert/zsh-autocomplete
zinit light olets/zsh-window-title

# Load zsh-completions, and start the completion system
fpath=($ZPLUG_HOME/repos/zsh-users/zsh-completions $fpath)
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ":completion:*" menu select                 # Enables menu completion
zstyle ":completion::complete:*" gain-privileges 1 # Completions for sudo commands

# Configuring "zsh-users/zsh-syntax-highlighting" plugin
source "$ZDOTDIR/onedark-pro.zsh" # Applying a Colorscheme

# Configuring "zsh-users/zsh-history-substring-search"
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Configuring "marlonrichert/zsh-autocomplete"
bindkey "^I" menu-select
bindkey "$terminfo[kcbt]" menu-select
zstyle ':autocomplete:*' add-space commands

# Configuring "olets/zsh-window-title"
ZSH_WINDOW_TITLE_DIRECTORY_DEPTH=10
