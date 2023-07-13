status is-interactive || exit 0

_run_if_found starship init fish | source

_run_if_found "$HOME/.local/share/rtx/bin/rtx" activate -s fish | source

# I'm hardcoding the bin folder because `yarn global bin`
# takes about 500ms.
fish_add_path -P "$HOME/.yarn/bin"

type -q docker && abbr docker 'sudo docker'
type -q nvim && abbr nvsu 'sudo env HOME=$HOME nvim'
type -q bat && abbr cat 'bat -pp'
type -q exa && abbr ls 'exa -a --icons'
type -q exa && abbr exa 'exa --icons' # Abbreviations are not recursive.
