function dot --wraps='git' --description 'Alias to work with bare dotfiles repo.'
  git --git-dir "$HOME/.dotfiles" --work-tree "$HOME" $argv
end
