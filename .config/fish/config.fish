status is-interactive || exit 0

_run_if_found starship init fish | source

_run_if_found rtx activate -s fish | source

type -q bat && abbr cat 'bat -pp'
type -q exa && abbr ls 'exa'
