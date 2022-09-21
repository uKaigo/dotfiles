alias scrcpy='scrcpy --prefer-text'

alias ls='ls --color=tty -A'

alias grep="grep --color"

alias diff="diff --color"

if command -v bat > /dev/null; then
  alias cat="bat -pp"
fi

# Bare dotfiles alias
alias config='git --git-dir ${DOTFILES_HOME:-$HOME/.dotfiles} --work-tree=$HOME'
alias privconfig='git --git-dir ${DOTFILES_PRIVATE_HOME:-$HOME/dotfiles-private} --work-tree=$HOME'

