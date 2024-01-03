#!/bin/sh
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export MITMPROXY_HOME="$XDG_CONFIG_HOME/mitmproxy" # Should be used with an alias.
export ANDROID_HOME="$XDG_DATA_HOME/android" # Should be used with an alias for adb.
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PYTHON_STARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
