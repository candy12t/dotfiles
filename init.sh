#! /bin/bash

set -eu

DOTFILES_PATH="${HOME}/dotfiles"
DOTFILES_REPO="https://github.com/candy12t/dotfiles.git"

ESC="\033"
RESET="${ESC}[0m"
RED="${ESC}[31m"
CYAN="${ESC}[36m"
DEFAULT="${ESC}[39m"

function log_info() {
  printf "${DEFAULT}[INFO] $1${DEFAULT}\n"
}

function log_success() {
  printf "${CYAN}[SUCCESS] $1${RESET}\n"
}

function log_error() {
  printf "${RED}[ERROR] $1${RESET}\n"
}

function __clone_or_update_repository() {
  local git_dir="${DOTFILES_PATH}/.git"

  if [ -d "${DOTFILES_PATH}" ]; then
    log_info "Updating repository..."

    git --git-dir="${git_dir}" pull origin master && log_success "Updated repository" || {
      log_error "Failed Update repository"
      exit 1
    }
  elif [ ! -d "${DOTFILES_PATH}" ]; then
    log_info "Cloning repository..."

    git clone "${DOTFILES_REPO}" "${DOTFILES_PATH}" && log_success "Cloned repository" || {
      log_error "Failed Clone repository"
      exit 1
    }
  fi
}

function __install() {
  log_info "Installing..."
  "${DOTFILES_PATH}/install.sh" && log_success "Installed"
}

function main() {
  __clone_or_update_repository
  __install
}

main

exit 0;
