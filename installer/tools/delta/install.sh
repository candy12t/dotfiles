#! /bin/bash

#
# delta installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

sources_path="$HOME/sources"
release_url="https://github.com/dandavison/delta/releases"
prefix="/usr/local"
version="0.16.5"

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
  exit 1
}

install() {
  local version="$1"
  local tarball="$2"

  local tarball_path="${sources_path}/${tarball}"
  local archive_url="${release_url}/download/${version}/${tarball}"

  echo "Downloading..."
  wget -q "${archive_url}" -O "${tarball_path}" || err "Failed download archive."

  echo "Installing..."
  tar -xzf "${tarball_path}" -C "${prefix}/delta" --strip-components=1 && \
    ln -s "${prefix}/delta/delta" "${prefix}/bin/delta" || err "Failed install."
  echo "Installed!!"
}

init() {
  mkdir -p "${sources_path}" "${prefix}/delta"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "${version}" "delta-${version}-x86_64-apple-darwin.tar.gz"      ;;
    "Linux x86_64")  install "${version}" "delta-${version}-x86_64-unknown-linux-musl.tar.gz" ;;
    *)               echo "Sorry! Not supported architectures." ;;
  esac
}

init && main "$@" && exit 0;
