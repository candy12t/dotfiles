{ pkgs, tokyonightSrc, ... }:
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
    source ${tokyonightSrc}/extras/fzf/tokyonight_moon.sh
  '';
}
