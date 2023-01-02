#! /bin/bash

#
# pyenv installer
#

set -eu

PYENV_DIR="$HOME/.pyenv"

if [ ! -d "${PYENV_DIR}" ]; then
  git clone https://github.com/pyenv/pyenv.git "${PYENV_DIR}"
fi

exit 0;
