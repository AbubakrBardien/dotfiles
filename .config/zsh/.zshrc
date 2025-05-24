source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/aliases.zsh"

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

# Download Zinit, if it's not downloaded there already
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Install and load plugins with Zinit
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light olets/zsh-window-title

# Initialize the completion system after Zinit has loaded the "zsh-completions" plugin
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Completion Options
zstyle ":completion:*" menu select                 # Enables menu completion
zstyle ":completion::complete:*" gain-privileges 1 # Completions for sudo commands

# Configuring "zsh-users/zsh-syntax-highlighting" plugin
source "$ZDOTDIR/onedark-pro.zsh" # Applying a Colorscheme

# Configuring "zsh-users/zsh-history-substring-search"
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Configuring "olets/zsh-window-title"
ZSH_WINDOW_TITLE_DIRECTORY_DEPTH=10

eval "$(starship init zsh)"                            # Prompt customization       ("~/.config/starship.toml")
eval "$(batman --export-env)"                          # Colorize man pages         ("~/.config/bat/")
eval "$(batpipe)"                                      # Colorize the "less" output ("~/.config/bat/") (only works with files)
eval "$(register-python-argcomplete --shell zsh pipx)" # Configure Tab Completion for pipx

# "setopt", "unsetopt", "bindkey", "autoload", "zstyle" are all Zsh-Specific and therefore NOT POSIX-Compatible
