# Run this script once to set up everything.
curl -sL https://git.io/fisher | source
fisher update

fish_vi_key_bindings

fish_config theme save 'Catppuccin Mocha'
