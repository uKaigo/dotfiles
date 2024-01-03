function mitmweb --wraps='mitmweb' --description 'Alias to change mitmweb config dir.'
  set -q MITMPROXY_HOME; or set MITMPROXY_HOME "$HOME/.mitmproxy"
  command mitmweb --set confdir="$MITMPROXY_HOME" $argv
end
