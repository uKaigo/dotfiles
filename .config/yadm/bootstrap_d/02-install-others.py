#!/bin/env python3
# BOOTSTRAP INITIALIZATION
from __future__ import annotations

import sys
from os import path

if sys.hexversion <= 0x030800F0:
    # 3.8 is the minimum version still maintained.
    raise RuntimeError('Minimum Python version is 3.8.0!')

__package__ = 'shared'
sys.path.insert(0, path.dirname('__file__'))

# BOOTSTRAP CODE
from enum import Enum
from shutil import which
from typing import TYPE_CHECKING
from collections import deque
from dataclasses import dataclass

from shared.py import inf, run, confirm

if TYPE_CHECKING:
    from typing import Deque, Sequence

YELLOW = '\033[33m'
YELLOW_B = '\033[33;1m'
RESET = '\033[m'


def install(*packages: Package, confirm: bool = True) -> bool:
    if not packages:
        return False

    confirm_opt = '--confirm' if confirm else '--noconfirm'

    to_run: Deque[Sequence[str]] = deque()
    if len(packages) == 1:
        pkg = packages[0]

        cmd: Deque[str] = deque()
        if pkg.method is Method.SYSTEM or pkg.needs_sudo:
            cmd.append('sudo')

        if pkg.method is Method.SYSTEM:
            cmd.extend(('pacman', '-S', confirm_opt, pkg.install))
        else:
            cmd.append(pkg.install)

        to_run.append(cmd)
    else:
        cmd = deque(('sudo', 'pacman', '-S', confirm_opt))

        for pkg in packages:
            if pkg.method is Method.SYSTEM:
                cmd.append(pkg.install)
            else:
                if pkg.needs_sudo:
                    to_run.append(('sudo', pkg.install))
                else:
                    to_run.append((pkg.install,))

        to_run.appendleft(cmd)

    for c in to_run:
        run(*c)
    return True


class Method(Enum):
    SYSTEM = 1
    SCRIPT = 2


@dataclass(frozen=True)
class Package:
    name: str
    binary: str
    install: str
    method: Method
    needs_sudo: bool = False


SCRIPT_PATH = path.dirname(path.realpath(__file__))

PACKAGES = [
    Package('starship', 'starship', 'starship', Method.SYSTEM),
    Package('eza', 'eza', 'eza', Method.SYSTEM),
    Package('git-delta', 'delta', 'git-delta', Method.SYSTEM),
    Package('ripgrep', 'rg', 'ripgrep', Method.SYSTEM),
    Package('mise.jdx.dev', 'mise', f'{SCRIPT_PATH}/../mise-install.sh', Method.SCRIPT),
]


if not which('pacman'):
    inf("Only the 'pacman' package manager is supported by this script.")
    inf('The list of packages that would be installed by pacman are:')
    print('\n'.join(pkg.install for pkg in PACKAGES if pkg.method is Method.SYSTEM))

    inf('Aditionally, these would be installed externally:')
    print('\n'.join(pkg.name for pkg in PACKAGES if pkg.method is Method.SCRIPT))
    sys.exit(0)

inf(
    'Before installing packages, the system must be updated to prevent partial-updates.'
)
if confirm("Run 'sudo pacman -Syu'"):
    run('sudo', 'pacman', '-Syu')

if confirm('Do you want to install all recommended packages'):
    to_install = filter(lambda e: not which(e.binary), PACKAGES)
    if not install(*to_install, confirm=True):
        inf('No packages installed.')
    sys.exit(0)

installed = False
for package in PACKAGES:
    if which(package.binary):
        continue
    if confirm(f"Do you want to install '{package.name}'"):
        installed = True
        install(package, confirm=False)

if not installed:
    inf('No packages installed.')
