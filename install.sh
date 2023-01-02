#! /bin/bash

set -eu

script_home="$(cd $(dirname $0); pwd)"
cd "${script_home}"
exe_time=$(date '+%Y%m%d%H%M%S')

main() {
  for f in $(/bin/ls "${script_home}/config"); do
    if [ -d "${script_home}/config/${f}" ]; then
      mkdir -p "$HOME/.${f}"
      for files in $(/bin/ls "${script_home}/config/${f}"); do
        __backup_dotfiles ".${f}/${files}"
        __create_symbolic_link "${f}/${files}"
      done
      continue
    fi
    __backup_dotfiles ".${f}"
    __create_symbolic_link "${f}"
  done
}

__backup_dotfiles() {
  local f="$1"
  if [ -e "${HOME}/${f}" ]; then
    mv "${HOME}/${f}" "$HOME/${f}.${exe_time}_backup" && echo "backuped ${HOME}/${f}"
  fi
}

__create_symbolic_link() {
  local f="$1"
  ln -s "${script_home}/config/${f}" "${HOME}/.${f}" && echo "created symbolic link: ${f}"
}

main && exit 0;
