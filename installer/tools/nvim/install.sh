#! /bin/bash

#
# nvim installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://github.com/neovim/neovim/releases"
prefix="/usr/local"
version="0.9.1"

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
  tar -xzf "${tarball_path}" -C "${prefix}/nvim" --strip-components=1 && \
    ln -s "${prefix}/nvim/bin/nvim" "${prefix}/bin/nvim" && \
    ln -s "${prefix}/nvim/share/man/man1/nvim.1" "${prefix}/share/man/man1/nvim.1" || err "Failed install."
  echo "Installed!!"
}

init() {
  mkdir -p "${sources_path}" "${prefix}/nvim"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    Darwin*64) install "${version}" "nvim-macos.tar.gz"   ;;
    Linux*64)  install "${version}" "nvim-linux64.tar.gz" ;;
    *)         echo "Sorry! Not supported architectures." ;;
  esac
}

init && main "$@" && exit 0;
