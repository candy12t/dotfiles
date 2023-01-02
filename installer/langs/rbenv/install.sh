#! /bin/bash

#
# rbenv installer
#

set -eu

RBENV_DIR="$HOME/.rbenv"
RBENV_PLUGIN_DIR="${RBENV_DIR}/plugins"

if [ ! -d "${RBENV_DIR}" ]; then
  git clone https://github.com/rbenv/rbenv.git "${RBENV_DIR}"
  mkdir -p "${RBENV_PLUGIN_DIR}"
  git clone https://github.com/rbenv/ruby-build.git "${RBENV_PLUGIN_DIR}/ruby-build"
fi

exit 0;
