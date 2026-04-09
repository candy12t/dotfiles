{ pkgs, ... }:

let
  tokyonight = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
    sha256 = "sha256-a9iRWue7DB7s/wNdxqqB51Jya5P9X6sDftqhdmKggU0=";
  };
in
{
  programs.tmux = {
    enable = true;
    prefix = "C-t";
    terminal = "screen-256color";
    historyLimit = 10000;
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;
    aggressiveResize = true;
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";

    extraConfig = ''
      # select pane
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # resize pane
      bind -r H resize-pane -L 3
      bind -r J resize-pane -D 3
      bind -r K resize-pane -U 3
      bind -r L resize-pane -R 3

      # split pane
      bind v split-window -h -c '#{pane_current_path}'
      bind s split-window -v -c '#{pane_current_path}'

      # create new window
      bind c new-window -c '#{pane_current_path}'

      # copy mode
      bind y copy-mode
      if-shell '[ "$(uname -s)" = "Darwin" ]' { set -s copy-command "pbcopy" }
      if-shell '[ "$(uname -s)" = "Linux" ]' { set -s copy-command "xsel --clipboard --input" }
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-pipe-and-cancel
      bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel

      # kill pane
      bind q kill-pane

      # status bar
      set-option -g status-position top

      # colorscheme
      source-file ${tokyonight}/extras/tmux/tokyonight_moon.tmux
      set -g @prefix_highlight_output_prefix "#[fg=#82aaff]#[bg=#1e2030]#[fg=#1e2030]#[bg=#82aaff]"

      # prefix-highlight (must be loaded after colorscheme sets status-right with #{prefix_highlight})
      run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
    '';
  };
}
