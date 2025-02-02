#!/bin/bash
MISE_INSTALL_PATH=${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}

if [ -x $MISE_INSTALL_PATH ]; then
	$MISE_INSTALL_PATH self-update
fi
