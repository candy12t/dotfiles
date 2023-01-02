#! /bin/bash

#
# goenv installer
#

set -eu

GOENV_DIR="$HOME/.goenv"

if [ ! -d "${GOENV_DIR}" ]; then
  git clone https://github.com/syndbg/goenv.git "${GOENV_DIR}"
fi

exit 0;
