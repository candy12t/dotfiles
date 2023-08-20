#! /bin/bash

#
# go installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://go.dev/dl"
prefix="/usr/local"

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
  exit 1
}

install() {
  local tarball="$1"
  local tarball_path="${sources_path}/${tarball}"
  local archive_url="${release_url}/${tarball}"

  echo "Downloading..."
  mkdir -p "${sources_path}"
  wget -q "${archive_url}" -O "${tarball_path}" || err "Failed download archive."

  echo "Installing..."
  rm -rf "${prefix}/go" && tar -xzf "${tarball_path}" -C "${prefix}" || err "Failed install."
  echo "Installed!! Check \`go version\`."
}

main() {
  local version="$1"
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "go${version}.darwin-amd64.tar.gz" ;;
    "Darwin arm64")  install "go${version}.darwin-arm64.tar.gz" ;;
    "Linux x86_64")  install "go${version}.linux-amd64.tar.gz"  ;;
    *)               echo "Sorry! Not supported architectures." ;;
  esac
}

main "$@" && exit 0;
