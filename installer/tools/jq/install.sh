#! /bin/bash

#
# jq installer
#

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

release_url="https://github.com/jqlang/jq/releases"
prefix="/usr/local"
version="1.6"

install() {
  local version="$1"
  local bin="$2"

  sudo curl -fsSL "${release_url}/download/jq-${version}/${bin}" -o "${prefix}/bin/jq"
  sudo chmod +x "${prefix}/bin/jq"
}

main() {
  local arch=$(uname -sm)
  case "${arch}" in
    "Darwin x86_64") install "${version}" "jq-osx-amd64" ;;
    "Linux x86_64")  install "${version}" "jq-linux64"   ;;
    *)               echo "Sorry! Not supported architectures." ;;
  esac
}

main "$@" && exit 0;
