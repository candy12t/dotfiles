#! /bin/bash

#
# OpenJDK 8 installer
#

set -eu

JDK_DIR="$HOME/.jdk"

release_url="https://github.com/adoptium/temurin8-binaries/releases"
latest_release_url=$(curl -sIL "${release_url}/latest" -w %{url_effective} -o /dev/null)
latest_release=$(echo "${latest_release_url}" | tr '/' ' ' | awk '{print $NF}')
latest_release_hash=$(echo "${latest_release}" | sed -e 's/jdk\(.*\)-\(.*\)/\1\2/')

arch=$(uname -sm)

install() {
  local tarball="OpenJDK8U-jdk_x64_${1}_hotspot_${latest_release_hash}.tar.gz"

  if [ ! -d "${JDK_DIR}" ]; then
    mkdir "${JDK_DIR}"
    curl -fsSL "${release_url}/download/${latest_release}/${tarball}" -o "${JDK_DIR}/${tarball}"
    tar -xzf "${JDK_DIR}/${tarball}" -C "${JDK_DIR}" --strip-components=1
  fi
}

case "${arch}" in
  Darwin\ *64)
    install "mac"
    ;;
  Linux\ *64)
    install "linux"
    ;;
  *)
    echo "Sorry! Not supported architectures."
    ;;
esac

exit 0;
