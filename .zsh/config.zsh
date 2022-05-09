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

# Set Bash's PS4
export PS4='+\033[1;33m(${BASH_SOURCE}:${LINENO})\033[m: ${FUNCNAME[0]:+\033[1;32m${FUNCNAME[0]}()\033[m: }'
