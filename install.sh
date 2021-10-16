#! /bin/bash

set -eu

script_home="$(cd $(dirname $0); pwd)"
cd "${script_home}"

dotfiles=(".starship" ".gitconfig" ".gitignore" ".tmux.conf" ".vimrc" ".zpreztorc" ".zshrc" ".vim/sonictemplate")

function split_path() {
  echo $(echo "$1" | tr "/" " ")
}

function parent_dirctory() {
  local path_array parent_path
  path_array=$(split_path "$1")
  if [[ $(echo ${path_array} | wc -w) -gt 1 ]]; then
    parent_path=$(echo ${path_array} | awk '{print $1}')
    echo "${parent_path}"
  fi
}

function make_dirctory() {
  local parent_path
  parent_path="$(parent_dirctory "$1")"
  if [[ ! -e "${HOME}/${parent_path}" ]]; then
    mkdir "${HOME}/${parent_path}" && echo "create dirctory: ${parent_path}"
  fi
}


function create_symbolic_link() {
  for f in `echo "$*"`; do
    [[ -e "${HOME}/${f}" ]] && mv "${HOME}/${f}" "${HOME}/${f}.backup"
    make_dirctory "${f}"
    ln -s "$(cd $(dirname $0); pwd)/${f}" "${HOME}/${f}" && echo "created symbolic link: ${f}"
  done
}

create_symbolic_link "${dotfiles[@]}" && echo "installation success!!"

exit 0;
