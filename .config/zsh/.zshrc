# Don't do anything if we're not in interactive mode.
[[ $- != *i* ]] && return

CONF_D="$ZDOTDIR/conf.d"
for file in $CONF_D/**/*(.); do
  source $file
done

# Load plugins
load_plugin "zsh-users/zsh-autosuggestions" "zsh-autosuggestions.zsh"
load_plugin "zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh"
load_plugin "ohmyzsh/ohmyzsh" "lib/vcs_info.zsh"

# Use VIM keybindings (ohmyzsh/key-bindings overwrites it)
bindkey -v 
