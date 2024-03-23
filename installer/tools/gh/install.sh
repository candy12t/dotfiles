#! /bin/bash

#
# gh installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://github.com/cli/cli/releases"
prefix="/usr/local"
version="2.32.1"

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
  tar -xzf "${tarball_path}" -C "${prefix}/gh" --strip-components=1 && \
    ln -s "${prefix}/gh/bin/gh" "${prefix}/bin/gh" && \
    for f in `/bin/ls -1 "${prefix}/gh/share/man/man1"`; do ln -s "${prefix}/gh/share/man/man1/${f}" "${prefix}/share/man/man1/${f}"; done || err "Failed install."
  echo "Installed!!"
}

init() {
  mkdir -p "${sources_path}" "${prefix}/gh"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "${version}" "gh_2.32.1_macOS_amd64.zip"    ;;
    "Linux x86_64")  install "${version}" "gh_2.32.1_linux_amd64.tar.gz" ;;
    *)               echo "Sorry! Not supported architectures." ;;
  esac
}

init && main "$@" && exit 0;
