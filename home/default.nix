{
  inputs,
  username,
  homeDir,
  ...
}:
{
  home.username = username;
  home.homeDirectory = homeDir;

  home.stateVersion = "25.11";

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  programs.nix-index-database.comma.enable = true;

  imports = [
    inputs.nix-index-database.homeModules.default
    ./theme.nix
    ./packages.nix
    ./git.nix
    ./eza.nix
    ./bat.nix
    ./starship.nix
    ./tmux.nix
    # ./herdr.nix
    ./nh.nix
    ./nvim.nix
    ./zsh.nix
    ./fzf.nix
    ./go.nix
    ./direnv.nix
    ./iterm2.nix
  ];
}
