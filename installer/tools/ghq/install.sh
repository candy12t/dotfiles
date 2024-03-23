#! /bin/bash

#
# ghq installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://github.com/x-motemen/ghq/releases"
prefix="/usr/local"
version="1.4.2"

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
  tar -xzf "${tarball_path}" -C "${prefix}/ghq" --strip-components=1 && \
    ln -s "${prefix}/ghq/ghq" "${prefix}/bin/ghq" || err "Failed install."
  echo "Installed!!"
}

init() {
  mkdir -p "${sources_path}" "${prefix}/ghq"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "${version}" "ghq_darwin_amd64.zip" ;;
    "Darwin arm64")  install "${version}" "ghq_darwin_arm64.zip" ;;
    "Linux x86_64")  install "${version}" "ghq_linux_amd64.zip"  ;;
    "Linux arm64")   install "${version}" "ghq_linux_arm64.zip"  ;;
    *)               echo "Sorry! Not supported architectures."  ;;
  esac
}

init && main "$@" && exit 0;
