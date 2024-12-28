#! /bin/bash

set -eu
set -o pipefail

readonly DOTFILES_PATH="$HOME/dotfiles"
readonly DOTFILES_REPO="https://github.com/candy12t/dotfiles.git"
readonly DOTFILES_BRANCH="master"

download_repository() {
  echo "Downloading dotfiles..."
  git clone "$DOTFILES_REPO" --branch "$DOTFILES_BRANCH" "$DOTFILES_PATH"
}

link_rc() {
  echo "link rc..."

  mkdir -p "$HOME/.config" \
    "$HOME/.config/tmux"
    # "$HOME/.config/memo" \
    # "$HOME/.config/memo/plugins" \
    # "$HOME/.config/memo/templates"

  # nvim
  ln -sfn "$DOTFILES_PATH/config/nvim" "$HOME/.config/nvim"

  # git
  ln -sfn "$DOTFILES_PATH/config/git" "$HOME/.config/git"

  # tmux
  ln -sfn "$DOTFILES_PATH/config/tmux.conf" "$HOME/.config/tmux/tmux.conf"

  # memo(https://github.com/mattn/memo), mamolist.vim(https://github.com/glidenote/memolist.vim)
  # ln -sfn "$DOTFILES_PATH/config/memo/config.toml"      "$HOME/.config/memo/config.toml"
  # ln -sfn "$DOTFILES_PATH/config/memo/templates/md.txt" "$HOME/.config/memo/templates/md.txt"
  # ln -sfn "$DOTFILES_PATH/config/memo/plugins/commit"   "$HOME/.config/memo/plugins/commit"

  # starship
  ln -sfn "$DOTFILES_PATH/config/starship.toml" "$HOME/.config/starship.toml"

  # wezterm
  # ln -sfn "$DOTFILES_PATH/config/wezterm" "$HOME/.config/wezterm"

  # ghostty
  ln -sfn "$DOTFILES_PATH/config/ghostty" "$HOME/.config/ghostty"

  # zsh
  ln -sfn "$DOTFILES_PATH/config/zpreztorc" "$HOME/.zpreztorc"
  ln -sfn "$DOTFILES_PATH/config/zshrc"     "$HOME/.zshrc"

  # if [ $(uname -s) = "Darwin" ]; then
  #   # hammerspoon
  #   ln -sfn "$DOTFILES_PATH/config/hammerspoon" "$HOME/.hammerspoon"
  # fi
}

main() {
  download_repository && \
    link_rc && \
    echo "Success!! Then install any tools and languages you want."
}

main "$@" && exit 0;
