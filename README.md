dotfiles
========

These are my opinionated dotfiles setup.

Uses [yadm](https://yadm.io) as a dotfiles manager.

Installation
------------

Since this is made for my needs, it may or may not work on your setup.
But if you really want to use it, you can just `yadm clone` this repo, and
run the `yadm bootstrap` program to finish the setup.

Currently, the bootstrap program:

1. Installs Tmux Plugin Manager.
2. Installs some [useful packages](https://github.com/uKaigo/dotfiles/blob/main/.config/yadm/bootstrap_d/02-install-others.py#L87).

All of the steps are optional and you WILL be asked for input.

If you wish to say yes to all questions, set the `BS_CONFIRM_ALL` environment variable.

Example:
```sh
$ BS_CONFIRM_ALL= yadm bootstrap
```
