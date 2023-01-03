#! /bin/bash

set -eu

DOTFILES_PATH="${HOME}/dotfiles"
DOTFILES_REPO="https://github.com/candy12t/dotfiles.git"
DOTFILES_BRANCH="master"

arch=$(uname -sm)

exe_time=$(date '+%Y%m%d%H%M%S')

dotfiles::download_or_update_repository() {
  if [ -d "${DOTFILES_PATH}" ]; then
    echo "Updating dotfiles..."
    dotfiles::update_repository
  elif [ ! -d "${DOTFILES_PATH}" ]; then
    echo "Downloading dotfiles..."
    dotfiles::download_repository
  fi
}

dotfiles::update_repository() {
  git --git-dir="${DOTFILES_PATH}/.git" pull origin master
}

dotfiles::download_repository() {
  git clone "${DOTFILES_REPO}" --branch "${DOTFILES_BRANCH}" "${DOTFILES_PATH}"
}

dotfiles::setting_macos() {
  echo "Setting os..."
  dotfiles::install_homebrew
}

dotfiles::install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

dotfiles::install_langs() {
  echo "Installing languages..."
  for f in $(/bin/ls "${DOTFILES_PATH}/installer/langs"); do
    echo "Installing ${f}..."
    "${DOTFILES_PATH}/installer/langs/${f}/install.sh"
  done
}

dotfiles::install_cli_tools() {
  echo "Installing CLI tools..."
  for f in $(/bin/ls "${DOTFILES_PATH}/installer/tools"); do
    echo "Installing ${f}..."
    "${DOTFILES_PATH}/installer/tools/${f}/install.sh"
  done
}

dotfiles::setting_rc() {
  echo "Setting rc..."
  for f in $(/bin/ls "${DOTFILES_PATH}/config"); do
    if [ -d "${DOTFILES_PATH}/config/${f}" ]; then
      mkdir -p "$HOME/.${f}"
      for files in $(/bin/ls "${DOTFILES_PATH}/config/${f}"); do
        dotfiles::backup_config "${f}/${files}"
        dotfiles::setting_config "${f}/${files}"
      done
      continue
    fi
    dotfiles::backup_config "${f}"
    dotfiles::setting_config "${f}"
  done
}

dotfiles::backup_config() {
  local f="$1"
  local dotfile=".$1"
  if [ -e "$HOME/${dotfile}" ]; then
    mv "$HOME/${dotfile}" "$HOME/${dotfile}.${exe_time}_backup" && echo "backuped $HOME/${dotfile}"
  fi
}

dotfiles::setting_config() {
  local f="$1"
  ln -s "${DOTFILES_PATH}/config/${f}" "${HOME}/.${f}" && echo "created symbolic link: ${f}"
}

dotfiles::setting_shell() {
  echo "Setting shell..."
  [[ $(echo "$SHELL") =~ "zsh" ]] && return

  if [ $(which zsh) >/dev/null 2>&1 ]; then
    dotfiles::install_zsh
  fi

  chsh -s $(which zsh)
  exec $(which zsh) -l
}

dotfiles::install_zsh() {
  echo "Installing zsh..."
  "${DOTFILES_PATH}/installer/tools/zsh/install.sh"
}

dotfiles::install_for_mac() {
  dotfiles::download_or_update_repository
  dotfiles::setting_macos
  dotfiles::install_langs
  dotfiles::install_cli_tools
  dotfiles::setting_rc
  dotfiles::setting_shell
}

dotfiles::install_for_linux() {
  dotfiles::download_or_update_repository
  dotfiles::install_langs
  dotfiles::install_cli_tools
  dotfiles::setting_rc
  dotfiles::setting_shell
}

dotfiles::main() {
  case "${arch}" in
    Darwin\ *64)
      dotfiles::install_for_mac
      ;;
    Linux\ *64)
      dotfiles::install_for_linux
      ;;
    *)
      echo "Sorry! Not supported architectures."
      ;;
  esac
}

dotfiles::main && exit 0;
