#!/bin/bash
#
# nvim build script

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

build_type="Release"
sources_path="$HOME/sources"
repository="https://github.com/neovim/neovim"

os=$(uname -s)
if [ "$os" = "Darwin" ]; then
  brew install ninja cmake gettext curl
elif [[ "os" = "Linux" ]]; then
  if [ -e "/etc/debian_version" ]; then
    sudo apt-get install -y ninja-build gettext cmake unzip curl
  fi
else
  echo "no support os or distribution." >&2
  exit 1
fi

git clone "$repository" "$sources_path/neovim"
cd "$sources_path/neovim"

make CMAKE_BUILD_TYPE=$build_type
sudo make install

exit 0;
