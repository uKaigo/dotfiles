function adb --wraps='adb' --description 'Alias to change adb config dir.'
  set -q ANDROID_HOME; or set ANDROID_HOME "$HOME"
  env HOME="$ANDROID_HOME" adb $argv
end
