{ pkgs, ... }:
{
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    cdpath = [
      "."
      "$HOME"
      "$(ghq root)/github.com/candy12t"
      "$(ghq root)/github.com"
      ".."
    ];
    initContent = ''
      zstyle ':completion:*' menu select

      download() { curl -fsSL "$1" -O }

      fq() {
        local repo="$(ghq list | fzf)"
        [ -n "$repo" ] && cd "$(ghq list --full-path -exact "$repo")"
      }

      ff() {
        [ $(pwd) = $HOME ] && echo "current directory is HOME. change any directory" >&2 && return
        local files="$(rg --files --hidden --follow --glob '!.git' | fzf -m --preview 'bat --color=always {}')"
        [ -n "$files" ] && echo "$files" | xargs $EDITOR
      }

      fr() {
        [ $(pwd) = $HOME ] && echo "current directory is HOME. change any directory" >&2 && return
        local files="$(rg -n \'\' | fzf -m --delimiter : --preview 'bat --color=always --highlight-line {2} {1}' --preview-window '+{2}+3/3' | awk -F: '{print $1}')"
        [ -n "$files" ] && echo "$files" | xargs $EDITOR
      }
    '';
    shellAliases = {
      g = "git";
      t = "tmux";
      ":q" = "exit";
      gcd = "cd \"$(git rev-parse --show-toplevel)\"";
      cat = "bat";
      diff = "delta";
      dig = "doggo";
      ls = "eza --classify=auto";
      la = "eza --all --classify=auto";
      ll = "eza --all --binary --classify=auto --group --header --long";
      tree = "eza --all --binary --classify=auto --group --header --long --tree --ignore-glob=\".git|.node_modules\"";
    };
    plugins = [
      {
        name = "zsh-forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
        completions = [
          "share/zsh/site-functions/_git-forgit"
        ];
      }
    ];
  };
}
