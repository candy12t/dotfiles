#! /bin/bash

#
# bat installer
#

set -eu

SRC_DIR="$HOME/local/src"
BIN_DIR="$HOME/local/bin"

release_url="https://github.com/sharkdp/bat/releases"
latest_release_url=$(curl -sIL "${release_url}/latest" -w %{url_effective} -o /dev/null)
latest_release=$(echo "${latest_release_url}" | tr '/' ' ' | awk '{print $NF}')

arch=$(uname -sm)

install() {
  local archive="bat-${latest_release}-x86_64-${1}"
  local tarball="${archive}.tar.gz"
  echo "Installing bat..."

  mkdir -p "${SRC_DIR}" "${BIN_DIR}"

  cd "${SRC_DIR}"
  curl -fsSL "${release_url}/download/${latest_release}/${tarball}" | tar -zxf -
  cd "${archive}"
  cp bat "${BIN_DIR}/bat"

  echo "Installation complete!"
}

case "${arch}" in
  Darwin\ *64)
    install "apple-darwin"
    ;;
  Linux\ *64)
    install "unknown-linux-gnu"
    ;;
  *)
    echo "Sorry! Not supported architectures."
    ;;
esac

exit 0;
