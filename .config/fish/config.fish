status is-interactive || exit 0

_run_if_found starship init fish | source

_run_if_found "$HOME/.local/share/rtx/bin/rtx" activate -s fish | source

# I'm hardcoding the bin folder because `yarn global bin`
# takes about 500ms.
fish_add_path -P "$HOME/.yarn/bin"

abbr docker 'sudo docker'
abbr nvsu 'sudo env HOME=$HOME nvim'
abbr cat 'bat -pp'
abbr ls 'exa -a --icons'
abbr exa 'exa --icons' # Abbreviations are not recursive.
