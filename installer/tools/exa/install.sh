#! /bin/bash

#
# exa installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://github.com/ogham/exa/releases"
prefix="/usr/local"
version="0.10.1"

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
  exit 1
}

install() {
  local version="$1"
  local tarball="$2"

  local tarball_path="${sources_path}/${tarball}"
  local archive_url="${release_url}/download/v${version}/${tarball}"

  echo "Downloading..."
  wget -q "${archive_url}" -O "${tarball_path}" || err "Failed download archive."

  echo "Installing..."
  tar -xzf "${tarball_path}" -C "${prefix}/exa" && \
    ln -s "${prefix}/exa/bin/exa" "${prefix}/bin/exa" && \
    ln -s "${prefix}/exa/man/exa.1" "${prefix}/share/man/man1/exa.1" || err "Failed install."
  echo "Installed!!"
}

init() {
  mkdir -p "${sources_path}" "${prefix}/exa"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "${version}" "exa-macos-x86_64-v${version}.zip" ;;
    "Linux x86_64")  install "${version}" "exa-linux-x86_64-v${version}.zip" ;;
    *)               echo "Sorry! Not supported architectures." ;;
  esac
}

init && main "$@" && exit 0;
