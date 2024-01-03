function mitmproxy --wraps='mitmproxy' --description 'Alias to change mitmproxy config dir.'
  set -q MITMPROXY_HOME; or set MITMPROXY_HOME "$HOME/.mitmproxy"
  command mitmproxy --set confdir="$MITMPROXY_HOME"
end
