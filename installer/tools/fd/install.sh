#! /bin/bash

#
# fd installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://github.com/sharkdp/fd/releases"
prefix="/usr/local"
version="8.7.0"

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
  tar -xzf "${tarball_path}" -C "${prefix}/fd" --strip-components=1 && \
    ln -s "${prefix}/fd/fd" "${prefix}/bin/fd" && \
    ln -s "${prefix}/fd/fd.1" "${prefix}/share/man/man1/fd.1" || err "Failed install."
  echo "Installed!!"
}

init() {
  mkdir -p "${sources_path}" "${prefix}/fd"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "${version}" "fd-v${version}-x86_64-apple-darwin.tar.gz"      ;;
    "Linux x86_64")  install "${version}" "fd-v${version}-x86_64-unknown-linux-musl.tar.gz" ;;
    *)               echo "Sorry! Not supported architectures." ;;
  esac
}

init && main "$@" && exit 0;
