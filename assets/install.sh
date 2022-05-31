#!/bin/sh
# shellcheck disable=SC2059
if [ -z "$DOTFILES_HOME" ]; then
  DOTFILES_HOME="$HOME/dotfiles"
fi

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
PURPLE='\033[1;35m'
RESET='\033[m'

inf()  {
  printf "\033[1;35m%s\033[m\n" "$@"
}

die()  {
  ret=$?
  printf "$RESET"
  exit $ret
}

check_deps()  {
  for dep; do
    if ! command -v "$dep" > /dev/null; then
      printf "$RED%s %s %s\n" "Program " "$dep" "not found. Please install it."
      die
    fi
  done
}

clone_repo()  {
  inf "Cloning repository..."
  printf "$YELLOW"
  git clone --bare "https://github.com/uKaigo/dotfiles" "$DOTFILES_HOME" || die
  printf "$RESET"
  config config --local status.showUntrackedFiles no
}

config()  {
  git --git-dir="$DOTFILES_HOME" --work-tree="$HOME" "$@"
}

backup_files()  {
  files=$(config ls-tree --name-only --full-tree -r HEAD)
  [ -n "$files" ] && inf "Backing up files..."
  for file in $files; do
    [ ! -f "$file" ] && continue
    printf "$PURPLE%s \"$GREEN%s$PURPLE\" %s \"$GREEN%s$PURPLE\"%s$RESET\n" "Backing up" "$file" "to" "$file.bkp" "..."
    mv "$HOME/$file" "$HOME/$file.bkp"
  done
}

checkout()  {
  inf "Checking out repository..."
  printf "$YELLOW"
  config checkout || die
  printf "$RESET"
}

trap 'printf "\033[0m"; exit 1' INT HUP

check_deps "git"

inf "Installing uKaigo's dotfiles..."

clone_repo
backup_files
checkout

inf "Installed."
inf "Recommended packages: zsh, delta (dandavison/delta)"

printf "$RESET"
