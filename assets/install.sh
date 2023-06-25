#!/bin/sh
# shellcheck disable=SC2059
if [ -z "$DOTFILES_HOME" ]; then
  DOTFILES_HOME="$HOME/.dotfiles"
fi

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
PURPLE='\033[1;35m'
RESET='\033[m'

inf()  {
  printf "$PURPLE%s$RESET\n" "$@"
}

die()  {
  ret=$?
  printf "$RESET"
  exit $ret
}

dot()  {
  git --git-dir="$DOTFILES_HOME" --work-tree="$HOME" "$@"
}

check_deps()  {
  for dep; do
    if ! command -v "$dep" > /dev/null; then
      printf "$RED%s %s %s" "Program" "$dep" "not found. Install it or add to PATH."
      die
    fi
  done
}

clone_repo() {
  inf "Cloning the repository to '$DOTFILES_HOME'..."
  git clone --bare "https://github.com/uKaigo/dotfiles" "$DOTFILES_HOME" || die
  dot config --local status.showUntrackedFiles no
}

backup_files()  {
  files=$(dot ls-tree --name-only --full-tree -r HEAD)
  [ -n "$files" ] && inf "Backing up files..."
  for file in $files; do
    [ ! -f "$file" ] && continue
    printf "$PURPLE%s '$YELLOW%s$PURPLE' %s '$YELLOW%s$PURPLE'%s$RESET\n" "Backing up" "$file" "to" "$file.bkp" "..."
    mv "$HOME/$file" "$HOME/$file.bkp"
  done
}

checkout()  {
  inf "Checking out repository..."
  dot checkout || die
}

install_nvchad() {
  inf "Do you want to install NvChad? [Y/n]"
  read -n 1 -r 
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    inf "Installing NvChad to '$HOME/.config/nvim'..."
    cd "$HOME/.config/nvim"
    # https://stackoverflow.com/questions/2411031/how-do-i-clone-into-a-non-empty-directory 
    git init
    git remote add origin "https://github.com/NvChad/NvChad"
    git fetch
    # https://stackoverflow.com/questions/28666357/how-to-get-default-git-branch
    branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
    git checkout -t "origin/$branch"
    cd - > /dev/null
  fi
}

trap 'printf "\033[0m"; exit 1' INT HUP

check_deps "git" "sed"

inf "Installing uKaigo's dotfiles..."

clone_repo
backup_files
checkout
install_nvchad

inf "Installed."

printf "$RESET"
