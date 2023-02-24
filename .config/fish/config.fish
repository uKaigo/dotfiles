status is-interactive || exit 0

starship init fish | source

rtx activate -s fish | source

type -q bat && abbr cat 'bat -pp'
