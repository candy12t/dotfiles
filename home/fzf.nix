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
  home.packages = with pkgs; [
    fd
    ripgrep
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --sort-files --hidden --column --line-number --no-heading --smart-case -g '!{.git,node_modules}/*'";
    defaultOptions = [
      "--height 60%"
      "--reverse"
    ];
  };

  programs.zsh.initContent = ''
    source ${tokyonight}/extras/fzf/tokyonight_moon.sh
  '';
}
