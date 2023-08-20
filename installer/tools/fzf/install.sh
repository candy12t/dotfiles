#! /bin/bash

#
# fzf installer
#

set -eu

FZF_DIR="$HOME/.fzf"

git clone --depth 1 https://github.com/junegunn/fzf.git "${FZF_DIR}"
"${FZF_DIR}/install"

exit 0;
