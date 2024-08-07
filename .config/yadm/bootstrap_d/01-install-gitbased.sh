#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

FILE_PATH="${0%/*}"
source "$FILE_PATH/shared/ba.sh"

TMUX_PHOME="$HOME/.config/tmux/plugins" # Tmux does not respect XDG_CONFIG_HOME

install_tpm() {
	if ! confirm "Install Tmux Plugin Manager"; then return; fi

	inf "Installing TPM to '$TMUX_PHOME'.."

	git clone 'https://github.com/tmux-plugins/tpm' "$TMUX_PHOME/tpm" >/dev/null

	inf "TPM Installed."
}

install_tpm
