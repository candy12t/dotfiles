{ ... }:
{
  imports = [
    ./users.nix
    ./system-defaults.nix
    ./nix.nix
    ./nh.nix
    ./security.nix
    ./homebrew.nix
    ./home-manager.nix
  ];

  system = {
    stateVersion = 6;
  };

  time = {
    timeZone = "Asia/Tokyo";
  };
}
