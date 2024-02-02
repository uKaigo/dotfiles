_check_updated() {
  # Checks if a given plugin ($1) is up to date with upstream.
  # Returns "0" if up to date, "1" otherwise.
  plugin=$1
  git -C $1 fetch

  loc=$(git -C $plugin rev-parse @)
  rmt=$(git -C $plugin rev-parse @{u})

  [[ $loc = $rem ]] && return 0
  return 1
}

update_plugins() {
  # Updates all plugin that are not up to date with upstream.
  PLUGINS_DIR=${PLUGINS_DIR:-$ZDOTDIR/plugins}

  if [ ! -d $PLUGINS_DIR ]; then
    echo "No plugin to update."
    return 0
  fi

  updated_some_plugin=0

  for plugin in $PLUGINS_DIR/*/*; do
    if ! _check_updated $plugin; then
      echo "Updating '$(basename $plugin)'"
      git -C $plugin pull
      updated_some_plugin=1
    fi
  done

  if [ $updated_some_plugin = 0 ]; then
    echo "No plugin to update."
    return 0
  fi
}

load_plugin() {
  # Sources the plugin's ($1) entrypoint ($2), downloading it if necessary.
  PLUGINS_DIR=${PLUGINS_DIR:-$ZDOTDIR/plugins}

  plugin_id=$1
  entrypoint=$2

  if [ -z $entrypoint ]; then
    echo "Entrypoint for '$plugin_id' not set. Skipping..."
    return 0
  fi

  [ ! -d $PLUGINS_DIR ] && mkdir "$PLUGINS_DIR"

  if [ ! -d "$PLUGINS_DIR/$plugin_id" ]; then
    echo "Installing '$plugin_id'..."
    git clone -q --depth=1 "https://github.com/$plugin_id" "$PLUGINS_DIR/$plugin_id"
  fi

  source "$PLUGINS_DIR/$plugin_id/$entrypoint"
}
