#!/bin/bash
# Utility to download and extract Authy from Snap.
# Git is required for version management.

SNAPID="H8ZpNgIoPyvmkgxOWw5MSzsXK1wRZiHn"
SNAPREV="9"

VERSION=""
OLD_VERSION=""

TEMPFILE=$(mktemp -p /tmp authy.XXXXXX)
TEMPFOLDER=$(mktemp -d -p /tmp authy.XXXXXX)

check_version () {
  VERSION=$(curl -s "https://api.snapcraft.io/v2/snaps/info/authy?fields=version" -H 'Snap-Device-Series: 16' | jq -r '.["channel-map"][0]["version"]')
  if [ -z $VERSION ]
  then
    echo Couldn\'t determine upstream version! Exitting.
    exit 1
  fi
  OLD_VERSION=$([ -d $HOME/.authy/ ] && cd $HOME/.authy && git describe --tags)

  if dpkg --compare-versions $VERSION le $OLD_VERSION 2>/dev/null
  then
    echo Looks like Authy is already updated. Exitting.
    exit 0
  fi
}

download () {
  echo Downloading Authy v$VERSION...
  wget -q -O $TEMPFILE --show-progress "https://api.snapcraft.io/api/v1/snaps/download/${SNAPID}_${SNAPREV}.snap" 
}

extract () {
  echo Extracting...
  unsquashfs -q -f -d $TEMPFOLDER $TEMPFILE
}

install () {
  echo Installing...

  sed -i 's|${SNAP}/meta/gui/icon.png|authy|g' "${TEMPFOLDER:?}/meta/gui/authy.desktop"

  echo Enter your password to continue:
  sudo -k
  
  # Create shortcut and icon
  sudo mv -u "${TEMPFOLDER:?}/meta/gui/authy.desktop" "/usr/share/applications/authy.desktop"
  sudo mv -u "${TEMPFOLDER:?}/meta/gui/icon.png" "/usr/share/pixmaps/authy.png"

  # Remove unecessary files
  rm -rf ${TEMPFOLDER:?}/{data-dir,gnome-platform,lib,meta,scripts,usr,*.sh}
  
  # Move folder to install location
  rsync -a "${TEMPFOLDER:?}/" $HOME/.authy
  cd $HOME/.authy || exit
  git init
  git checkout -b main
  git add .
  git commit -am $VERSION
  git tag $VERSION
  # echo $VERSION > "$HOME/.authy/.version"

  # Symlink binary
  sudo ln -fs "$HOME/.authy/authy" "/usr/bin/"
}

post_install () {
  if [ -z "$OLD_VERSION" ]
  then
    echo Successfully installed Authy v$VERSION!
  else
    echo Successfully updated Authy from v$OLD_VERSION to v$VERSION!
  fi
}

check_version
download
extract
install
post_install

