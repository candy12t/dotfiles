{
  description = "My dotfiles";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanade = {
      url = "github:candy12t/kanade?ref=v0.1.2";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      ...
    }@inputs:
    let
      mkDarwinSystem =
        hostName: hostConfig:
        nix-darwin.lib.darwinSystem {
          system = hostConfig.system;
          specialArgs = {
            inherit inputs hostName;
            inherit (hostConfig) username homeDir;
          };
          modules = [
            ./darwin
            ./profiles/${hostConfig.profile}
          ];
        };
    in
    {
      darwinConfigurations = builtins.mapAttrs mkDarwinSystem (import ./hosts);
    };
}
