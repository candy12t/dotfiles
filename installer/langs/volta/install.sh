#! /bin/bash

#
# volta installer
#

set -eu

if [ ! -d "$HOME/.volta" ]; then
  curl https://get.volta.sh | bash -s -- --skip-setup
fi

exit 0;
