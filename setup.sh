#! /bin/bash

set -eu

script_home="$(cd $(dirname $0); pwd)"
cd "${script_home}"

config=".config"
config_files=("${config}/nvim" "${config}/starship.toml" "${config}/git")
dotfiles=(".gitconfig" ".tmux.conf" ".vimrc" ".zpreztorc" ".zshrc")

function create_symbolic_link () {
  for f in `echo "$*"`; do
    if [ -e "${HOME}/${f}" ]; then
      unlink "${HOME}/${f}"
    fi
    ln -s "$(cd $(dirname $0); pwd)/${f}" "${HOME}/${f}"
    echo "created symbolic link: ${f}"
  done
}

if [ ! -d ${config} ]; then
  mkdir ${config}
fi
create_symbolic_link "${config_files[@]}"
create_symbolic_link "${dotfiles[@]}"
