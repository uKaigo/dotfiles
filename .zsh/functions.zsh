update_plugins () {
  [ -z $PLUGINS_DIR ] && PLUGINS_DIR="$ZDOTDIR/plugins"
  if [ ! -d $PLUGINS_DIR ]; then
    echo No plugin to update.
    return 0
  fi

  START_LOC=$(pwd)

  cd "$PLUGINS_DIR"

  plugins=($(find */* -maxdepth 0))

  for plugin in $plugins
  do
    cd "$PLUGINS_DIR/$plugin"
    echo "Updating \"$plugin\"..."
    git pull
    echo
  done

  # Go back to start location
  cd "$START_LOC"
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
