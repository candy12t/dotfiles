#!/bin/bash
#
# difft(https://github.com/Wilfred/difftastic) installer.

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

RELEASE_URL="https://github.com/Wilfred/difftastic/releases"
PREFIX="/usr/local"

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
  exit 1
}

cleanup() {
  echo "Cleaning up temporary file..."
  [ -n "${TMP}" ] && rm -f "${TMP}"
}

install() {
  local arch="$1"
  local platform="$2"
  local url="${RELEASE_URL}/latest/download/difft-${arch}-${platform}.tar.gz"

  echo "Downloading difft to ${TMP}..."
  curl --fail --silent --location --output "${TMP}" "${url}" \
    || err "Failed download archive."

  echo "Installing difft..."
  sudo tar -xzf "${TMP}" -C "${PREFIX}/difft" \
    && sudo ln -sfn "${PREFIX}/difft/difft" "${PREFIX}/bin/difft" \
    && echo "Installed!!" \
    || err "Failed install."
}

main() {
  sudo mkdir -p "${PREFIX}/difft"

  local arch="$(uname -sm)"
  case "${arch}" in
    "Darwin x86_64") install "x86_64"  "apple-darwin" ;;
    "Darwin arm64")  install "aarch64" "apple-darwin" ;;
    "Linux x86_64")  install "x86_64"  "unknown-linux-gnu" ;;
    "Linux arm64")   install "aarch64" "unknown-linux-gnu" ;;
    *)               err "Sorry! Not supported architectures." ;;
  esac
}

trap cleanup EXIT

TMP="$(mktemp)"
echo "make temporary file: ${TMP}"

main "$@" && exit 0;
