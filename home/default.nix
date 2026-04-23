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

  john = pkgs.john.overrideAttrs (old: {
    version = "bleeding-jumbo-2026-04-12";
    src = pkgs.fetchFromGitHub {
      owner = "openwall";
      repo = "john";
      rev = "f514ece8ec4ae5e38ad75aaa322eac86d73dcd76";
      sha256 = "sha256-Fzt9KnMFBTdPpQMSlXe/zG9LMylAZnC6uzU4yJ6HSUk=";
    };
    patches = [ ];
  });
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
    direnv
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

    # font
    hackgen-nf-font

    # # ctf
    # aircrack-ng
    # binwalk
    # # burpsuite
    # exiftool
    # exploitdb
    # foremost
    # gdb
    # ghidra-bin
    # hashcat
    # john
    # keepassxc
    # nmap
    # rustscan
    # weechat
    # wireshark

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
  ];
}
