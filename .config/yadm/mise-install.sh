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
	musl=""
	if type ldd >/dev/null 2>/dev/null; then
		libc=$(ldd /bin/ls | grep 'musl' | head -1 | cut -d ' ' -f1)
		if [ -z "$libc" ]; then
			musl="-musl"
		fi
	fi
	arch="$(uname -m)"
	if [ "$arch" = x86_64 ]; then
		echo "x64$musl"
	elif [ "$arch" = aarch64 ] || [ "$arch" = arm64 ]; then
		echo "arm64$musl"
	elif [ "$arch" = armv6l ]; then
		echo "armv6$musl"
	elif [ "$arch" = armv7l ]; then
		echo "armv7$musl"
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

	checksum_linux_x86_64="4630aa9ac85b095f875284a6ccfbb7c90b4546ef988e69f3c0af8c158bbee936  ./mise-v2024.2.9-linux-x64.tar.gz"
	checksum_linux_x86_64_musl="f9a8e051ceb9378b0ae2bc816bbc4e8ef95b67bfbe35ce023d71f561e3a2311e  ./mise-v2024.2.9-linux-x64-musl.tar.gz"
	checksum_linux_arm64="c27f86a1030448c10702c5a44e00fd10d82f6bb6696923bff36d84391b686aab  ./mise-v2024.2.9-linux-arm64.tar.gz"
	checksum_linux_arm64_musl="ad13f902e3672bd06bfb6f7593380901a43d3bc6b95f02df24b1b5ca80fd2e7c  ./mise-v2024.2.9-linux-arm64-musl.tar.gz"
	checksum_linux_armv6="38ea5e00ff868a5324f334a42a067a467ed83e5610616f790da8d73a87e725a9  ./mise-v2024.2.9-linux-armv6.tar.gz"
	checksum_linux_armv6_musl="ef2a82889b9b0248772e13eee11a00485257c4b36f0b7d08e7b3220f0f4549fd  ./mise-v2024.2.9-linux-armv6-musl.tar.gz"
	checksum_linux_armv7="f5551ae704d70e21663ba6903d2aaa353a54e81d6566db66c06c473cb1cb1503  ./mise-v2024.2.9-linux-armv7.tar.gz"
	checksum_linux_armv7_musl="37cb6793e438c4ff50fa727c97511ac83d3845596adf6d7153bfbb2fec078769  ./mise-v2024.2.9-linux-armv7-musl.tar.gz"
	checksum_macos_x86_64="126faf0a4b1dd7ec0b75ec93ee69dcc75d2499910c6c9253055d0217a060e8ca  ./mise-v2024.2.9-macos-x64.tar.gz"
	checksum_macos_arm64="c2ea89a643d89338d1fc9572ad906e950ee6dab55de9dc01a74c8c61c8b95bc7  ./mise-v2024.2.9-macos-arm64.tar.gz"

	if [ "$os" = "linux" ]; then
		if [ "$arch" = "x64" ]; then
			echo "$checksum_linux_x86_64"
		elif [ "$arch" = "x64-musl" ]; then
			echo "$checksum_linux_x86_64_musl"
		elif [ "$arch" = "arm64" ]; then
			echo "$checksum_linux_arm64"
		elif [ "$arch" = "arm64-musl" ]; then
			echo "$checksum_linux_arm64_musl"
		elif [ "$arch" = "armv6" ]; then
			echo "$checksum_linux_armv6"
		elif [ "$arch" = "armv6-musl" ]; then
			echo "$checksum_linux_armv6_musl"
		elif [ "$arch" = "armv7" ]; then
			echo "$checksum_linux_armv7"
		elif [ "$arch" = "armv7-musl" ]; then
			echo "$checksum_linux_armv7_musl"
		else
			warn "no checksum for $os-$arch"
		fi
	elif [ "$os" = "macos" ]; then
		if [ "$arch" = "x64" ]; then
			echo "$checksum_macos_x86_64"
		elif [ "$arch" = "arm64" ]; then
			echo "$checksum_macos_arm64"
		else
			warn "no checksum for $os-$arch"
		fi
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
		debug ">" curl -#fLo "$file" "$url"
		curl -#fLo "$file" "$url"
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
	version="v2024.2.9"
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
after_finish_help
