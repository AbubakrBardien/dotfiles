ZSH_HIGHLIGHT_HIGHLIGHTERS=(main pattern)
typeset -A ZSH_HIGHLIGHT_STYLES

## Original Colors
# ONEDARK="#ABB2BF"     # Default / Fallback
ONEDARK_CMD="#61AFEF" # Commands
# ONEDARK_DIR="#A9DAA8" # Files and Folders
# ONEDARK_STR="#89CA78" # Strings (Double Qoutes)
# ONEDARK_CHA="#89CA98" # Strings (Single Qoutes)
# ONEDARK_NUM="#D19A66" # Numbers
# ONEDARK_VAR="#EF596F" # Variables
# ONEDARK_MOD="#E5C07B" # Options / Flags
ONEDARK_ASS="#2BBAC5" # Assignmants (e.g. '==')
ONEDARK_COM="#7F848E" # Comments
ONEDARK_KEY="#D55FDE" # Key words (e.g. 'if')
ONEDARK_BRA="#C678DD" # Brackets
# ONEDARK_ERR="#FF394F" # Errors

# Modified Colors
ONEDARK="#56B6C2"     # Default / Fallback
ONEDARK_DIR="#A9DAA8" # Files and Folders
ONEDARK_STR="#e6c993" # Strings (Double Qoutes)
ONEDARK_CHA="#e6c993" # Strings (Single Qoutes)
ONEDARK_NUM="#56B6C2" # Numbers
ONEDARK_VAR="#D19A66" # Variables
ONEDARK_MOD="#56B6C2" # Options / Flags
ONEDARK_ERR="#db5d51" # Errors

ZSH_HIGHLIGHT_STYLES[root]='bg=red'

ZSH_HIGHLIGHT_STYLES[comment]="fg=$ONEDARK_COM"

ZSH_HIGHLIGHT_STYLES[alias]="fg=$ONEDARK_CMD"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=$ONEDARK_CMD"
ZSH_HIGHLIGHT_STYLES[global-alias]="fg=$ONEDARK_CMD,bold,underline"
ZSH_HIGHLIGHT_STYLES[function]="fg=$ONEDARK_CMD"
ZSH_HIGHLIGHT_STYLES[command]="fg=$ONEDARK_CMD,bold"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$ONEDARK_CMD,italic"
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=$ONEDARK_DIR,italic"

# ZSH_HIGHLIGHT_STYLES[builtin]="fg=$ONEDARK_CMD,underline" # Abubakr commented this
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$ONEDARK_CMD"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$ONEDARK_KEY"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=$ONEDARK_CMD"

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=$ONEDARK_MOD"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=$ONEDARK_MOD"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=$ONEDARK_MOD"

ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=$ONEDARK_COM"

ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=$ONEDARK_NUM"
#ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]="fg=$ONEDARK_NUM"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]="fg=$ONEDARK_NUM,bold"
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=$ONEDARK_NUM"

ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=$ONEDARK_NUM"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=$ONEDARK_ASS"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=$ONEDARK_ASS"

#ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]="fg=$ONEDARK_MOD"
#ZSH_HIGHLIGHT_STYLES[command-substitution]="fg=?"
#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]="fg=?"
#ZSH_HIGHLIGHT_STYLES[process-substitution]="fg=?"
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]="fg=$ONEDARK_NUM"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$ONEDARK_CHA"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="fg=$ONEDARK_ERR"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$ONEDARK_STR"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="fg=$ONEDARK_ERR"
ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=$ONEDARK_STR,underline"

## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$ONEDARK_VAR"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]="fg=$ONEDARK_ERR"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=$ONEDARK_VAR"
ZSH_HIGHLIGHT_STYLES[assign]="fg=$ONEDARK_VAR,bold"
ZSH_HIGHLIGHT_STYLES[named-fd]="fg=$ONEDARK_DIR"
ZSH_HIGHLIGHT_STYLES[numeric-fd]="fg=$ONEDARK_ASS"

ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$ONEDARK_ERR"
ZSH_HIGHLIGHT_STYLES[path]="fg=$ONEDARK_DIR,underline"
#ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=$ONEDARK_DIR"
ZSH_HIGHLIGHT_STYLES[path_prefix]="fg=$ONEDARK_DIR"
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]="fg=$ONEDARK_DIR,bold"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$ONEDARK_NUM,bold"
ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=$ONEDARK_BRA"

ZSH_HIGHLIGHT_STYLES[redirection]="fg=$ONEDARK_BRA"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$ONEDARK"
ZSH_HIGHLIGHT_STYLES[default]="fg=$ONEDARK"
ZSH_HIGHLIGHT_STYLES[cursor]="fg=white"

typeset -gA ZSH_HIGHLIGHT_PATTERNS

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' "fg=$ONEDARK_CMD,bold,underline")
ZSH_HIGHLIGHT_PATTERNS+=('sudo' "fg=$ONEDARK_CMD,bold,underline")
ZSH_HIGHLIGHT_PATTERNS+=('suod' "fg=$ONEDARK_CMD,bold,underline")
ZSH_HIGHLIGHT_PATTERNS+=('==' "fg=$ONEDARK_ASS")
ZSH_HIGHLIGHT_PATTERNS+=('\' "fg=$ONEDARK_ASS")
ZSH_HIGHLIGHT_PATTERNS+=('\e\[*m' "fg=$ONEDARK_ASS,bold")
ZSH_HIGHLIGHT_PATTERNS+=('\x1b\[*m' "fg=$ONEDARK_ASS,bold")
ZSH_HIGHLIGHT_PATTERNS+=('\033\[*m' "fg=$ONEDARK_ASS,bold")
