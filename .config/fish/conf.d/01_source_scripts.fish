_run_if_found starship init fish | source

_run_if_found "$HOME/.local/bin/mise" activate fish | source

_run_if_found zoxide init fish --cmd cd | source

if test -z "$__PROFILE_SOURCED"
  source ~/.profile
end
