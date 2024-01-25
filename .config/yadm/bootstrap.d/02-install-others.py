#!/bin/env python
from __future__ import annotations

import sys

if sys.hexversion <= 0x030800F0:
    # 3.8 is the minimum version still supported by Python.
    raise RuntimeError('Minimum Python version is 3.8.0!')

import re
import shlex
import subprocess
from os import path
from enum import Enum
from shutil import which
from typing import TYPE_CHECKING, Sequence
from functools import lru_cache
from contextlib import suppress as supress_exc
from subprocess import PIPE, Popen, CalledProcessError
from collections import deque
from dataclasses import dataclass

if TYPE_CHECKING:
    from typing import Deque, Tuple


YELLOW = '\033[33m'
YELLOW_B = '\033[33;1m'
RESET = '\033[m'


def inf(*text: str, sep: str = ' ') -> None:
    print(f'{YELLOW_B}{sep.join(text)}{RESET}')


@lru_cache(maxsize=None)
def get_confirm_locale() -> Tuple[re.Pattern[str], re.Pattern[str], str, str]:
    yespt = re.compile(r'^[+1yY]')
    nopt = re.compile(r'^[-0nN]')
    yesstr = 'yes'
    nostr = 'no'

    with supress_exc(FileNotFoundError, CalledProcessError):
        output = subprocess.check_output(['locale', 'LC_MESSAGES'])

        data = output.decode().splitlines()
        if len(data) <= 4:
            return (yespt, nopt, yesstr, nostr)

        yespt = re.compile(data[0])
        nopt = re.compile(data[1])
        yesstr = data[2]
        nostr = data[3]

    return (yespt, nopt, yesstr, nostr)


def confirm(text: str) -> bool:
    yespt, nopt, yesstr, nostr = get_confirm_locale()
    while True:
        res = input(f'{YELLOW}{text} ({yesstr} / {nostr})?{RESET} ').strip()
        if yespt.match(res):
            return True
        if nopt.match(res):
            return False


def run(*args: str) -> None:
    if len(args) == 1:
        args = tuple(shlex.split(args[0]))

    with Popen(args, stdout=PIPE, bufsize=1, universal_newlines=True) as proc:
        assert proc.stdout is not None  # type checker

        try:
            for line in proc.stdout:
                print(line, end='')
        except:
            proc.kill()
            raise


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
    run('sudo pacman -Syu')

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
