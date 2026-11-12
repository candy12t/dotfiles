{ username, ... }:
{
  imports = [
    ./darwin.nix
  ];

  home-manager.users.${username}.imports = [
    ./home.nix
  ];
}
