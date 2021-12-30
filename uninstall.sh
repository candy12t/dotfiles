#! /bin/bash

set -eu

function main() {
  for f in .??*; do
    [[ "${f}" == ".git" ]] && continue
    [[ "${f}" == ".DS_Store" ]] && continue
    [[ "${f}" == ".gitignore" ]] && continue

    __unlink "${f}"
  done
}

function __unlink() {
  local f="$1"
  [[ -e "${HOME}/${f}" ]] && unlink "${HOME}/${f}" && echo "unlink ${HOME}/${f}" || echo "no exist ${HOME}/${f}"
}

main

exit 0;
