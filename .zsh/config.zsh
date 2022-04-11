# History settings
export HISTFILE="$ZDOTDIR/.history"
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:  "
export HISTSIZE=10000
export SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# Set LunarVim as default editor
export EDITOR=lvim

# Recognize comments
setopt INTERACTIVE_COMMENTS
