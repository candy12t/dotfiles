#! /bin/bash

#
# rust installer
#

set -eu

if [ ! -d "$HOME/.cargo" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

exit 0;
