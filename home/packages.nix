{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    bash
    curl
    docker
    docker-buildx
    doggo
    gh
    ghq
    gnumake
    # herdr
    htop
    jq
    lima
    lua
    mycli
    mysql84
    nb
    openssl
    rtk
    unzip
    w3m

    # 別 flake の package 出力を参照
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
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
