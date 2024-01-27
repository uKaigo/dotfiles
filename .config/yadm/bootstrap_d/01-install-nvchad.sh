#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

FILE_PATH="${0%/*}"
source "$FILE_PATH/shared/ba.sh"

NVIM_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if ! confirm "Install NVChad"; then
	exit 0
fi

inf "Installing NvChad to '$NVIM_HOME'..."
cd "$NVIM_HOME"

git init
git remote add origin 'https://github.com/NvChad/NvChad'
git fetch --depth=1

# https://stackoverflow.com/questions/28666357/how-to-get-default-git-branch
branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
git checkout -t "origin/$branch"
cd - >/dev/null
