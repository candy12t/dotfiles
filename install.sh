#! /bin/bash

set -eu
set -o pipefail

readonly DOTFILES_PATH="${HOME}/dotfiles"
readonly DOTFILES_REPO="https://github.com/candy12t/dotfiles.git"
readonly DOTFILES_BRANCH="master"

download_or_update_repository() {
  if [ -d "${DOTFILES_PATH}" ]; then
    echo "Updating dotfiles..."
    update_repository
  elif [ ! -d "${DOTFILES_PATH}" ]; then
    echo "Downloading dotfiles..."
    download_repository
  fi
}

update_repository() {
  git --git-dir="${DOTFILES_PATH}/.git" pull origin master
}

download_repository() {
  git clone "${DOTFILES_REPO}" --branch "${DOTFILES_BRANCH}" "${DOTFILES_PATH}"
}

link_rc() {
  echo "link rc..."

  mkdir -p "${HOME}/.config"
  mkdir -p "${HOME}/.config/git"

  ln -sf "${DOTFILES_PATH}/config/nvim" "${HOME}/.config/nvim"
  ln -sf "${DOTFILES_PATH}/config/gitignore" "${HOME}/.config/git/ignore"
  ln -sf "${DOTFILES_PATH}/config/starship.toml" "${HOME}/.config/starship.toml"

  ln -sf "${DOTFILES_PATH}/config/gitconfig" "${HOME}/.gitconfig"
  ln -sf "${DOTFILES_PATH}/config/tmux.conf" "${HOME}/.tmux.conf"
  ln -sf "${DOTFILES_PATH}/config/zpreztorc" "${HOME}/.zpreztorc"
  ln -sf "${DOTFILES_PATH}/config/zshrc" "${HOME}/.zshrc"
}

main() {
  download_or_update_repository
  link_rc
  echo "success!"
}

main "$@" && exit 0;
