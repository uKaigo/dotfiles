alias scrcpy='scrcpy --prefer-text'

alias ls='ls --color=tty -A'
alias l='ls -lFh'
alias lr='ls -tRFh'
alias lt='ls -ltFh'
alias ll='ls -l'
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsr='ls -lARFh'
alias lsn='ls -1'

alias grep="grep --color"
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias diff="diff --color"

if command -v bat > /dev/null; then
  alias cat="bat -pp"
fi

# Bare dotfiles alias
alias config='git --git-dir ${DOTFILES_HOME:-$HOME/.dotfiles} --work-tree=$HOME'
alias privconfig='git --git-dir ${DOTFILES_PRIVATE_HOME:-$HOME/dotfiles-private} --work-tree=$HOME'

