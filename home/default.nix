{
  inputs,
  pkgs,
  username,
  homeDir,
  ...
}:

let
  tokyonightSrc = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
    sha256 = "sha256-a9iRWue7DB7s/wNdxqqB51Jya5P9X6sDftqhdmKggU0=";
  };
in
{
  _module.args.tokyonightSrc = tokyonightSrc;

  home.username = username;
  home.homeDirectory = homeDir;

  home.stateVersion = "25.11";

  home.sessionVariables = {
  };

  home.packages = with pkgs; [
    awscli2
    aws-sam-cli
    bash
    comma
    curl
    docker
    docker-buildx
    doggo
    gh
    ghq
    gnumake
    go
    htop
    jq
    k6
    lima
    lua
    mycli
    mysql84
    nb
    rustup
    ssm-session-manager-plugin
    w3m

    # font
    hackgen-nf-font

    # # misc
    # ffmpeg
    # yt-dlp
  ];

  programs.home-manager.enable = true;

  imports = [
    inputs.nix-index-database.homeModules.default
    ./git.nix
    ./eza.nix
    ./bat.nix
    ./starship.nix
    ./tmux.nix
    ./nvim.nix
    ./zsh.nix
    ./fzf.nix
    ./go.nix
    ./direnv.nix
  ];
}
