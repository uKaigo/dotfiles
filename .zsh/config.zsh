# History settings
HISTFILE="$ZDOTDIR/.history"
HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:  "
HISTSIZE=10000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# Set LunarVim as default editor
export EDITOR=lvim

# Recognize comments
setopt INTERACTIVE_COMMENTS

# Change dir by typing dir name (without cd)
setopt AUTO_CD

# Remove right indentation
ZLE_RPROMPT_INDENT=0

# Configure prompts
PROMPT="[%B%F{magenta}%n%f%b@%B%F{magenta}%m%f%b %B%F{white}%~%f%b]%(#.#.$) "
RPROMPT="%(?.. %? %F{red}%BX%b%f)%(1j. %j %F{yellow}%BJ%b%f.) [%*]"
PROMPT2="> "
RPROMPT2="[%F{magenta}%B%_%b%f]"

TIMEFMT=$'\nreal   %E\nuser   %U\nsys    %S\ncpu    %P'

export PS4='+\033[1;33m(${BASH_SOURCE}:${LINENO})\033[m: ${FUNCNAME[0]:+\033[1;32m${FUNCNAME[0]}()\033[m: }'
export PROMPT4='+%F{yellow}%B(%x:%I)%b%f: ' # Not equivalent to Bash's, but similar
