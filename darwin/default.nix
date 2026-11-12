{ inputs, ... }:
{
  imports = [
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
