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
    # herdr https://github.com/NixOS/nixpkgs/pull/536015 が取り込まれたらコメントアウト外す
    htop
    jq
    k6
    lima
    lua
    mycli
    mysql84
    nb
    rtk
    ssm-session-manager-plugin
    w3m

    # 自作パッケージ（別 flake の package 出力を参照）
    inputs.kanade.packages.${pkgs.stdenv.hostPlatform.system}.default

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
    ./herdr.nix
    ./nvim.nix
    ./zsh.nix
    ./fzf.nix
    ./go.nix
    ./direnv.nix
  ];
}
