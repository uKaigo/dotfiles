#!/bin/sh
set -eu

#region logging setup
if [ "${MISE_DEBUG-}" = "true" ] || [ "${MISE_DEBUG-}" = "1" ]; then
	debug() {
		echo "$@" >&2
	}
else
	debug() {
		:
	}
fi

if [ "${MISE_QUIET-}" = "1" ] || [ "${MISE_QUIET-}" = "true" ]; then
	info() {
		:
	}
else
	info() {
		echo "$@" >&2
	}
fi

error() {
	echo "$@" >&2
	exit 1
}
#endregion

#region environment setup
get_os() {
	os="$(uname -s)"
	if [ "$os" = Darwin ]; then
		echo "macos"
	elif [ "$os" = Linux ]; then
		echo "linux"
	else
		error "unsupported OS: $os"
	fi
}

get_arch() {
	arch="$(uname -m)"
	if [ "$arch" = x86_64 ]; then
		echo "x64"
	elif [ "$arch" = aarch64 ] || [ "$arch" = arm64 ]; then
		echo "arm64"
	else
		error "unsupported architecture: $arch"
	fi
}

shasum_bin() {
	if command -v shasum >/dev/null 2>&1; then
		echo "shasum"
	elif command -v sha256sum >/dev/null 2>&1; then
		echo "sha256sum"
	else
		error "mise install requires shasum or sha256sum but neither is installed. Aborting."
	fi
}

get_checksum() {
	os="$(get_os)"
	arch="$(get_arch)"

	checksum_linux_x86_64="9e2b02fabff6186951d99b0feff63793cfdda4c69df4d0fc89b2f129f76bfbeb  ./mise-v2024.1.22-linux-x64.tar.gz"
	checksum_linux_arm64="56bb4c4a53b9e147e9d9760d9258b143948b26bd90de655f116aaa72f6191a41  ./mise-v2024.1.22-linux-arm64.tar.gz"
	checksum_macos_x86_64="04a2be1fcd941ce4f7bcc0f9da93f06dbec0ce3c70f61a1248055dbc726c9000  ./mise-v2024.1.22-macos-x64.tar.gz"
	checksum_macos_arm64="54ef7fc7e78504d67c936aa9c55389b8718250fd9ea98acd9a4647bd55d625e3  ./mise-v2024.1.22-macos-arm64.tar.gz"

	if [ "$os" = "linux" ] && [ "$arch" = "x64" ]; then
		echo "$checksum_linux_x86_64"
	elif [ "$os" = "linux" ] && [ "$arch" = "arm64" ]; then
		echo "$checksum_linux_arm64"
	elif [ "$os" = "macos" ] && [ "$arch" = "x64" ]; then
		echo "$checksum_macos_x86_64"
	elif [ "$os" = "macos" ] && [ "$arch" = "arm64" ]; then
		echo "$checksum_macos_arm64"
	else
		warn "no checksum for $os-$arch"
	fi
}

#endregion

download_file() {
	url="$1"
	filename="$(basename "$url")"
	cache_dir="$(mktemp -d)"
	file="$cache_dir/$filename"

	info "mise: installing mise..."

	if command -v curl >/dev/null 2>&1; then
		debug ">" curl -fLlSso "$file" "$url"
		curl -fLlSso "$file" "$url"
	else
		if command -v wget >/dev/null 2>&1; then
			debug ">" wget -qO "$file" "$url"
			stderr=$(mktemp)
			wget -O "$file" "$url" >"$stderr" 2>&1 || error "wget failed: $(cat "$stderr")"
		else
			error "mise standalone install requires curl or wget but neither is installed. Aborting."
		fi
	fi

	echo "$file"
}

install_mise() {
	# download the tarball
	version="v2024.1.22"
	os="$(get_os)"
	arch="$(get_arch)"
	install_path="${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}"
	install_dir="$(dirname "$install_path")"
	tarball_url="https://github.com/jdx/mise/releases/download/${version}/mise-${version}-${os}-${arch}.tar.gz"

	cache_file=$(download_file "$tarball_url")
	debug "mise-setup: tarball=$cache_file"

	debug "validating checksum"
	cd "$(dirname "$cache_file")" && get_checksum | "$(shasum_bin)" -c >/dev/null

	# extract tarball
	mkdir -p "$install_dir"
	rm -rf "$install_path"
	cd "$(mktemp -d)"
	tar -xzf "$cache_file"
	mv mise/bin/mise "$install_path"
	info "mise: installed successfully to $install_path"
}

after_finish_help() {
	case "${SHELL:-}" in
	*/zsh)
		info "mise: run the following to activate mise in your shell:"
		info "echo \"eval \\\"\\\$($install_path activate zsh)\\\"\" >> \"${ZDOTDIR-$HOME}/.zshrc\""
		info ""
		info "mise: this must be run in order to use mise in the terminal"
		info "mise: run \`mise doctor\` to verify this is setup correctly"
		;;
	*/bash)
		info "mise: run the following to activate mise in your shell:"
		info "echo \"eval \\\"\\\$($install_path activate bash)\\\"\" >> ~/.bashrc"
		info ""
		info "mise: this must be run in order to use mise in the terminal"
		info "mise: run \`mise doctor\` to verify this is setup correctly"
		;;
	*/fish)
		info "mise: run the following to activate mise in your shell:"
		info "echo \"$install_path activate fish | source\" >> ~/.config/fish/config.fish"
		info ""
		info "mise: this must be run in order to use mise in the terminal"
		info "mise: run \`mise doctor\` to verify this is setup correctly"
		;;
	*)
		info "mise: run \`$install_path --help\` to get started"
		;;
	esac
}

install_mise
