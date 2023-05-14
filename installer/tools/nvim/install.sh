#! /bin/bash

#
# nvim installer
#

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

release_version="stable"
repo_url="https://github.com/neovim/neovim"
repo_dir="neovim"

prefix="/usr/local"
build_type="Release"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

sudo apt install -y build-essential
sudo apt install -y ninja-build gettext cmake unzip curl libtool-bin

if [ ! -d "${repo_dir}" ]; then
  git clone "${repo_url}" "${repo_dir}"
fi

cd "${repo_dir}" && \
  git checkout "${release_version}" && \
  make CMAKE_BUILD_TYPE="${build_type}" CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=${prefix}"

cd build && \
  cpack -G DEB && \
  sudo dpkg -i nvim-linux64.deb

exit 0;
