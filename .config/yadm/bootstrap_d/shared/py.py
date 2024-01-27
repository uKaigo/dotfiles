from __future__ import annotations

import re
import sys
import shlex
import subprocess
from typing import Tuple, Union
from functools import lru_cache
from contextlib import suppress as supress_exc
from subprocess import PIPE, Popen, CalledProcessError

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

    with supress_exc(FileNotFoundError, CalledProcessError, ValueError):
        output = subprocess.check_output(['locale', 'LC_MESSAGES'])

        data = output.decode().splitlines()
        if len(data) <= 4:
            raise ValueError('Invalid data.')

        yespt = re.compile(data[0])
        nopt = re.compile(data[1])
        yesstr = data[2]
        nostr = data[3]

    return (yespt, nopt, yesstr, nostr)


def confirm(text: str) -> bool:
    yespt, nopt, yesstr, nostr = get_confirm_locale()
    try:
        while True:
            res = input(f'{YELLOW}{text} ({yesstr} / {nostr})?{RESET} ').strip()
            if yespt.match(res):
                return True
            if nopt.match(res):
                return False
    except KeyboardInterrupt:
        sys.exit(0)


def run(arg_0: str, /, *args: str, shell: bool = False) -> None:
    run_args: Union[str, tuple[str, ...]] = (arg_0, *args) if args else arg_0

    if not shell and isinstance(run_args, str):
        run_args = tuple(shlex.split(run_args))

    with Popen(
        run_args, stdout=PIPE, bufsize=1, universal_newlines=True, shell=shell
    ) as proc:
        assert proc.stdout is not None  # type checker

        try:
            for line in proc.stdout:
                print(line, end='')
        except:
            proc.kill()
            raise
