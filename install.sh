#! /bin/bash

set -eu
set -o pipefail

readonly DOTFILES_PATH="$HOME/dotfiles"
readonly DOTFILES_REPO="https://github.com/candy12t/dotfiles.git"
readonly DOTFILES_BRANCH="master"

download_repository() {
  echo "Downloading dotfiles..."
  if [ -d "$DOTFILES_PATH" ]; then
    echo "dotfiles already exists." && return
  fi
  git clone "$DOTFILES_REPO" --branch "$DOTFILES_BRANCH" "$DOTFILES_PATH"
}

link_rc() {
  echo "link rc..."

  mkdir -p "$HOME/.config" "$HOME/.config/tmux" "$HOME/.claude"

  # bat
  ln -sfn "$DOTFILES_PATH/config/bat" "$HOME/.config/bat"
  # efm-langserver
  ln -sfn "$DOTFILES_PATH/config/efm-langserver" "$HOME/.config/efm-langserver"
  # git
  ln -sfn "$DOTFILES_PATH/config/git" "$HOME/.config/git"
  # nvim
  ln -sfn "$DOTFILES_PATH/config/nvim" "$HOME/.config/nvim"
  # zsh
  ln -sfn "$DOTFILES_PATH/config/zsh/zpreztorc" "$HOME/.zpreztorc"
  ln -sfn "$DOTFILES_PATH/config/zsh/zshrc"     "$HOME/.zshrc"
  # starship
  ln -sfn "$DOTFILES_PATH/config/starship.toml" "$HOME/.config/starship.toml"
  # tmux
  ln -sfn "$DOTFILES_PATH/config/tmux.conf" "$HOME/.config/tmux/tmux.conf"
  # claude
  ln -sfn "$DOTFILES_PATH/config/claude/settings.json" "$HOME/.claude/settings.json"
  # eza
  ln -sfn "$DOTFILES_PATH/config/eza" "$HOME/.config/eza"
  # yazi
  ln -sfn "$DOTFILES_PATH/config/yazi" "$HOME/.config/yazi"
}

main() {
  download_repository && \
    link_rc && \
    echo "Success!! Then install any tools and languages you want."
}

main "$@" && exit 0;
