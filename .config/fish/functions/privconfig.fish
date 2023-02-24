function privconfig --wraps='git' --description 'Alias to work with bare private-dotfiles repo.'
  git --git-dir "$HOME/dotfiles-private" --work-tree "$HOME" $argv
end
