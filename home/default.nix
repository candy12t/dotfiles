{
  inputs,
  pkgs,
  username,
  homeDir,
  ...
}:

{
  home.username = username;
  home.homeDirectory = homeDir;

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    comma
    curl
    direnv
    docker
    docker-buildx
    doggo
    gh
    ghq
    go
    htop
    jq
    lima
    lua
    mycli
    mysql84
    nb
    rustup

    # font
    hackgen-nf-font
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
