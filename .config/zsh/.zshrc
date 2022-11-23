# Don't do anything if we're not in interactive mode.
[[ $- != *i* ]] && return

if [ "$TERM" = "linux" ]; then
  echo -ne '\e]P0150414\e]P7FFFFFF\ec' # Change tty background
  clear
fi

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Update PATH
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"
[ -d $HOME/bin ] && export PATH="$HOME/bin:$PATH"

# Load functions
source $ZDOTDIR/functions.zsh
# Load configuration
source $ZDOTDIR/config.zsh
# Load completion system
source $ZDOTDIR/completion.zsh
# Load vi keys settings
source $ZDOTDIR/vikeys.zsh
# Load aliases
source $ZDOTDIR/aliases.zsh
# Load PowerLevel config
if [ "$TERM" != "linux" ]; then
  source $ZDOTDIR/.p10k.zsh
else
  source $ZDOTDIR/.p10k-tty.zsh
fi

# Load plugins
load_plugin "zsh-users/zsh-autosuggestions" "zsh-autosuggestions.zsh"
load_plugin "zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh"
load_plugin "ohmyzsh/ohmyzsh" "lib/key-bindings.zsh"
load_plugin "ohmyzsh/ohmyzsh" "lib/termsupport.zsh"
load_plugin "ohmyzsh/ohmyzsh" "lib/vcs_info.zsh"
load_plugin "davidparsson/zsh-pyenv-lazy" "pyenv-lazy.plugin.zsh"
load_plugin "uKaigo/zsh-nvm" "zsh-nvm.plugin.zsh"
load_plugin "MichaelAquilina/zsh-you-should-use" "you-should-use.plugin.zsh"
load_plugin "romkatv/powerlevel10k" "powerlevel10k.zsh-theme"

# Use VIM keybindings (ohmyzsh/key-bindings overwrites it)
bindkey -v 

# Add cargo to PATH
[ -s $HOME/.cargo/env ] && source $HOME/.cargo/env

# Load command-not-found handler
[ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found
