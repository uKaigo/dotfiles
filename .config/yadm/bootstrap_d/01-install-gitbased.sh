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

git init >/dev/null
if ! git remote add origin 'https://github.com/NvChad/NvChad' >/dev/null; then
	inf "Couldn't add origin. Is NvChad already installed? Aborting..."
	exit 0
fi
git fetch --depth=1 >/dev/null

# https://stackoverflow.com/questions/28666357/how-to-get-default-git-branch
branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
git checkout -t "origin/$branch" >/dev/null
cd - >/dev/null

inf "NvChad installed."
