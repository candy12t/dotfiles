#! /bin/bash

set -eu

script_home="$(cd $(dirname $0); pwd)"
cd "${script_home}"

function main() {
  for f in .??*; do
    [[ "${f}" == ".git" ]] && continue
    [[ "${f}" == ".DS_Store" ]] && continue
    [[ "${f}" == ".gitignore" ]] && continue

    __backup_dotfiles "${f}"
    __create_symbolic_link "${f}"
  done
}

function __backup_dotfiles() {
  local f="$1"
  [[ -e "${HOME}/${f}" ]] && mv "${HOME}/${f}" "${HOME}/${f}.backup"
}

function __create_symbolic_link() {
  local f="$1"
  ln -s "${script_home}/${f}" "${HOME}/${f}" && echo "created symbolic link: ${f}"
}

main && echo "installation success!!"

exit 0;
