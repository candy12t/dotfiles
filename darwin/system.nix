{ inputs, ... }:
{
  system = {
    stateVersion = 6;
    configurationRevision = inputs.rev or inputs.dirtyRev or null;
  };

  nix.enable = false;

  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
  };
}
