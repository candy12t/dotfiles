{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    enable = true;
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-build-log = true;
      keep-derivations = false;
      keep-outputs = false;
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
