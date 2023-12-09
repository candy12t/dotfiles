#! /bin/bash

set -eu
set -o pipefail

readonly DOTFILES_PATH="${HOME}/dotfiles"
readonly DOTFILES_REPO="https://github.com/candy12t/dotfiles.git"
readonly DOTFILES_BRANCH="master"

download_repository() {
  echo "Downloading dotfiles..."
  git clone "${DOTFILES_REPO}" --branch "${DOTFILES_BRANCH}" "${DOTFILES_PATH}"
}

link_rc() {
  echo "link rc..."

  mkdir -p "${HOME}/.config"
  mkdir -p "${HOME}/.config/git"
  mkdir -p "${HOME}/.config/tmux"

  ln -sf "${DOTFILES_PATH}/config/nvim" "${HOME}/.config/nvim"

  ln -sf "${DOTFILES_PATH}/config/gitignore" "${HOME}/.config/git/ignore"
  ln -sf "${DOTFILES_PATH}/config/gitconfig" "${HOME}/.config/git/config"
  ln -sf "${DOTFILES_PATH}/config/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
  ln -sf "${DOTFILES_PATH}/config/starship.toml" "${HOME}/.config/starship.toml"

  ln -sf "${DOTFILES_PATH}/config/zpreztorc" "${HOME}/.zpreztorc"
  ln -sf "${DOTFILES_PATH}/config/zshrc" "${HOME}/.zshrc"

  ln -sf "${DOTFILES_PATH}/config/hammerspoon" "${HOME}/.hammerspoon"
}

main() {
  download_repository
  link_rc
  echo "Success!! Then install any tools and languages you want."
}

main "$@" && exit 0;
