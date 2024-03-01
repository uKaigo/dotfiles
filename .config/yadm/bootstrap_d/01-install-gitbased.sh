#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

FILE_PATH="${0%/*}"
source "$FILE_PATH/shared/ba.sh"

NVIM_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
TMUX_PHOME="$HOME/.config/tmux/plugins" # Tmux does not respect XDG_CONFIG_HOME

install_nvchad() {
	if ! confirm "Install NvChad"; then return; fi

	inf "Installing NvChad to '$NVIM_HOME'..."
	pushd "$NVIM_HOME"

	git init >/dev/null
	if ! git remote add origin 'https://github.com/NvChad/NvChad' >/dev/null; then
		inf "Couldn't add origin. Is NvChad already installed? Aborting..."
		return
	fi
	git fetch --depth=1 >/dev/null

	# https://stackoverflow.com/questions/28666357/how-to-get-default-git-branch
	branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
	git checkout -t "origin/$branch" >/dev/null

	popd >/dev/null
	inf "NvChad installed."
}

install_tpm() {
	if ! confirm "Install Tmux Plugin Manager"; then return; fi

	inf "Installing TPM to '$TMUX_PHOME'.."

	git clone 'https://github.com/tmux-plugins/tpm' "$TMUX_PHOME/tpm" >/dev/null

	inf "TPM Installed."
}

install_nvchad
install_tpm
