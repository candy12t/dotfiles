{ inputs, ... }:
{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };

  system = {
    stateVersion = 6;
    configurationRevision = inputs.rev or inputs.dirtyRev or null;
    primaryUser = "candy12t";
  };

  users.users.candy12t = {
    home = "/Users/candy12t";
    name = "candy12t";
  };

  nix.enable = false;

  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
  };
}
