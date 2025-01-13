#!/bin/sh -n
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="/usr/bin/nvim"
export MITMPROXY_HOME="$XDG_CONFIG_HOME/mitmproxy" # Should be used with an alias.
export ANDROID_HOME="$XDG_DATA_HOME/android"       # Should be used with an alias for adb.
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export MINECRAFT_HOME="$XDG_DATA_HOME/minecraft"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export __PROFILE_SOURCED="1"
