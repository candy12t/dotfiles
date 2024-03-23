#! /bin/bash

#
# dog installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://github.com/ogham/dog/releases"
prefix="/usr/local"
version="0.1.0"

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
  curl -fsSL "${archive_url}" -o "${tarball_path}" || err "Failed download archive."

  echo "Installing..."
  tar -xzf "${tarball_path}" -C "${prefix}/dog" && \
    ln -s "${prefix}/dog/bin/dog" "${prefix}/bin/dog" && \
    ln -s "${prefix}/dog/man/dog.1" "${prefix}/share/man/man1/dog.1" || err "Failed install."
  echo "Installed!!"
}

init() {
  mkdir -p "${sources_path}" "${prefix}/dog"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "${version}" "dog-v${version}-x86_64-apple-darwin.zip"      ;;
    "Linux x86_64")  install "${version}" "dog-v${version}-x86_64-unknown-linux-gnu.zip" ;;
    *)               echo "Sorry! Not supported architectures." ;;
  esac
}

init && main "$@" && exit 0;
