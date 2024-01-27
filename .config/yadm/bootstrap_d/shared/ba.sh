#!/bin/bash -n
# shellcheck disable=SC2059
set -euo pipefail
IFS=$'\n\t'

# shellcheck disable=SC2046 # Intended splitting
# https://stackoverflow.com/a/226724https://stackoverflow.com/a/226724
set -- $(locale LC_MESSAGES)

YESEXPR="$1"
NOEXPR="$2"
YESWORD="$3"
NOWORD="$4"
if [ -z "$YESWORD" ]; then
	YESWORD="yes"
	NOWORD="no"
fi

YELLOW='\033[33m'
YELLOW_B='\033[33;1m'
RESET='\033[m'

exists() {
	command -v "$1" >/dev/null
}

inf() {
	printf "$YELLOW_B%s$RESET\n" "$@"
}

die() {
	ret=$?
	printf "$RESET"
	exit $ret
}

confirm() {
	message=$*

	while true; do
		printf "$YELLOW"
		read -rp "${message} (${YESWORD} / ${NOWORD})? " yn
		printf "$RESET"
		if [[ "$yn" =~ $YESEXPR ]]; then return 0; fi
		if [[ "$yn" =~ $NOEXPR ]]; then return 1; fi
	done
}
