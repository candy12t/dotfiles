{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    # aws-sam-cli
    bash
    curl
    docker
    docker-buildx
    doggo
    gh
    ghq
    gnumake
    go
    # herdr
    htop
    jq
    # k6
    lima
    lua
    mycli
    mysql84
    nb
    nh
    openssl
    rtk
    ssm-session-manager-plugin
    w3m

    # 自作パッケージ（別 flake の package 出力を参照）
    inputs.kanade.packages.${pkgs.stdenv.hostPlatform.system}.default

    # nixpkgs 未提供のパッケージ（ローカル derivation）
    (pkgs.callPackage ../pkgs/mo.nix { })

    # font
    hackgen-nf-font

    # # misc
    # ffmpeg
    # yt-dlp
  ];
}
