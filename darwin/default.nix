{ inputs, ... }:
{
  imports = [
    inputs.nix-index-database.darwinModules.nix-index
    ./users.nix
    ./system-defaults.nix
    ./nix.nix
    ./security.nix
    ./homebrew.nix
    ./home-manager.nix
    ./llm-agents.nix
  ];

  system = {
    stateVersion = 6;
    configurationRevision = inputs.rev or inputs.dirtyRev or null;
  };

  time = {
    timeZone = "Asia/Tokyo";
  };
}
