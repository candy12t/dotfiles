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

  mkdir -p "$HOME/.config" \
    "$HOME/.config/tmux"
    # "$HOME/.config/memo" \
    # "$HOME/.config/memo/plugins" \
    # "$HOME/.config/memo/templates"

  # bat
  ln -sfn "$DOTFILES_PATH/config/bat" "$HOME/.config/bat"

  # efm-langserver
  ln -sfn "$DOTFILES_PATH/config/efm-langserver" "$HOME/.config/efm-langserver"

  # ghostty
  # ln -sfn "$DOTFILES_PATH/config/ghostty" "$HOME/.config/ghostty"

  # git
  ln -sfn "$DOTFILES_PATH/config/git" "$HOME/.config/git"

  # hammerspoon
  # if [ $(uname -s) = "Darwin" ]; then
  #   ln -sfn "$DOTFILES_PATH/config/hammerspoon" "$HOME/.hammerspoon"
  # fi

  # memo(https://github.com/mattn/memo), mamolist.vim(https://github.com/glidenote/memolist.vim)
  # ln -sfn "$DOTFILES_PATH/config/memo/config.toml"      "$HOME/.config/memo/config.toml"
  # ln -sfn "$DOTFILES_PATH/config/memo/templates/md.txt" "$HOME/.config/memo/templates/md.txt"
  # ln -sfn "$DOTFILES_PATH/config/memo/plugins/commit"   "$HOME/.config/memo/plugins/commit"

  # nvim
  ln -sfn "$DOTFILES_PATH/config/nvim" "$HOME/.config/nvim"

  # wezterm
  # ln -sfn "$DOTFILES_PATH/config/wezterm" "$HOME/.config/wezterm"

  # zsh
  ln -sfn "$DOTFILES_PATH/config/zsh/zpreztorc" "$HOME/.zpreztorc"
  ln -sfn "$DOTFILES_PATH/config/zsh/zshrc"     "$HOME/.zshrc"

  # starship
  ln -sfn "$DOTFILES_PATH/config/starship.toml" "$HOME/.config/starship.toml"

  # tmux
  ln -sfn "$DOTFILES_PATH/config/tmux.conf" "$HOME/.config/tmux/tmux.conf"

  # claude
  mkdir -p "$HOME/.claude"
  ln -sfn "$DOTFILES_PATH/config/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
  ln -sfn "$DOTFILES_PATH/config/claude/settings.json" "$HOME/.claude/settings.json"
}

main() {
  download_repository && \
    link_rc && \
    echo "Success!! Then install any tools and languages you want."
}

main "$@" && exit 0;
