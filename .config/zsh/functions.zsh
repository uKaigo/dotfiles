update_plugins () {
  [ -z $PLUGINS_DIR ] && PLUGINS_DIR="$ZDOTDIR/plugins"
  if [ ! -d $PLUGINS_DIR ]; then
    echo No plugin to update.
    return 0
  fi

  cd "$PLUGINS_DIR"
  plugins=($(find */* -maxdepth 0))
  cd - > /dev/null

  for plugin in $plugins
  do
    echo "Updating \"$plugin\"..."
    git -C "$PLUGINS_DIR/$plugin" pull
    echo
  done
}

load_plugin () {
    # Downloads a plugin if it doesn't exists and load it.
    plugin_id=$1
    entrypoint=$2
    [ -z $PLUGINS_DIR ] && PLUGINS_DIR="$ZDOTDIR/plugins"
    [ ! -d $PLUGINS_DIR ] && mkdir "$PLUGINS_DIR"

    if [ -z $entrypoint ]; then
        echo "Entrypoint for \"$plugin_id\" not set. Skipping..."
        return 0
    fi

    if [ ! -d $PLUGINS_DIR/$plugin_id ]; then
        echo "Installing $plugin_id..."
        git clone -q --depth=1 "https://github.com/$plugin_id" "$PLUGINS_DIR/$plugin_id" 
    fi

    source "$PLUGINS_DIR/$plugin_id/$entrypoint"
}

is_termux () {
  type termux-reload-settings > /dev/null
}

# Polyfill for zsh-auto-notify
if is_termux; then
  notify-send () {
    termux-notification -t "$1" -c "$2"   
  }
fi

